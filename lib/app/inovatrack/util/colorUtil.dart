import 'package:enerren/util/ColorUtil.dart';
import 'package:flutter/material.dart';

extension InovatrackColorUtil on ColorUtil {
  ColorUtil inovatrackColor() {
    this.primaryColor = Colors.blue;
    this.primaryColor2 = Color(0xff2577D6);
    this.scaffoldBackgroundColor = Color(0xffF4F4F4);
    return this;
  }
}
