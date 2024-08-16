import 'package:enerren/model/profileModel.dart';
import 'package:enerren/module/profile/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:enerren/util/SystemUtil.dart';

class AngkutView extends View {
  @override
  void initProfileData() {
    super.profileModel = new ProfileModel();
  }

  @override
  Widget body({List<Widget> profileIteem}) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(bottom: 20),
      child: Container(
        padding: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
           BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ]),
        child: super.body(
          profileIteem: super.profileItems(),
        ),
      ),
    );
  }

  @override
  Widget imageProfile({
    EdgeInsetsGeometry margin,
    EdgeInsetsGeometry padding,
    double width,
    double height,
    bool readOnly,
  }) {
    return Container(
      padding: EdgeInsets.only(
        top: 30,
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset("assets/angkut/bgBox.svg"),
          ),
          Align(
            alignment: Alignment.center,
            child: super.imageProfile(
              padding: EdgeInsets.only(top: 10),
              width: 80,
              height: 80,
              readOnly: readOnly,
            ),
          ),
        ],
      ),
    );
  }
}
