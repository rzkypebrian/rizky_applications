import 'package:flutter/material.dart';

import 'newLoginPresenter.dart';
import 'sieradView.dart';

class NewLoginView extends SieradView with NewLoginPresenter {
  final ValueChanged<Map<String, dynamic>> onSuccessLogin;

  NewLoginView({
    this.onSuccessLogin,
  }) {
    super.onSuccessLogin = onSuccessLogin;
  }
}
