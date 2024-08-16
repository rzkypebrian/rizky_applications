import 'package:enerren/util/ColorUtil.dart';
import 'package:flutter/material.dart';

extension InovaPickupColorExtentention on ColorUtil {
  ColorUtil novaPickupColor() {
    this.primaryColor = Color(0xff009688);
    this.primaryColor2 = Color(0xff009688);
    this.lightTextColor = Color(0xffFFFFFF);
    this.secondaryColor = Color(0xffFFFFFF);
    this.disableColor = Color(0xffEDEDED);
    this.lightTextColor = Color(0xffFFFFFF);
    this.darkTextColor = Color(0xFF1A1A1A);
    this.scaffoldBackgroundColor = Color(0xFFF6F6FB);
    this.scafoldColor = Color(0xffFFFFFF);
    this.inputTextColor = Color(0xff444444);
    return this;
  }
}
