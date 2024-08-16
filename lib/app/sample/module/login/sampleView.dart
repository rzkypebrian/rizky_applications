import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:enerren/module/login/main.dart';

class SieradView extends View {
  String image1 = "assets/sample/egg_1.svg";
  String image2 = "assets/sample/egg_2.svg";
  String image3 = "assets/sample/egg_3.svg";
  String image4 = "assets/sample/egg_4.svg";

  Decoration decoration() {
    return BoxDecoration(
      color: System.data.colorUtil.scaffoldBackgroundColor,
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularProgressDecoration(
      controller: loadingController,
    );
  }

  @override
  Widget logo() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 50),
        child: Align(
          alignment: Alignment.topCenter,
          child: SvgPicture.asset(
            "assets/sample/logo_sierad.svg",
            width: 180,
          ),
        ),
      ),
    );
  }

  @override
  Widget body() {
    return Stack(
      children: <Widget>[
        Container(
          child: DecorationComponent.containerWithDecoration(
            image1: image1,
            image2: image2,
            image3: image3,
            image4: image4,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height),
              painter: PathPainter(),
              child: Stack(
                children: <Widget>[
                  logo(),
                  inputContainer(),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 15),
            child: SvgPicture.asset("assets/poweredby_tms.svg"),
          ),
        )
      ],
    );
  }
}
