import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/module/voucherDetail/view.dart';
import 'package:flutter/material.dart';
import 'angkutPresenter.dart';

class AngkutView extends View with AngkutPresenter {
  final AngkutShipmentModel shipmentModel;
  final ValueChanged<AngkutShipmentModel> onApply;

  AngkutView({
    @required this.shipmentModel,
    this.onApply,
  }) {
    super.shipmentModel = this.shipmentModel;
    super.onApply = this.onApply;
  }
}
