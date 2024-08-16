import 'dart:convert';
import 'dart:io';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/util/EnvironmentUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:enerren/util/fileServiceUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:enerren/util/StringExtention.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
// import 'package:intl/intl.dart';

class ImagePickerComponent extends StatelessWidget {
  final ImagePickerController controller;
  final bool camera;
  final bool galery;
  final WidgetFromDataBuilder2<WidgetBuilder, ImagePickerValue> container;
  final WidgetFromDataBuilder<ImagePickerValue> placeHolderContainer;
  final WidgetFromDataBuilder<ImagePickerValue> imageContainer;
  final WidgetFromDataBuilder<VoidCallback> buttonCamera;
  final WidgetFromDataBuilder<VoidCallback> buttonGalery;
  final WidgetFromDataBuilder2<VoidCallback, VoidCallback> popUpChild;
  final Alignment popUpAlign;
  final BoxDecoration popUpDecoration;
  final EdgeInsets popUpMargin;
  final EdgeInsets popUpPadding;
  final double popUpHeight;
  final double popUpWidth;
  final ValueChanged<ImagePickerController> onTap;
  final bool readOnly;
  final double containerHeight;
  final double containerWidth;
  final int imageQuality;
  final String uploadUrl;
  final String uploadField;
  final String deleteUrl;
  final String token;
  final ValueChanged<String> onUploaded;
  final ValueChanged<dynamic> onUploadFailed;
  final WidgetFromDataBuilder<CircularProgressIndicatorController>
      circularProgressIndicatorDecorationBuilder;
  final bool checkRequirement;
  final int minimumMemoryRequirement;
  final int minimumDiskRequrement;
  final int minimumBatteryRequrement;
  final ValueChanged<File> onImageLoaded;

