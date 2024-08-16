import 'package:enerren/app/sierad/aAdmin/localData.dart';
import 'package:enerren/app/sierad/module/profile/sieradView.dart';
import 'package:enerren/model/profileModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/util/StringExtention.dart';

class AdminView extends SieradView {
  @override
  void initProfileData() {
    super.profileModel = new ProfileModel(
      name: System.data.getLocal<LocalData>().user.transporterName,
      email: System.data.getLocal<LocalData>().user.transporterEmail,
      phone: System.data.getLocal<LocalData>().user.transporterMobile,
      urlImmage: System.data.getLocal<LocalData>().user.imageUrl.isNullOrEmpty()
          ? "http://www.stickpng.com/assets/images/585e4bcdcb11b227491c3396.png"
          : System.data.getLocal<LocalData>().user.imageUrl,
      address: "",
    );
  }

  @override
  List<Widget> profileItems() {
    return <Widget>[
      profileItem(System.data.resource.name,
          System.data.getLocal<LocalData>().user.transporterName),
      profileItem(System.data.resource.email,
          System.data.getLocal<LocalData>().user.transporterEmail),
      profileItem(System.data.resource.phone,
          System.data.getLocal<LocalData>().user.transporterMobile),
      profileItem(System.data.resource.transporterType,
          System.data.getLocal<LocalData>().user.transporterType ?? "-"),
      profileItem(System.data.resource.address,
          System.data.getLocal<LocalData>().user.address ?? "-"),
    ];
  }
}
