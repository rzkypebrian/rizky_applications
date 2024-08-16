import 'package:flutter/material.dart';
import 'basketPresenter.dart';
import 'view.dart';

class BasketView extends View with BasketPresenter {
  // @override
  double height() {
    return 125;
  }

  // @override
  List<Widget> listCComponent() {
    return <Widget>[
      inputNumberOfBox(),
    ];
  }
}