  const ImagePickerComponent({
    Key key,
    this.controller,
    this.camera = true,
    this.galery = true,
    this.container,
    this.placeHolderContainer,
    this.imageContainer,
    this.buttonCamera,
    this.buttonGalery,
    this.popUpChild,
    this.popUpAlign,
    this.popUpDecoration,
    this.popUpMargin,
    this.popUpPadding,
    this.popUpHeight,
    this.popUpWidth,
    this.onTap,
    this.readOnly = false,
    @required this.containerHeight,
    @required this.containerWidth,
    this.imageQuality,
    this.uploadUrl,
    this.deleteUrl,
    this.uploadField,
    this.onUploaded,
    this.token,
    this.onUploadFailed,
    this.circularProgressIndicatorDecorationBuilder,
    this.checkRequirement = true,
    this.minimumMemoryRequirement = 500,
    this.minimumDiskRequrement = 500,
    this.minimumBatteryRequrement = 10,
    this.onImageLoaded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ImagePickerValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        controller.value.context = context;
        return GestureDetector(
          onTap: readOnly == false
              ? onTap != null
                  ? () {
                      onTap(controller);
                    }
                  : () {
                      if (!checkRequirement) return;
                      memorySpaceCheck(context).then((result) {
                        if (result == true) {
                          if (value.state !=
                              ImagePickerComponentState.Disable) {
                            if (camera == true && galery == true) {
                              openModal(context);
                            } else if (camera == true) {
                              controller.getImages(
                                  camera: true,
                                  imageQuality: imageQuality,
                                  onImageLoaded: onImageLoaded);
                            } else if (galery == true) {
                              controller.getImages(
                                  camera: false,
                                  imageQuality: imageQuality,
                                  onImageLoaded: onImageLoaded);
                            }
                          }
                        }
                      });
                    }
              : () {},
          child: container != null
              ? container((context) {
                  return widgetBuilder(value);
                }, value)
              : Center(
                  child: Container(
                    height: containerHeight ?? 100,
                    width: containerWidth ?? 100,
                    child: Center(
                      child: widgetBuilder(value),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: stateColor(value.state),
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }

  void openModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 1,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.red.withOpacity(0),
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop("modal");
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.0),
            child: Align(
              alignment: popUpAlign ?? Alignment.bottomCenter,
              child: Container(
                height: popUpHeight ?? 170,
                width: popUpWidth ?? double.infinity,
                margin: popUpMargin ?? popUpAlign == Alignment.center
                    ? EdgeInsets.only(left: 10, right: 20)
                    : null,
                padding: popUpPadding ?? EdgeInsets.all(20),
                decoration: popUpDecoration ??
                    BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: popUpAlign == Alignment.center
                            ? Radius.circular(20)
                            : Radius.zero,
                        bottomRight: popUpAlign == Alignment.center
                            ? Radius.circular(20)
                            : Radius.zero,
                      ),
                    ),
                child: popUpChild != null
                    ? popUpChild(() {
                        openCamera(context);
                      }, () {
                        openGalery(context);
                      })
                    : Column(
                        children: <Widget>[
                          Text(
                            "${System.data.resource.selectPhoto}",
                            style: System.data.textStyleUtil.linkLabel(),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          buttonCamera != null
                              ? buttonGalery(() {
                                  openGalery(context);
                                })
                              : Container(
                                  height: 35,
                                  width: 200,
                                  child: BottonComponent.roundedButton(
                                    onPressed: () {
                                      openCamera(context);
                                    },
                                    colorBackground:
                                        System.data.colorUtil.primaryColor,
                                    text: System.data.resource.camera,
                                    textstyle:
                                        System.data.textStyleUtil.mainLabel(
                                      color:
                                          System.data.colorUtil.lightTextColor,
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          buttonGalery != null
                              ? buttonGalery(() {
                                  openGalery(context);
                                })
                              : Container(
                                  height: 35,
                                  width: 200,
                                  child: BottonComponent.roundedButton(
                                    onPressed: () {
                                      openGalery(context);
                                    },
                                    colorBackground:
                                        System.data.colorUtil.primaryColor,
                                    text: System.data.resource.galery,
                                    textstyle:
                                        System.data.textStyleUtil.mainLabel(
                                      color:
                                          System.data.colorUtil.lightTextColor,
                                    ),
                                  ),
                                ),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  void openModalErrorMessage(
    BuildContext context, {
    String title,
    String body,
  }) {
    showModalBottomSheet(
      context: context,
      elevation: 1,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.red.withOpacity(0),
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop("modal");
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.0),
            child: Align(
              alignment: popUpAlign ?? Alignment.bottomCenter,
              child: Container(
                height: popUpHeight ?? 170,
                width: popUpWidth ?? double.infinity,
                margin: popUpMargin ?? popUpAlign == Alignment.center
                    ? EdgeInsets.only(left: 10, right: 20)
                    : null,
                padding: popUpPadding ?? EdgeInsets.all(20),
                decoration: popUpDecoration ??
                    BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: popUpAlign == Alignment.center
                            ? Radius.circular(20)
                            : Radius.zero,
                        bottomRight: popUpAlign == Alignment.center
                            ? Radius.circular(20)
                            : Radius.zero,
                      ),
                    ),
                child: Column(
                  children: <Widget>[
                    Text(
                      "$title",
                      style: System.data.textStyleUtil.linkLabel(
                        color: System.data.colorUtil.redColor,
                        fontSize: System.data.fontUtil.xl,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "$body",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void openGalery(BuildContext context) {
    Navigator.of(context).pop();
    if (!checkRequirement) return;
    memorySpaceCheck(context).then((result) {
      if (result == true) {
        controller.getImages(
            camera: false,
            imageQuality: imageQuality,
            onImageLoaded: onImageLoaded);
      }
    });
  }

  void openCamera(BuildContext context) {
    Navigator.of(context).pop();
    if (!checkRequirement) return;
    memorySpaceCheck(context).then((result) {
      if (result == true) {
        controller.getImages(
            camera: true,
            imageQuality: imageQuality,
            onImageLoaded: onImageLoaded);
      }
    });
  }

  static Color stateColor(ImagePickerComponentState state) {
    return state == ImagePickerComponentState.Disable
        ? System.data.colorUtil.disableColor
        : state == ImagePickerComponentState.Error
            ? System.data.colorUtil.errorColor
            : System.data.colorUtil.primaryColor;
  }

  Widget widgetBuilder(ImagePickerValue value) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: value.loadData
                ? !uploadUrl.isNullOrEmpty() && !value.isUploaded
                    ? prepearingUpload(value)
                    : immageWidget(value)
                : placeHolderContainer != null
                    ? placeHolderContainer(value)
                    : placeHolder(),
          ),
          circularProgressIndicatorDecorationBuilder != null
              ? circularProgressIndicatorDecorationBuilder(
                  value.loadingController)
              : circularProgressInicatorDecoration(value.loadingController)
        ],
      ),
    );
  }

  Widget circularProgressInicatorDecoration(
      CircularProgressIndicatorController loadingController) {
    return CircularProgressIndicatorComponent(
      controller: loadingController,
      aligment: Alignment.center,
    );
  }

  Widget prepearingUpload(ImagePickerValue value) {
    if (value.onProgressUpload == false &&
        value.state == ImagePickerComponentState.Enable) {
      controller.uploadFile(
        uploadUrl,
        uploadField,
        token: token,
        onUploaded: (resut) {
          if (onUploaded != null) {
            onUploaded(resut);
          } else {
            ModeUtil.debugPrint("Upload Success");
            ModeUtil.debugPrint(resut);
          }
        },
        onUploaderror: (onError) {
          if (onUploadFailed != null) {
            onUploadFailed(onError);
          } else {
            ModeUtil.debugPrint("Upload Success");
            ModeUtil.debugPrint(onError);
          }
        },
      );
    }
    return uploadProgressWidget(value);
  }

  Widget uploadProgressWidget(ImagePickerValue value) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(
                  left: (containerWidth ?? 100) * 10 / 100,
                  right: (containerWidth ?? 100) * 10 / 100),
              padding: EdgeInsets.all(2),
              width: containerWidth,
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  border: Border.all(
                    color: System.data.colorUtil.primaryColor,
                    width: 1,
                  )),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: Duration(
                    milliseconds: value.onProgressUpload ? 500 : 1,
                  ),
                  width: containerWidth * (controller.percentageUpload / 100),
                  decoration: BoxDecoration(
                    color: value.state != ImagePickerComponentState.Error
                        ? Colors.green
                        : System.data.colorUtil.errorColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: value.state == ImagePickerComponentState.Error
                ? Container(
                    margin:
                        EdgeInsets.only(top: (containerHeight ?? 100) / 2 + 15),
                    child: Text(
                      System.data.resource.uploadFailed,
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.errorColor,
                        fontSize: System.data.fontUtil.xsPlus,
                      ),
                    ),
                  )
                : SizedBox(),
          )
        ],
      ),
    );
  }

  Widget immageWidget(ImagePickerValue value) {
    return imageContainer != null
        ? imageContainer(value)
        : value.uploadedUrl.isNullOrEmpty()
            ? memoryImageMode(value)
            : networkImageMode(value);
  }

  Widget memoryImageMode(ImagePickerValue value) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: MemoryImage(value.valueUri.contentAsBytes()),
        ),
      ),
    );
  }

