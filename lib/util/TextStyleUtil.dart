import 'package:enerren/Util/SystemUtil.dart';
import 'package:flutter/material.dart';

class TextStyleUtil {
  TextStyle pageTitle({
    Color color, // = ColorUtil.lightTextColor,
    String fontFamily,
    double fontSize,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return TextStyle(
      color: color ?? System.data.colorUtil.lightTextColor,
      fontFamily: fontFamily ?? System.data.fontUtil.primary,
      fontSize: fontSize ?? System.data.fontUtil.xxl,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle inputTitle({
    Color color, // = ColorUtil.lightTextColor,
    String fontFamily,
    double fontSize,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
        color: System.data.colorUtil.darkTextColor,
        fontFamily: System.data.fontUtil.primary,
        fontSize: fontSize ?? System.data.fontUtil.l,
        fontWeight: FontWeight.normal);
  }

  TextStyle mainLabel(
      {Color color, // = ColorUtil.darkTextColor,
      String fontFamily,
      double fontSize,
      FontWeight fontWeight,
      FontStyle fontStyle,
      TextDecoration textDecoration = TextDecoration.none}) {
    return TextStyle(
      color: color ?? System.data.colorUtil.darkTextColor,
      fontSize: fontSize ?? System.data.fontUtil.m,
      fontStyle: fontStyle,
      fontWeight: fontWeight ?? FontWeight.normal,
      decoration: textDecoration,
      fontFamily: fontFamily ?? System.data.fontUtil.primary,
    );
  }

  TextStyle linkLabel({
    Color color, // = ColorUtil.primaryColor,
    String fontFamily,
    double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    TextDecoration textDecoration,
  }) {
    return TextStyle(
      color: color ?? System.data.colorUtil.primaryColor,
      fontSize: fontSize ?? System.data.fontUtil.m,
      fontWeight: fontWeight ?? FontWeight.normal,
      fontStyle: FontStyle.normal,
      decoration: textDecoration,
    );
  }

  TextStyle titleTable({
    Color color, // = ColorUtil.secondaryColor,
    String fontFamily,
    double fontSize,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return TextStyle(
      color: color ?? System.data.colorUtil.secondaryColor,
      fontSize: fontSize ?? System.data.fontUtil.m,
      fontFamily: fontFamily ?? System.data.fontUtil.primary,
      fontWeight: fontWeight,
    );
  }

  TextStyle headerTable({
    Color color, // = ColorUtil.primaryColor,
    String fontFamily,
    double fontSize,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? System.data.fontUtil.primary,
      color: color ?? System.data.colorUtil.primaryColor,
      fontSize: fontSize ?? System.data.fontUtil.s,
    );
  }

  TextStyle valueTable({
    Color color, // = ColorUtil.primaryColor,
    String fontFamily,
    double fontSize,
  }) {
    return TextStyle(
      color: color ?? System.data.colorUtil.primaryColor,
      fontFamily: fontFamily ?? System.data.fontUtil.primary,
      fontSize: fontSize ?? System.data.fontUtil.m,
    );
  }

  TextStyle listTileTitle({
    Color color, //= ColorUtil.primaryColor,
    String fontFamily,
    double fontSize,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return TextStyle(
      fontWeight: fontWeight,
      color: color ?? System.data.colorUtil.primaryColor,
      fontFamily: fontFamily ?? System.data.fontUtil.primary,
      fontSize: fontSize ?? System.data.fontUtil.m,
    );
  }

  TextStyle listTileSUbtitile({
    Color color, //= ColorUtil.secondaryColor,
    String fontFamily,
    double fontSize,
  }) {
    return TextStyle(
      fontSize: fontSize ?? System.data.fontUtil.m,
      fontFamily: fontFamily ?? System.data.fontUtil.primary,
      color: color ?? System.data.colorUtil.primaryColor,
    );
  }

  TextStyle infoTitle() {
    return TextStyle(
      color: Colors.black38,
      fontWeight: FontWeight.w500,
      fontSize: System.data.fontUtil.s,
    );
  }

  TextStyle mainTitle({
    Color color, // = ColorUtil.secondaryColor,
    String fontFamily,
    double fontSize,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      color: color ?? System.data.colorUtil.lightTextColor,
      fontSize: fontSize ?? System.data.fontUtil.l,
      fontWeight: fontWeight,
    );
  }
}
