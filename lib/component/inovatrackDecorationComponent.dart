import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TextStyleUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DecorationComponent {
  static Decoration backgroundDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.3, 9],
        colors: [
          System.data.colorUtil.primaryColor2,
          System.data.colorUtil.primaryColor2,
        ],
      ),
    );
  }

  static Widget containerWithDecoration({
    Widget child,
    String image1 = "assets/inovatrack/cloud1.svg",
    String image2 = "assets/inovatrack/cloud2.svg",
    Decoration decoration,
  }) {
    return Container(
      decoration: decoration ?? backgroundDecoration(),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              child: SvgPicture.asset(
                "$image1",
                height: 85,
                width: 100,
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(
                "$image2",
                height: 65,
                width: 137,
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: child,
          )
        ],
      ),
    );
  }

  static Widget circularProgressDecoration({
    CircularProgressIndicatorController controller,
    Alignment aligment,
  }) {
    return CircularProgressIndicatorComponent(
      width: 200,
      controller: controller,
      flareAssets: "assets/flares/inovatrack/loader_inovatrack.flr",
      flareAnimation: "play",
      margin: EdgeInsets.only(
        bottom: 30,
      ),
      messageMargin: EdgeInsets.only(
        bottom: 30,
      ),
      textStyleError: System.data.textStyleUtil.mainLabel(
        color: System.data.colorUtil.lightTextColor,
      ),
      backgroundNonerrorColor: System.data.colorUtil.primaryColor,
      textStyleNonError: System.data.textStyleUtil.mainLabel(
        color: System.data.colorUtil.lightTextColor,
      ),
    );
  }

  static Widget topMessageDecoration({
    Color backgroundColor = Colors.red,
    String message,
    TextStyleUtil messageStyle,
    Widget child,
  }) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 50,
      width: double.infinity,
      color: backgroundColor,
      child: child ??
          Center(
            child: Text(
              "$message",
              style: messageStyle ??
                  System.data.textStyleUtil.mainLabel(
                    color: System.data.colorUtil.lightTextColor,
                  ),
            ),
          ),
    );
  }
}
