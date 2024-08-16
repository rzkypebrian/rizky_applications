import 'package:enerren/model/profileModel.dart';
import 'package:enerren/module/profile/view.dart';
import 'package:flutter/material.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';

class TmsView extends View {
  @override
  void initProfileData() {
    super.profileModel = new ProfileModel();
  }

  @override
  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularProgressDecoration(
      controller: super.loadingController,
    );
  }
}
