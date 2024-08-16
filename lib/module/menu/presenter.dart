import 'package:flutter/material.dart';
import 'main.dart';
import 'view.dart';
import '../../model/menuModel.dart';
typedef MenuSource = List<MenuModel> Function();

class Presenter extends StatefulWidget {
  ///
  /// jika menu diset memalaui field ini mala menu akan berdifat satik tidak dapat dibuah
  /// gunakan overide methode atau set melalui field menus pada view
  /// 
  final MenuSource menus;
  final double width;
  final double heigth;
  final State<Presenter> view;
  final EdgeInsets margin;
  final EdgeInsets padding;

  const Presenter({
    Key key,
    this.menus,
    this.width,
    this.heigth,
    this.view,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {

  @override
  void initState() {
    super.initState();
  }
}
