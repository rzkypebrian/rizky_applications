import 'package:enerren/util/ColorUtil.dart';
import 'package:flutter/material.dart';

extension SieradColorExtentention on ColorUtil {
  ColorUtil sieradColor() {
    this.primaryColor = Color(0xff00A651);
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

  ColorUtil sieradCustomerColor() {
    sieradColor();
    this.primaryColor =  Color(0xffF49D00);
    this.secondaryColor = Color(0xffFFFFFF);
    this.disableColor = Color(0xffBCBCBC);
    this.lightTextColor = Color(0xffFFFFFF);
    this.darkTextColor = Color(0xff444444);
    this.scaffoldBackgroundColor = Color(0xffF6F6FB);
    this.scafoldColor = Color(0xFF565657);
    this.inputTextColor = Color(0xFFF7F7F7);
    return this;
  }
}
