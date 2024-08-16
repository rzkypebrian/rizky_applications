import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/EnvironmentModel.dart';
import 'package:enerren/util/EnvironmentUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final VoidCallback onTapGotoHome;

  const Presenter({
    Key key,
    this.view,
    this.onTapGotoHome,
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
  var tick = 1;
  final CircularProgressIndicatorController controller =
      new CircularProgressIndicatorController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  EnvironmentModel envo;
  void getData() {
    EnvironmentUtil.readDevice
      ..then((value) {
        if (value.detailAndroid != null || value.detailsIos != null) {
          setState(() {
            envo = value;
          });
        }
      });
  }

  void gotoHome() {
    if (widget.onTapGotoHome != null) {
      widget.onTapGotoHome();
    }
  }
}
