import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:flutter/material.dart';

import 'newLoginThirdPartyPresenter.dart';
import 'package:enerren/module/verification/view.dart';

class NewThirdPartyLoginView extends View with NewLoginThirdPartyPresenter {
  final ValueChanged<Map<String, dynamic>> onSuccessLogin;
  final Map<String, dynamic> thirdPartyInfo;

  NewThirdPartyLoginView({
    this.onSuccessLogin,
    this.thirdPartyInfo,
  }) {
    super.onSuccessLogin = onSuccessLogin;
    super.thirdPartyInfo = this.thirdPartyInfo;
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
