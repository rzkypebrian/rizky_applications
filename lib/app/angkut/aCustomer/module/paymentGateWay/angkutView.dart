import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:flutter/material.dart';
import 'package:enerren/module/paymentGateWay/view.dart';

class AngkutView extends View {
  @override
  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularLOadingIndicator(
      controller: model.loadingController,
    );
  }
}
