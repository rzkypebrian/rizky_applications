import 'package:enerren/app/angkut/aTransporter/localData.dart';
import 'package:enerren/model/profileModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/util/StringExtention.dart';
import 'package:enerren/app/angkut/module/profile/angkutView.dart';

class TransporterView extends AngkutView {
  @override
  void initProfileData() {
    super.profileModel = new ProfileModel(
      name: System.data.getLocal<LocalData>().user.transporterName,
      email: System.data.getLocal<LocalData>().user.transporterEmail,
      phone: System.data.getLocal<LocalData>().user.transporterMobile,
      urlImmage: System.data.getLocal<LocalData>().user.imageUrl.isNullOrEmpty()
          ? "https://i.ibb.co/wCf8Wjf/avatar-angkut.png"
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
