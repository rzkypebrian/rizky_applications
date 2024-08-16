import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/module/ratingDriver/view.dart';
import 'package:flutter/material.dart';
import 'sieradPresenter.dart';

class SieradView extends View with SieradPresenter {
  Widget circularProgressIndicatorComponent() {
    return DecorationComponent.circularProgressDecoration(
      controller: loadingController,
    );
  }
}
