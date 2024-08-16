import 'package:enerren/model/DriverModel.dart';
import 'package:enerren/model/tmsDeliveryEmergencyModel.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final TmsDeliveryEmergencyModel emergencyModel;
  final ValueChanged<DriverModel> onTapProfile;

  const Presenter({
    Key key,
    this.view,
    this.emergencyModel,
    this.onTapProfile,
  }) : super(key: key);

  createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  void onTapProfile(DriverModel profile) {
    if (widget.onTapProfile != null) {
      widget.onTapProfile(profile);
    } else {
      ModeUtil.debugPrint("function otap profil is null");
    }
  }
}
