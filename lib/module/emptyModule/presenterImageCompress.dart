import 'package:enerren/component/cgPicker.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
// import 'package:enerren/util/ModeUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';

class PresenterImageCompress extends StatefulWidget {
  final State<PresenterImageCompress> view;
  final VoidCallback onTapGotoHome;

  const PresenterImageCompress({
    Key key,
    this.view,
    this.onTapGotoHome,
  }) : super(key: key);

  createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterStateImageCompress
    extends State<PresenterImageCompress> {
  String base64Image = "";
  bool loadImage = false;
  UriData image;

  var tick = 1;
  final CircularProgressIndicatorController controller =
      new CircularProgressIndicatorController();

  CgPickerController cgPickerController =
      CgPickerController(value: CgPickerValue(camera: false, quality: 10));
  
}
