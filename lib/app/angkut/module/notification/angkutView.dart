import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/module/notification/view.dart';
import 'package:flutter/material.dart';
import 'angkutPresenter.dart';

class AngkutView extends View with AngkutPresenter {
  final ValueChanged<AngkutShipmentModel> onTapNotif;

  AngkutView({
    this.onTapNotif,
  }) {
    super.onTapNotif = onTapNotif;
  }
}
