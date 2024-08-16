import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/module/do/view.dart';
import 'package:flutter/material.dart';

class AngkutView extends View {
  Widget angkutDecorationComponent() {
    return DecorationComponent.circularLOadingIndicator(
      controller: model.loadingController,
    );
  }
}
