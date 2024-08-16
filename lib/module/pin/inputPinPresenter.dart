import 'package:enerren/component/inovatrackDecorationComponent.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

import 'presenter.dart';

mixin InputPresenter on PresenterState {
  bool validate() {
    bool isValid = true;
    isValid = validateInputPin() ?? isValid;
    return isValid;
  }

  void submit() {
    if (!validate()) return;
    ModeUtil.debugPrint("input is ${int.parse(pinController.text)}");
    if (int.parse(pinController.text) == System.data.global.pin) {
      if (widget.onPinSaved != null) {
        widget.onPinSaved(int.parse(pinController.text));
      }
    }else{
      loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: System.data.resource.invalidPin,
        )
      );
    }
  }
}
