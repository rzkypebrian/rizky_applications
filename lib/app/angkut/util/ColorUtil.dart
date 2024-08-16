import 'package:enerren/util/ColorUtil.dart';
import 'package:flutter/material.dart';

extension ColorUtilExtension on ColorUtil {
  ColorUtil angkutColor() {
    this.disableColor = Color(0xffBCBCBC);
    this.greenColor = Colors.green;
    this.primaryColor = Color(0xff008AF6);
    this.secondaryColor = Color(0xffFFFFFF);
    this.scaffoldBackgroundColor = Color(0xffF6F6FB);
    this.shadowColor = Color(0xff000000);
    this.greyColor = Colors.grey;

    return this;
  }

  ColorUtil angkutDriver() {
    angkutColor();
    this.greyColor = Color(0xffC9C9C9);
    return this;
  }
}
