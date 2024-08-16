import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class LiveCameraComponent extends StatelessWidget {
  final LiveCameraComponentController controller;
  final ValueWidgetBuilder<LiveCameraComponentValue> builder;
  final Widget placeHolder;

  LiveCameraComponent({
    this.controller,
    this.builder,
    this.placeHolder,
  });

  @override
  Widget build(BuildContext context) {
    controller.initialize();
    return ValueListenableBuilder<LiveCameraComponentValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return builder != null
            ? builder(context, value, component(value))
            : Container(
                color: Colors.red,
                height: double.infinity,
                width: double.infinity,
                // child: Text("${value.cameraController.value}"),
                child: component(value));
      },
    );
  }

  Widget component(LiveCameraComponentValue value) {
    return value.cameraController == null
        ? placeHolder != null
            ? placeHolder
            : Container(
                width: 0,
                height: 0,
              )
        : AspectRatio(
            aspectRatio: value.cameraController.value.aspectRatio,
            child: CameraPreview(value.cameraController));
  }
}

class LiveCameraComponentValue {
  bool onTakePicture;
  UriData image;
  File imageCamera;
  String imagePath;
  String base64Image;
  String base64Compressed;
  CameraController cameraController;
  bool takeCamera = false;
  List<int> imageBytes;

  LiveCameraComponentValue({
    this.onTakePicture = true,
    this.image,
    this.imagePath,
    this.base64Image,
    this.base64Compressed,
    this.takeCamera,
    this.imageCamera,
  });
}

class LiveCameraComponentController
    extends ValueNotifier<LiveCameraComponentValue> {
  LiveCameraComponentController({LiveCameraComponentValue value})
      : super(value == null ? LiveCameraComponentValue() : value);

  void initialize() {
    availableCameras().then((onValue) {
      if (onValue.length != 0) {
        value.cameraController =
            CameraController(onValue[1], ResolutionPreset.low);
        value.cameraController.initialize().then((_) {
          print(value.cameraController.value);
          notifyListeners();
        });
      }
    });
  }

  void setState(VoidCallback fn) {
    fn();
    notifyListeners();
  }

  void takePicture() {
    _takePicture().then((onValue) async {
      if (onValue != null) {
        value.imageCamera = File(onValue);
        value.base64Image = getExtension(value.imageCamera.toString()) +
            base64.encode(value.imageCamera.readAsBytesSync());
        value.imageBytes = await compressFile(value.imageCamera);
        value.base64Compressed = getExtension(value.imageCamera.toString()) +
            base64.encode(value.imageBytes);
      }
    }).catchError((onError) {
      ModeUtil.debugPrint(onError);
    });
  }

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

  Future<List<int>> compressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      quality: 80,
    );
    _deleteFilePath();
    return result;
  }

  void _deleteFilePath() {
    final dir = Directory(value.imagePath);
    dir.deleteSync(recursive: true);
  }

  void clear() {
    value.base64Image = null;
    value.image = null;
    value.imageBytes = null;
    value.takeCamera = false;
    value.imagePath = null;
    notifyListeners();
  }

  Future<String> _takePicture() async {
    String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
    if (!value.cameraController.value.isInitialized) {
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (value.cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await value.cameraController.takePicture(filePath);
    } catch (e) {
      ModeUtil.debugPrint(e);
    }
    value.imagePath = filePath;
    return filePath;
  }
}
