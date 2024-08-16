import 'dart:async';

import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;

  final ValueChanged<Map<String, dynamic>> onSubmitSuccess;
  final VoidCallback onSubmitFailed;
  final PasswordState passwordState;

  const Presenter({
    Key key,
    this.onSubmitSuccess,
    this.onSubmitFailed,
    this.passwordState = PasswordState.ChangePassword,
    this.view,
  }) : super(key: key);

  createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  bool isValid;
  bool onLoading = false;
  bool isErrorStatus = true;
  String errorMessage = "";

  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  InputComponentTextEditingController currentPasswordController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController newPasswordController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController confirmPasswordController =
      new InputComponentTextEditingController();

  final FocusNode focusCurrentPassword = FocusNode();
  final FocusNode focusNewPassword = FocusNode();
  final FocusNode focusConfirmPassword = FocusNode();

  StateInputMessage defaultStateINputMessage =
      StateInputMessage(warningColor: Colors.red);

  @override
  void initState() {
    super.initState();
    loadingController.stopLoading();
  }

  bool validateCurrentPassword() {
    if (currentPasswordController.text.isEmpty) {
      currentPasswordController.stateInput = StateInput.Error;
      return false;
    } else {
      currentPasswordController.stateInput = StateInput.Enable;
      return null;
    }
  }

  bool validateNewPassword() {
    if (newPasswordController.text.isEmpty) {
      newPasswordController.setStateInput = StateInput.Error;
      return false;
    } else {
      newPasswordController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validateConfirmPassword() {
    if (confirmPasswordController.text.isEmpty ||
        (confirmPasswordController.text != newPasswordController.text)) {
      confirmPasswordController.setStateInput = StateInput.Error;
      return false;
    } else {
      confirmPasswordController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  void onCurrentPasswordChange(String val) {
    currentPasswordController.setStateInputMessage = validatePasswordRoles(val);
  }

  void onNewPasswordChange(String val) {
    newPasswordController.setStateInputMessage = validatePasswordRoles(val);
  }

  void onConfirmPasswordChange(String val) {
    confirmPasswordController.setStateInputMessage = validatePasswordRoles(val);
    if (confirmPasswordController.stateInputMessage == null) {
      if (val != newPasswordController.text) {
        confirmPasswordController.stateInputMessage = defaultStateINputMessage;
        confirmPasswordController.stateInputMessage.setDanger;
        confirmPasswordController.stateInputMessage.message =
            "${System.data.resource.comfirmPasswordNotMatch}";
      }
    }
  }

  StateInputMessage validatePasswordRoles(String password) {
    StateInputMessage stateInputMessage = defaultStateINputMessage;
    if (password.length < 8) {
      stateInputMessage.setWarning;
      stateInputMessage.message = "${System.data.resource.mimimum5Character}";
    } else {
      stateInputMessage = null;
    }
    return stateInputMessage;
  }

  bool validate() {
    isValid = true;
    isValid = widget.passwordState == PasswordState.ChangePassword
        ? validateCurrentPassword() ?? isValid
        : isValid;
    isValid = validateNewPassword() ?? isValid;
    isValid = validateConfirmPassword() ?? isValid;
    return isValid;
  }

  void submit() {
    if (validate() == true) {
      switch (widget.passwordState) {
        case PasswordState.ChangePassword:
          changePassword();
          break;
        case PasswordState.CreatePassword:
          createNewPassword();
          break;
        case PasswordState.ResetPassword:
          resetPassword();
          break;
        default:
      }
    }
  }

  void createNewPassword() {
    loadingController.startLoading();
    //read password inser to new account
    ModeUtil.debugPrint("read password inser to new account");
    System.data.global.newAccount.password = newPasswordController.text;
    System.data.global.newAccount.confirmPassword =
        confirmPasswordController.text;
    //send to server
    AccountModel.createPassword(
      account: System.data.global.newAccount,
      token: "",
      deviceId: System.data.global.mmassagingToken,
    ).then((onValue) {
      if (widget.onSubmitSuccess != null) {
        widget.onSubmitSuccess(onValue);
        loadingController.stopLoading();
      }
      loadingController.startLoading();
      if (widget.onSubmitSuccess != null) {
        widget.onSubmitSuccess(onValue);
        loadingController.stopLoading();
      } else {
        ModeUtil.debugPrint("create password success");
        loadingController.stopLoading();
      }
    }).catchError((onError) {
      onSubmitError(onError);
      loadingController.stopLoading();
    });
  }

  void changePassword() {
    ModeUtil.debugPrint("masuk sini");
    loadingController.startLoading();
    AccountModel.changePassword(
      oldPassword: currentPasswordController.text.trim(),
      newPassword: newPasswordController.text.trim(),
      token: System.data.global.token,
    ).then((onValue) {
      currentPasswordController.text = "";
      newPasswordController.text = "";
      confirmPasswordController.text = "";
      loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          isError: false,
          messageWidget: DecorationComponent.topMessageDecoration(
            backgroundColor: System.data.colorUtil.greenColor,
            message: "${System.data.resource.passwordSuccessfullyChanged}",
          ),
          onFinishCallback: () {
            if (widget.onSubmitSuccess != null) {
              widget.onSubmitSuccess(onValue);
            }
          });
    }).catchError((onError) {
      onSubmitError(onError);
      loadingController.stopLoading();
    });
  }

  void resetPassword() {
    loadingController.startLoading();
    ModeUtil.debugPrint("simulasi loading reset password 3 detik");
    Timer.periodic(Duration(seconds: 1), (t) {
      if (t.tick == 3) {
        loadingController.stopLoading();
        t.cancel();
        if (widget.onSubmitSuccess != null) {
          widget.onSubmitSuccess({});
          loadingController.stopLoading();
        } else {
          ModeUtil.debugPrint("submit success");
          loadingController.stopLoading();
        }
      }
    });
  }

  void onSubmitError(dynamic onError) {
    loadingController.stopLoading(
      messageAlign: Alignment.topCenter,
      messageWidget: DecorationComponent.topMessageDecoration(
        backgroundColor: System.data.colorUtil.redColor,
        message: ErrorHandlingUtil.handleApiError(onError),
      ),
    );
  }
}

enum PasswordState {
  CreatePassword,
  ChangePassword,
  ResetPassword,
}
