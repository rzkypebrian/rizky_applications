import 'package:enerren/model/profileModel.dart';
import 'package:enerren/module/dashboard/presenter.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';

mixin SieradPresenter on PresenterState{
  var tick = 1;
  var profile = ProfileModel.dummy();

  FlareController flare1;

  @override
  void initState() {
    super.initState();
    // loadingCOntroller.stopLoading();
  }

  void gotoProfile(BuildContext context) {
    if (widget.gotoProfile != null) {
      widget.gotoProfile();
    }
  }
}
