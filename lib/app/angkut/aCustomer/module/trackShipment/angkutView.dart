import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/module/trackShipment/view.dart';
import 'package:flutter/material.dart';
import 'angkutPresenter.dart';

class AngkutView<AngkutShipmentModel> extends View<AngkutShipmentModel> with AngkutPresenter<AngkutShipmentModel> {
  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularLOadingIndicator(
        controller: super.loadingController);
  }
}
