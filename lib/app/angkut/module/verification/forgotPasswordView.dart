import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/module/verification/view.dart';
import 'package:flutter/material.dart';
import 'forgotPasswordPresenter.dart';

class ForgotPasswordView extends View with ForgotPasswordPresenter {
  @override
  Widget title() {
    return SizedBox(
      height: 5,
    );
  }

  Widget circularProgressIndicator(
      CircularProgressIndicatorController controller) {
    return DecorationComponent.circularLOadingIndicator(controller: controller);
  }
}