  Widget networkImageMode(ImagePickerValue value) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(value.uploadedUrl),
        ),
      ),
    );
  }

  Widget placeHolder() {
    return placeHolderContainer ??
        Icon(
          Icons.camera_alt,
          color: Colors.grey,
          size: 50,
        );
  }

  Future<bool> memorySpaceCheck(BuildContext context) {
    controller.value.loadingController.startLoading();
    bool result = true;
    return EnvironmentUtil.readDevice.then((value) {
      controller.value.loadingController.stopLoading();
      if (value.os == "Android") {
        print("memory ${value.memory.freeMemory} < $minimumMemoryRequirement");
        if (value.memory.freeMemory < minimumMemoryRequirement) {
          openModalErrorMessage(context,
              title: System.data.resource.notEnoughMemory,
              body:
                  "${minimumMemoryRequirement / 1000} GB ${System.data.resource.ofmemoryisrequiredtorunthisprocess}, ${value.memory.freeMemory / 1000} GB ${System.data.resource.ofmemoryremains}");
          result = false;
        }
      }
      // print("disk ${value.diskSpace.free ?? 0} < $minimumDiskRequrement");
      // if (value.diskSpace.free ?? 0 < minimumDiskRequrement) {
      //   openModalErrorMessage(context,
      //       title: System.data.resource.notEnoughDisk,
      //       body:
      //           "${minimumDiskRequrement / 1000} GB ${System.data.resource.ofDiskRequiredtorunthisprocess}, ${NumberFormat("#.##").format(value.diskSpace.free ?? 0 / 1000)} GB ${System.data.resource.ofdiskremain}");
      //   result = false;
      // }
      print("battery  ${value.battrey}");
      if (value.battrey < minimumBatteryRequrement) {
        openModalErrorMessage(context,
            title: System.data.resource.batteryLow,
            body:
                "${System.data.resource.pleaseConnectTheDevicetoApowerSource}");
        result = false;
      }
      return result;
    }).catchError((onError) {
      openModalErrorMessage(
        context,
        title: "${System.data.resource.checkingMemorySpaceError}",
        body: "$onError",
      );
      return false;
    });
  }
}

