import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/module/doFinish/DoFinishView.dart';
import 'package:flutter/material.dart';

class AngkutView extends DoFinishView {
  @override
  Widget angkutDecorationComponent() {
    return Container(
      child: DecorationComponent.circularLOadingIndicator(
          controller: model.loadingController,
          aligment: Alignment.bottomCenter),
    );
  }
}
