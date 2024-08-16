import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class CgPicker extends StatelessWidget {
  final CgPickerController cgPickerController;
  final Widget childs;
  final double radius;
  final bool circular;
  final double width;
  final double height;
  final VoidCallback onTap;

  const CgPicker({
    Key key,
    this.cgPickerController,
    this.childs,
    this.radius = 100,
    this.circular = true,
    this.width = 100,
    this.height = 100,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CgPickerValue>(
      valueListenable: cgPickerController,
      builder: (context, value, child) {
        return Container(
          child: (value.loadData)
              ? circular
                  ? Container(
                      width: width,
                      height: height,
                      child: CircleAvatar(
                          backgroundImage:
                              MemoryImage(value.valueUri.contentAsBytes()),
                          radius: radius,
                          child: childs

                          // child: Center(
                          //   child: IconButton(
                          //     onPressed: () => onTap(),
                          //     icon: Icon(Icons.camera),
                          //   ),
                          // ),
                          ),
                    )
                  : Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: MemoryImage(value.valueUri.contentAsBytes()),
                        ),
                        borderRadius: BorderRadius.circular(radius),
                      ),
                      child: childs
                      // Center(
                      //   child: IconButton(
                      //     onPressed: () => onTap(),
                      //     icon: Icon(Icons.camera),
                      //   ),
                      // ),
                      )
              : Container(),
        );
      },
    );
  }
}

class CgPickerController extends ValueNotifier<CgPickerValue> {
  CgPickerController({CgPickerValue value})
      : super(value == null ? CgPickerValue() : value);

  String getExtension(String string) {
    List<String> getList = string.split(".");
    String data = getList.last.replaceAll("'", "");
    String result;
    if (data == "png") {
      result = "data:image/png;base64,";
    } else if (data == "jpeg") {
      result = "data:image/jpeg;base64,";
    } else if (data == "jpg") {
      result = "data:image/jpg;base64,";
    } else if (data == "gif") {
      result = "data:image/gif;base64,";
    }
    return result;
  }

  Future<bool> getImages() async {
    var picker = value.camera
        ? await ImagePicker().pickImage(
            source: ImageSource.camera) //getImage(source: ImageSource.camera)
        : await ImagePicker().pickImage(
            source:
                ImageSource.gallery); //getImage(source: ImageSource.gallery);

    var image = File(picker.path);

    String _valueBase64Compress = "";
    value.fileImage = image;
    value.base64 =
        getExtension(image.toString()) + base64.encode(image.readAsBytesSync());
    notifyListeners();

    return await FlutterImageCompress.compressWithFile(
      image.absolute.path,
      quality: value.quality,
    ).then((a) {
      _valueBase64Compress = getExtension(image.toString()) + base64.encode(a);
      value.base64Compress = _valueBase64Compress;
      value.loadData = true;
      value.valueUri = Uri.parse(_valueBase64Compress).data;
      getBase64();
      notifyListeners();
      return true;
    }).catchError((e) {
      value.error = e;
      notifyListeners();
      return false;
    });
  }

  String getBase64() {
    return value.base64;
  }

  String getBase64Compress() {
    return value.base64Compress;
  }

  File getFile() {
    return value.fileImage;
  }

  List<Object> getAll() {
    List<Object> list = [value.base64, value.base64Compress, value.fileImage];
    return list;
  }

  void disposes() {
    value.loadData = false;
    value.valueUri = null;
    value.base64Compress = null;
    value.base64 = null;
    value.fileImage = null;
    value.error = null;
    notifyListeners();
  }
}

class CgPickerValue {
  bool camera;
  bool loadData;
  String base64Compress;
  String base64;
  UriData valueUri;
  File fileImage;
  int quality;
  String error;

  CgPickerValue({
    this.camera = true,
    this.loadData = false,
    this.base64Compress,
    this.base64,
    this.quality = 80,
    this.valueUri,
    this.error,
  });
}
