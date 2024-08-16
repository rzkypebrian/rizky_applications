import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/module/pin/main.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<int> onPinSaved;
  final VoidCallback onTapRelogin;
  final String btnLabel;

  const Presenter({
    Key key,
    this.view,
    this.onPinSaved,
     this.onTapRelogin,
     this.btnLabel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  double contentHeght = 370;

  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();
  InputComponentTextEditingController pinController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController confirmPinController =
      new InputComponentTextEditingController();

  String btnLabel;

  @override
  void initState() {
    super.initState();
    btnLabel = widget.btnLabel ?? System.data.resource.save;
    loadingController.stopLoading();
  }

  bool validateInputPin() {
    if (pinController.text.isEmpty) {
      pinController.setStateInput = StateInput.Error;
      return false;
    } else {
      pinController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validateConfirmPin() {
    if (confirmPinController.text.isEmpty) {
      confirmPinController.setStateInput = StateInput.Error;
      return false;
    } else {
      confirmPinController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validate() {
    bool isValid = true;
    isValid = validateInputPin() ?? isValid;
    isValid = validateConfirmPin() ?? isValid;
    return isValid;
  }

  void submit() {
    if (!validate()) return;
    System.data.sharedPreferences.setInt(PrefsKey.pin, int.parse(pinController.text));
    System.data.global.pin = System.data.sharedPreferences.getInt(PrefsKey.pin);
    if(widget.onPinSaved != null){
      widget.onPinSaved(System.data.global.pin);
    }
  }

  void relogin(){
    if(widget.onTapRelogin != null){
      widget.onTapRelogin();
    }
  }
}
