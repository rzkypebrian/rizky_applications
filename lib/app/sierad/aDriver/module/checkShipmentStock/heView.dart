import 'package:flutter/material.dart';
import 'hePresenter.dart';
import 'view.dart';

class HeView extends View with HePresenter {
  @override
  double height() {
    return 350;
  }

  @override
  List<Widget> listCComponent() {
    return <Widget>[
      inputNumberOfBox(),
      inputNumberOfDoc(),
      inputNumberOfDocDead(),
    ];
  }
}
