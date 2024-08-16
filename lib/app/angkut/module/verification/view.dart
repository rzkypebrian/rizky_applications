import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/module/verification/view.dart';
import 'package:flutter/material.dart';

mixin AngkutView on View {
  Widget circularProgressIndicator(
      CircularProgressIndicatorController controller) {
    return DecorationComponent.circularLOadingIndicator(
      controller: controller,
    );
  }
}
