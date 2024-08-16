import 'package:enerren/app/angkut/aDriver/localData.dart';
import 'package:enerren/model/profileModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/util/StringExtention.dart';
import 'package:enerren/app/angkut/module/profile/angkutView.dart';

class DriverView extends AngkutView {
  @override
  void initProfileData() {
    super.profileModel = widget.profileModel ??
        new ProfileModel(
          name: System.data.getLocal<LocalData>().user.driverName,
          email: System.data.getLocal<LocalData>().user.email,
          phone: System.data.getLocal<LocalData>().user.phoneNumber,
          urlImmage: System.data
                  .getLocal<LocalData>()
                  .user
                  .urlProfileImage
                  .isNullOrEmpty()
              ? "http://www.stickpng.com/assets/images/585e4bcdcb11b227491c3396.png"
              : System.data.getLocal<LocalData>().user.urlProfileImage,
          address: "",
        );
  }

  @override
  List<Widget> profileItems() {
    return <Widget>[
      profileItem(
          System.data.resource.name,
          profileModel.name ??
              System.data.getLocal<LocalData>().user.driverName),
      profileItem(System.data.resource.email,
          profileModel.email ?? System.data.getLocal<LocalData>().user.email),
      profileItem(
          System.data.resource.phone,
          profileModel.phone ??
              System.data.getLocal<LocalData>().user.phoneNumber),
      profileItem(System.data.resource.address, "-"),
    ];
  }

 
}
