import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/module/inputPhoneNumber/view.dart';
import 'package:flutter/material.dart';
import 'customerPresenter.dart';

class CustomerView extends View with CustomerPresenter {
  @override
  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularLOadingIndicator(
      controller: model.loadingController,
    );
  }
}
