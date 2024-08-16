import 'package:enerren/module/splashScreen/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'inovatrackPresenter.dart';
import 'package:enerren/component/inovatrackDecorationComponent.dart';

class InovatrackView extends View with InovatrackPresenter {
  @override
  Widget backGround() {
    return bgImage();
  }

  Widget bgImage() {
    return SafeArea(
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(top: 50, bottom: 75),
        child: Align(
            alignment: Alignment.topCenter,
            child: Image(
              image: AssetImage("assets/inovatrack/bgScafold.png"),
            )),
      ),
    );
  }

  @override
  Widget centerLogo() {
    return textInovaTrack();
  }

  Widget textInovaTrack() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Align(
        alignment: Alignment.center,
        child: SvgPicture.asset(
          "assets/inovatrack/inovaTrack.svg",
          width: 190,
        ),
      ),
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularProgressDecoration(
      controller: super.loadingController,
    );
  }
}
