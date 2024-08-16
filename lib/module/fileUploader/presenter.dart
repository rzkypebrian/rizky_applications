import 'dart:io';

import 'package:enerren/component/imagePickerComponent.dart';
import 'package:enerren/component/signatureComponent.dart';
import 'package:enerren/util/fileServiceUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;

  const Presenter({
    Key key,
    this.view,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  ImagePickerController controller = new ImagePickerController();
  SignatureComponentController signControler =
      new SignatureComponentController();

  void uploadFile(File file) async {
    if (file == null) {
      // _showSnackBar("Select file first");
      return;
    }

    // _setUploadProgress(0, 0);

    try {
      // var httpResponse = await FileService.fileUpload(
      //     file: file, onUploadProgress: _setUploadProgress);

      await FileServiceUtil.fileUploadMultipart(
        file: file,
        onUploadProgress: (
          percent,
          percent2,
        ) {
          print("process... $percent $percent2");
        },
        url:
            "http://api-dev.turnamengame.com/api/Fileservice/upload?path=productcategory&name=123456789",
      );

      print("File uploaded - ${(file.path)}");
    } catch (e) {
      // _showSnackBar(e.toString());
      print(e.toString());
    }
  }

  void uploadByte(ByteData data) async {
    if (data == null) {
      // _showSnackBar("Select file first");
      return;
    }

    // _setUploadProgress(0, 0);

    try {
      // var httpResponse = await FileService.fileUpload(
      //     file: file, onUploadProgress: _setUploadProgress);

      await FileServiceUtil.byteDataUploadMultipart(
        byteData: data,
        onUploadProgress: (
          percent,
          percent2,
        ) {
          print("process... $percent $percent2");
        },
        url:
            "http://api-dev.turnamengame.com/api/Fileservice/upload?path=productcategory&name=123456789",
      ).then((value) {
        print(value);
      }).catchError((onError) {
        print(onError);
      });

      print("File uploaded");
    } catch (e) {
      // _showSnackBar(e.toString());
      print(e.toString());
    }
  }

  void uploadSignature() {
    signControler.upload(
        "http://api-dev.turnamengame.com/api/Fileservice/upload?path=productcategory&name=123456789");
  }
}
