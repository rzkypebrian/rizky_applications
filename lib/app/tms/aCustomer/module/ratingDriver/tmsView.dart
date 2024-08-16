import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/module/ratingDriver/view.dart';
import 'package:flutter/material.dart';
import 'TmsPresenter.dart';

class TmsView extends View with TmsPresenter {
  Widget circularProgressIndicatorComponent() {
    return DecorationComponent.circularProgressDecoration(
      controller: loadingController,
    );
  }
}
