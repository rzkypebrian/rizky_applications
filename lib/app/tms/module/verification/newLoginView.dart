import 'package:flutter/material.dart';

import 'newLoginPresenter.dart';
import 'tmsView.dart';

class NewLoginView extends TmsView with NewLoginPresenter {
  final ValueChanged<Map<String, dynamic>> onSuccessLogin;

  NewLoginView({
    this.onSuccessLogin,
  }) {
    super.onSuccessLogin = onSuccessLogin;
  }
}