class ImagePickerController extends ValueNotifier<ImagePickerValue> {
  ImagePickerController({ImagePickerValue value})
      : super(value == null ? ImagePickerValue() : value);

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

  /// The `imageQuality` argument modifies the quality of the image, ranging from 0-100
  /// where 100 is the original/max quality. If `imageQuality` is null, the image with
  /// the original quality will be returned. Compression is only supportted for certain
  /// image types such as JPEG. If compression is not supported for the image that is picked,
  /// an warning message will be logged.
  Future<bool> getImages({
    bool camera = true,
    int imageQuality = 30,
    ValueChanged<File> onImageLoaded,
  }) async {
    try {
      PickedFile picker;
      if (camera) {
        picker = await ImagePicker()
            // ignore: deprecated_member_use
            .getImage(source: ImageSource.camera, imageQuality: imageQuality);
      } else {
        picker = await ImagePicker()
            // ignore: deprecated_member_use
            .getImage(source: ImageSource.gallery, imageQuality: imageQuality);
      }

      File image = File(picker.path);

      String _valueBase64Compress = "";
      value.fileImage = image;
      value.base64 = getExtension(image.toString()) +
          base64.encode(image.readAsBytesSync());
      notifyListeners();

      return await FlutterImageCompress.compressWithFile(
        image.absolute.path,
        quality: value.quality,
      ).then((a) {
        _valueBase64Compress =
            getExtension(image.toString()) + base64.encode(a);
        value.base64Compress = _valueBase64Compress;
        value.loadData = true;
        value.valueUri = Uri.parse(_valueBase64Compress).data;
        value.isUploaded = false;
        value.state = ImagePickerComponentState.Enable;
        getBase64();
        notifyListeners();
        if (onImageLoaded != null) {
          onImageLoaded(value.fileImage);
        }
        return true;
      }).catchError((e) {
        value.error = e;
        notifyListeners();
        return false;
      });
    } catch (e) {
      ModeUtil.debugPrint("error on get picture");
      return false;
    }
  }

  String getBase64() {
    return value.base64;
  }

  UriData getUriData() {
    return value.valueUri;
  }

  String getBase64Compress() {
    return value.base64Compress;
  }

  File getFile() {
    return value.fileImage;
  }

  void clear() {
    value.fileImage = null;
    value.base64 = null;
    value.base64Compress = null;
    notifyListeners();
  }

  List<Object> getAll() {
    List<Object> list = [value.base64, value.base64Compress, value.fileImage];
    return list;
  }

