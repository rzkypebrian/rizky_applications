import 'dart:convert';
import 'dart:ui' as ui;
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/fileServiceUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';

class SignatureComponent extends StatelessWidget {
  final SignatureComponentController controller;
  final ValueWidgetBuilder<SignatureComponentValue> builder;
  final VoidCallback onSign;
  final double strokeWidth;
  final CustomPainter backgroundPainter;

  const SignatureComponent({
    Key key,
    this.controller,
    this.onSign,
    this.builder,
    this.strokeWidth = 2.0,
    this.backgroundPainter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<SignatureComponentValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return Stack(
          children: [
            builder != null
                ? builder(context, value, signaturePad(value))
                : Container(
                    width: double.infinity,
                    child: Container(
                      child: signaturePad(value),
                    ),
                  ),
            value.onProgressUpload == false
                ? value.isUploaded
                    ? Container(
                        color: Colors.white.withOpacity(0.2),
                        child: Stack(
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: controller.delete,
                                child: Container(
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: value.isError
                                          ? Colors.red
                                          : Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.delete,
                                      color: value.isError
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            value.isError
                                ? Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 20,
                                      width: double.infinity,
                                      color: Colors.red,
                                      child: Center(
                                          child: Text(
                                        "${System.data.resource.uploadFailed}",
                                        style:
                                            System.data.textStyleUtil.mainLabel(
                                          color: System
                                              .data.colorUtil.lightTextColor,
                                        ),
                                      )),
                                    ),
                                  )
                                : SizedBox()
                          ],
                        ),
                      )
                    : SizedBox()
                : Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white.withOpacity(0.2),
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        width: MediaQuery.of(context).size.width,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          color: Colors.white,
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: System.data.colorUtil.primaryColor,
                            width: 1,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.all(1),
                            width: MediaQuery.of(context).size.width *
                                controller.percentageUpload /
                                100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              color: System.data.colorUtil.primaryColor,
                              border: Border.all(
                                style: BorderStyle.solid,
                                color: System.data.colorUtil.primaryColor,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        );
      },
    );
  }

  Widget signaturePad(SignatureComponentValue value) {
    return Signature(
      color: Colors.black, // Color of the drawing path
      strokeWidth: 2.0, // with
      backgroundPainter:
          backgroundPainter, // Additional custom painter to draw stuff like watermark
      onSign: () {
        controller.onSign(onSign);
      }, // Callback called on user pan drawing
      key: value
          .sign, // key that allow you to provide a GlobalKey that'll let you retrieve the image once user has signed
    );
  }
}

class SignatureComponentController
    extends ValueNotifier<SignatureComponentValue> {
  SignatureComponentController({SignatureComponentValue value})
      : super(value == null ? SignatureComponentValue() : value);

  static const baseImageEncoder = "data:image/png;base64,";

  void setState(VoidCallback fn) {
    fn();
    notifyListeners();
  }

  void clear() {
    value.sign.currentState.clear();
    value.base64File = "";
    value.isSigngatured = false;
    notifyListeners();
  }

  void onSign(VoidCallback onSignProses) {
    value.isSigngatured = true;
    notifyListeners();
    readData().then((onValue) {
      if (onSignProses != null) onSignProses();
    });
  }

  Future<bool> readData() async {
    var image = await value.sign.currentState.getData();
    value.byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    value.image = Image.memory(value.byteData.buffer.asUint8List());
    value.base64File =
        baseImageEncoder + base64.encode(value.byteData.buffer.asUint8List());
    notifyListeners();
    if (value.base64File == baseImageEncoder) {
      return false;
    } else {
      return true;
    }
  }

  String get getBase64 {
    if (value.isSigngatured) {
      return value.base64File;
    } else {
      return "";
    }
  }

  ByteData get getByteData {
    if (value.isSigngatured) {
      return value.byteData;
    } else {
      return null;
    }
  }

  double get percentageUpload {
    return (value.fileSize == 0
            ? 0
            : (value.uploadedSize / value.fileSize) * 100)
        .toDouble();
  }

  void setUploadedUrl({String jsonKey}) {
    try {
      value.uploadedUrl =
          json.decode(value.uploadedResponse.toString())[jsonKey ?? "fileUrl"];
    } catch (e) {}
  }

  void setUploadedId({String jsonKey}) {
    try {
      value.uploadedId =
          json.decode(value.uploadedResponse.toString())[jsonKey ?? "imageId"];
    } catch (e) {}
  }

  void upload(
    String url, {
    String field,
    String token,
    ValueChanged<String> onUploaded,
    ValueChanged<dynamic> onUploaderror,
  }) async {
    if (value.isSigngatured == null) {
      // _showSnackBar("Select file first");
      return;
    }

    // _setUploadProgress(0, 0);

    try {
      // var httpResponse = await FileService.fileUpload(
      //     file: file, onUploadProgress: _setUploadProgress);
      value.uploadedSize = 0;
      value.fileSize = 0;
      notifyListeners();

      await FileServiceUtil.byteDataUploadMultipart(
        field: field,
        byteData: value.byteData,
        url: url,
        token: token,
        onUploadProgress: (
          uploaded,
          fileSize,
        ) {
          value.onProgressUpload = true;
          value.uploadedSize = uploaded;
          value.fileSize = fileSize;
          print(
              "process... ${value.uploadedSize} ${value.fileSize} $percentageUpload");
          notifyListeners();
        },
      ).then((result) {
        value.uploadedSize = 0;
        value.fileSize = 0;
        value.onProgressUpload = false;
        value.isUploaded = true;
        value.uploadedResponse = result;
        setUploadedUrl();
        setUploadedId();
        // value.state = ImagePickerComponentState.Enable;
        value.isError = false;
        if (onUploaded != null) onUploaded(result);
        notifyListeners();
      }).catchError((e) {
        print(e.toString());
        value.onProgressUpload = false;
        value.isUploaded = true;
        value.isError = true;
        // value.state = ImagePickerComponentState.Error;
        notifyListeners();
        if (onUploaderror != null) onUploaderror(e);
      });
    } catch (e) {
      // _showSnackBar(e.toString());
      print(e.toString());
    }
  }

  void delete() {
    value.onProgressUpload = false;
    value.isUploaded = false;
    value.isError = false;
    notifyListeners();
  }
}

class SignatureComponentValue {
  final sign = GlobalKey<SignatureState>();
  ByteData byteData;
  Image image;
  String base64File;
  bool isSigngatured = false;
  bool onProgressUpload = false;
  int uploadedSize = 0;
  int fileSize = 0;
  bool isUploaded = false;
  String uploadedResponse;
  String uploadedUrl;
  dynamic uploadedId;
  bool isError = false;
  String errorMessage;

  SignatureComponentValue({
    this.base64File = "",
    this.isSigngatured = false,
  });
}
