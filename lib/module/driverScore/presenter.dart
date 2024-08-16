import 'dart:async';
import 'dart:ui';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/model/TmsDriverScoreModel.dart';
import 'package:enerren/module/driverScore/viewModel.dart';
import 'package:enerren/component/CircularCartComponent.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final VoidCallback onTapGotoHome;
  final ObjectBuilder<ViewModel> data;
  final double score;
  final String defaultAnimationFile;
  final String defaultAnimationName;
  final String lowAnimationFile;
  final String lowAnimationName;
  final Color lowColor;
  final String midleAnimationFile;
  final String midleAnimationName;
  final Color midleColor;
  final String hightAnimationFile;
  final String hightAnimationName;
  final double animationSize;
  final Color heightColor;
  final int lowScore = 5;
  final int midleScore = 7;
  final int hightScore = 8;

  const Presenter({
    Key key,
    this.view,
    this.onTapGotoHome,
    this.score,
    this.data,
    this.lowAnimationFile,
    this.lowAnimationName,
    this.midleAnimationFile,
    this.midleAnimationName,
    this.hightAnimationFile,
    this.hightAnimationName,
    this.defaultAnimationFile,
    this.defaultAnimationName,
    this.lowColor,
    this.midleColor,
    this.heightColor,
    this.animationSize,
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
  CircularChartController controller;
  ViewModel model = new ViewModel();
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  @override
  void initState() {
    super.initState();
    loadingController.stopLoading();
    model.scoreValue = model.scoreValue ?? widget.score;
    controller = CircularChartController(
      value: new CircularChartValue(
        duration: Duration(milliseconds: 30),
        lowerColor: widget.heightColor ?? System.data.colorUtil.redColor,
        middleColor: widget.midleColor ?? System.data.colorUtil.yellowColor,
        higherColor: widget.heightColor ?? System.data.colorUtil.primaryColor,
        value: model.scoreValue / 10,
        maximum: 10,
        middleThreshold: widget.midleScore.toDouble(),
        lowerThreshold: widget.lowScore.toDouble(),
      ),
    );
    getScore().then((onValue) {
      // controller.setValue(model.scoreValue);
      controller.starChart();
    }).catchError((onError) {});
  }

  Timer timer;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> getScore() async {
    loadingController.startLoading();
    return TmsDriverScoreModel.get(
      token: System.data.global.token,
    ).then((onValue) {
      model.scoreValue = onValue.driverScore;
      model.canceledJob = onValue.cancelShipment;
      model.overSpeed = onValue.overSpeed;
      model.averageSpeed = onValue.averageSpeed;
      model.finishedJob = onValue.finishShipment;
      model.commit();
      loadingController.stopLoading();
    }).catchError(
      (onError) {
        loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError),
          ),
        );
      },
    );
  }
}