  String getFileName() {
    List<String> getList = value.fileImage.toString().split("-");
    String data = getList.last.replaceAll("'", "");
    return data == "null" ? "" : data;
  }

  set state(ImagePickerComponentState state) {
    value.state = state;
    notifyListeners();
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

  bool validate() {
    bool _isValid = getBase64().isNullOrEmpty() ? false : true;
    _isValid = _isValid == false
        ? value.uploadedUrl.isNullOrEmpty()
            ? false
            : true
        : _isValid;
    if (_isValid && value.isUploaded) {
      value.state = ImagePickerComponentState.Enable;
      commit();
      return true;
    } else {
      value.state = ImagePickerComponentState.Error;
      commit();
      return false;
    }
  }

  double get percentageUpload {
    return (value.fileSize == 0
            ? 0
            : (value.uploadedSize / value.fileSize) * 100)
        .toDouble();
  }

  void uploadFile(
    String url,
    String field, {
    String token,
    ValueChanged<String> onUploaded,
    ValueChanged<dynamic> onUploaderror,
  }) async {
    if (value.fileImage == null) {
      // _showSnackBar("Select file first");
      return;
    }

    // _setUploadProgress(0, 0);

    try {
      // var httpResponse = await FileService.fileUpload(
      //     file: file, onUploadProgress: _setUploadProgress);
      print("upload url... $url");
      value.uploadedSize = 0;
      value.fileSize = 0;
      value.isUploaded = false;
      commit();
      await FileServiceUtil.fileUploadMultipart(
        field: field,
        file: value.fileImage,
        url: url,
        token: token,
        onUploadProgress: (
          uploaded,
          fileSize,
        ) {
          value.onProgressUpload = true;
          value.uploadedSize = uploaded;
          value.fileSize = fileSize;
          value.state = ImagePickerComponentState.Disable;
          print(
              "process... ${value.uploadedSize} ${value.fileSize} $percentageUpload");
          commit();
        },
      ).then((result) {
        value.uploadedSize = 0;
        value.fileSize = 0;
        value.onProgressUpload = false;
        value.isUploaded = true;
        value.uploadedResponse = result;
        setUploadedUrl();
        setUploadedId();
        value.state = ImagePickerComponentState.Enable;
        onUploaded(result);
        commit();
      }).catchError((e) {
        print(e.toString());
        value.isUploaded = false;
        value.onProgressUpload = false;
        value.state = ImagePickerComponentState.Error;
        commit();
        if (onUploaderror != null) onUploaderror(e);
      });
    } catch (e) {
      // _showSnackBar(e.toString());
      print(e.toString());
    }
  }

  void setUploadedUrl({String jsonKey}) {
    value.uploadedUrl =
        json.decode(value.uploadedResponse.toString())[jsonKey ?? "fileUrl"];
  }

  void setUploadedId({String jsonKey}) {
    value.uploadedId =
        json.decode(value.uploadedResponse.toString())[jsonKey ?? "imageId"];
  }

  void setState(VoidCallback fn) {
    fn();
    notifyListeners();
  }

  void commit() {
    notifyListeners();
  }
}

class ImagePickerValue {
  BuildContext context;
  bool loadData;
  bool isUploaded = true;
  bool onProgressUpload = false;
  dynamic uploadedResponse;
  String uploadedUrl;
  dynamic uploadedId;
  String base64Compress;
  String base64;
  UriData valueUri;
  File fileImage;
  int quality;
  String error;
  ImagePickerComponentState state;
  int uploadedSize = 0;
  int fileSize = 0;
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  ImagePickerValue({
    this.loadData = false,
    this.base64Compress,
    this.base64,
    this.quality = 25,
    this.valueUri,
    this.error,
    this.uploadedUrl,
    this.uploadedId,
    this.state = ImagePickerComponentState.Enable,
  }) {
    this.loadingController.stopLoading();
  }
}

enum ImagePickerComponentState {
  Enable,
  Disable,
  Error,
}
