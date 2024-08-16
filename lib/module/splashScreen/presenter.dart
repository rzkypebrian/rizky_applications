import 'dart:async';
import 'dart:ui';

import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final Duration splashScreenDuration;
  final VoidCallback onFinishSpashScreen;
  final Duration autoStartDuration;

  const Presenter({
    Key key,
    this.view,
    this.splashScreenDuration,
    this.onFinishSpashScreen,
    this.autoStartDuration,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();
  bool autoStart = true;
  TextStyle versionTextStyle = System.data.textStyleUtil.mainLabel(
    color: System.data.colorUtil.primaryColor,
    fontSize: System.data.fontUtil.xl,
  );

  Timer timer;

  @override
  void initState() {
    loadingController.stopLoading();
    super.initState();
    if (autoStart ?? false) onStart();
  }

  void onStart() {
    loadingController.startLoading(
      coverScreen: false,
    );
    timer =
        Timer.periodic(widget.autoStartDuration ?? Duration(seconds: 5), (t) {
      t.cancel();
      loadingController.stopLoading();
      onFinish();
    });
  }

  void onFinish() {
    if (widget.onFinishSpashScreen != null) {
      widget.onFinishSpashScreen();
    } else {
      ModeUtil.debugPrint("Finish");
    }
  }
}
