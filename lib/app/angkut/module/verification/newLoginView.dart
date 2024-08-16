import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:flutter/material.dart';

import 'newLoginPresenter.dart';
import 'package:enerren/module/verification/view.dart';

class NewLoginView extends View with NewLoginPresenter {
  final ValueChanged<Map<String, dynamic>> onSuccessLogin;

  NewLoginView({
    this.onSuccessLogin,
  }) {
    super.onSuccessLogin = onSuccessLogin;
  }

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
