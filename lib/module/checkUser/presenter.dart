import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final VoidCallback onSubmitSuccess;
  final ValueChanged<AccountModel> onUserIsActive;
  final ValueChanged<AccountModel> onUserIsNonActive;
  final ValueChanged<String> onUserNotFound;
  final ValueChanged<String> onSubmit;

  const Presenter({
    Key key,
    this.view,
    this.onSubmitSuccess,
    this.onUserIsActive,
    this.onUserIsNonActive,
    this.onUserNotFound,
    this.onSubmit,
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
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();
  InputComponentTextEditingController usernameController =
      new InputComponentTextEditingController();

  @override
  void initState() {
    super.initState();
    loadingController.stopLoading();
  }

  void submitSuccess() {
    if (widget.onSubmitSuccess != null) {
      widget.onSubmitSuccess();
    } else {
      loadingController.stopLoading(
          message: "submit success callback not found");
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

  void submit() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (!validate()) return;
    if (widget.onSubmit != null) {
      widget.onSubmit(usernameController.text);
    } else {
      loadingController.startLoading();
      AccountModel.checkAccount(
        token: "",
        username: usernameController.text,
      ).then((accountModel) {
        loadingController.stopLoading();
        if (accountModel == null) {
          onUserNotFound(usernameController.text);
        } else {
          if (accountModel.activated == true) {
            onUserIsActive(accountModel);
          } else {
            onUserIsNonActive(accountModel);
          }
        }
      }).catchError((onError) {
        loadingController.stopLoading(
          message: ErrorHandlingUtil.handleApiError(onError),
        );
      });
    }
  }

  void onUserNotFound(String username) {
    if (widget.onUserNotFound != null) {
      widget.onUserNotFound(username);
    } else {
      loadingController.stopLoading(message: "user not found");
    }
  }

  void onUserIsActive(AccountModel accountModel) {
    if (widget.onUserIsActive != null) {
      widget.onUserIsActive(accountModel);
    } else {
      ModeUtil.debugPrint("called onUserActive (${accountModel.toJson()})");
    }
  }

  void onUserIsNonActive(AccountModel accountModel) {
    if (widget.onUserIsNonActive != null) {
      widget.onUserIsNonActive(accountModel);
    } else {
      ModeUtil.debugPrint(
          "called onUserIsNonActive (${accountModel.toJson()})");
    }
  }

  bool validate() {
    bool isValid = true;
    isValid = validateUsername() ?? isValid;
    return isValid;
  }
}
