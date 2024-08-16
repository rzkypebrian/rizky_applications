import 'package:enerren/app/tms/aCustomer/localData.dart';
import 'package:enerren/app/tms/module/profile/tmsView.dart';
import 'package:enerren/model/profileModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

class CustomerView extends TmsView {
  @override
  void initProfileData() {
    super.profileModel = new ProfileModel(
      name: System.data.getLocal<LocalData>().user.customerName,
      email: System.data.getLocal<LocalData>().user.customerEmail,
      phone: System.data.getLocal<LocalData>().user.customerMobile,
      urlImmage: System.data.getLocal<LocalData>().user.imageUrl,
      address: System.data.getLocal<LocalData>().user.customerAddress,
    );
  }

  @override
  List<Widget> profileItems() {
    return <Widget>[
      profileItem(System.data.resource.name,
          System.data.getLocal<LocalData>().user.customerName),
      profileItem(System.data.resource.email,
          System.data.getLocal<LocalData>().user.customerEmail),
      profileItem(System.data.resource.phone,
          System.data.getLocal<LocalData>().user.customerMobile),
      profileItem(System.data.resource.address,
          System.data.getLocal<LocalData>().user.customerAddress),
    ];
  }
}
