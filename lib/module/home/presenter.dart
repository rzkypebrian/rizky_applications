import 'package:enerren/util/ModeUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final VoidCallback onTapModule;

  const Presenter({
    Key key,
    this.view,
    this.onTapModule,
  }) : super(key: key);

  createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  TextEditingController nama = TextEditingController();

  void getData() {
    ModeUtil.debugPrint(nama.text);
  }

  void onChange(TextEditingController textEditingController){
    setState(() {
    nama = textEditingController;
    ModeUtil.debugPrint(nama.text);
    });
  }
}
