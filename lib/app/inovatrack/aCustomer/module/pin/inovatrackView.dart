import 'package:enerren/module/pin/view.dart';
import 'package:flutter/material.dart';
import 'package:enerren/component/inovatrackDecorationComponent.dart';

class InovatrackView extends View {
  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularProgressDecoration(
      controller: loadingController,
    );
  }
}
