import 'dart:convert';

import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/module/login/presenter.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/app/inovatrack/model/userModel.dart';

mixin InovatrackPresenter on PresenterState {
  InputComponentTextEditingController memberCodeController =
      new InputComponentTextEditingController();

  bool validateMemberCode() {
    if (memberCodeController.text.isEmpty) {
      memberCodeController.setStateInput = StateInput.Error;
      return false;
    } else {
      memberCodeController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validateUsername() {
    if (usernameController.text.isEmpty) {
      usernameController.setStateInput = StateInput.Error;
      return false;
    } else {
      usernameController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validatePassword() {
    if (passwordController.text.isEmpty) {
      passwordController.setStateInput = StateInput.Error;
      return false;
    } else {
      passwordController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validate() {
    bool isValid = true;
    isValid = validateUsername() ?? isValid;
    isValid = validatePassword() ?? isValid;
    isValid = validateMemberCode() ?? isValid;
    return isValid;
  }

  void submit() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (!validate()) return;
    loadingController.startLoading();
    UserModel.login(
      memberCode: memberCodeController.text.trim(),
      userName: usernameController.text.trim(),
      password: passwordController.text.trim(),
    ).then((onValue) {
      loadingController.stopLoading();
      if (widget.onLoginSuccess != null) {
        widget.onLoginSuccess(onValue.toJson());
      } else {
        ModeUtil.debugPrint(onValue.toJson());
      }
    }).catchError(
      (onError) {
        loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: json
                .decode(ErrorHandlingUtil.handleApiError(onError))["Message"],
          ),
        );
      },
    );
  }
}
