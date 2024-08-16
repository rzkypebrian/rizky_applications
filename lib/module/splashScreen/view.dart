import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          backGround(),
          centerLogo(),
          version(),
          circularProgressIndicatorDecoration(),
        ],
      ),
    );
  }

  Widget version() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 100),
        child: Container(
          height: 50,
          child: Column(
            children: <Widget>[
              Text(
                "${System.data.resource.appVersion}",
                style: super.versionTextStyle,
              ),
              Text(
                "${System.data.version}",
                style: super.versionTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget backGround() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: System.data.colorUtil.primaryColor,
    );
  }

  Widget centerLogo() {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        child: SvgPicture.asset("assets/logo_inovatrack.svg"),
      ),
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return CircularProgressIndicatorComponent(
      controller: super.loadingController,
    );
  }
}
