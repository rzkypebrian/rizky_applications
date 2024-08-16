import 'package:enerren/app/angkut/module/verification/changePhoneNumberView.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:flutter/material.dart';
import 'customerChangePhoneNumberPresenter.dart';

class CustomerChangePhoneNumberView extends ChangePhoneNumberView
    with CustomerChangePhoneNumberPresenter {
  Widget circularProgressIndicator(
      CircularProgressIndicatorController controller) {
    return DecorationComponent.circularLOadingIndicator(controller: controller);
  }
}
