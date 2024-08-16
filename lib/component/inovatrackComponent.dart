import 'package:enerren/util/SystemUtil.dart';
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
          System.data.colorUtil.primaryColor3,
          System.data.colorUtil.primaryColor3,
        ],
      ),
    );
  }

  static Widget containerWithDecoration({
    Widget child,
    String image1 = "assets/cloud1.svg",
    String image2 = "assets/cloud2.svg",
  }) {
    return Container(
      decoration: backgroundDecoration(),
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
                height: 55,
                width: 130,
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: child,
          )
        ],
      ),
    );
  }
}
