import 'package:enerren/app/sierad/aDriver/localData.dart';
import 'package:enerren/app/sierad/module/profile/sieradView.dart';
import 'package:enerren/model/profileModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

class DriverView extends SieradView {
  @override
  void initProfileData() {
    super.profileModel = new ProfileModel(
      name: System.data.getLocal<LocalData>().user.driverName,
      email: System.data.getLocal<LocalData>().user.email,
      phone: System.data.getLocal<LocalData>().user.phoneNumber,
      urlImmage: System.data.getLocal<LocalData>().user.urlProfileImage,
      address: "",
    );
  }

  @override
  List<Widget> profileItems() {
    return <Widget>[
      profileItem(System.data.resource.name,
          System.data.getLocal<LocalData>().user.driverName),
      profileItem(System.data.resource.email,
          System.data.getLocal<LocalData>().user.email),
      profileItem(System.data.resource.phone,
          System.data.getLocal<LocalData>().user.phoneNumber),
      profileItem(System.data.resource.simNumber,
          System.data.getLocal<LocalData>().user.simNumber ?? "-"),
    ];
  }
}
