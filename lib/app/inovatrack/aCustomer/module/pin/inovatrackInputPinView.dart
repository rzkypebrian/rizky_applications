import 'package:enerren/module/pin/inputPinView.dart';
import 'package:flutter/material.dart';
import 'package:enerren/component/inovatrackDecorationComponent.dart';

class InovatrackInputPinView extends InputPinView {
  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularProgressDecoration(
      controller: loadingController,
    );
  }
}
