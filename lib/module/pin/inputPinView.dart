import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'inputPinPresenter.dart';
import 'view.dart';

class InputPinView extends View with InputPresenter {
  @override
  void initState() {
    super.initState();
    super.btnLabel = System.data.resource.enter;
    super.contentHeght = 280;
  }

  @override
  List<Widget> listInputComponent() {
    return <Widget>[
      inputPin(),
      btnSubmit(),
      bottonForgotPassword(),
    ];
  }

  
}
