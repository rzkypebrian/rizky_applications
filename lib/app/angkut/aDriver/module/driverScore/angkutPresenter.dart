import 'dart:ui';

import 'package:enerren/component/CircularCartComponent.dart';
import 'package:enerren/module/driverScore/presenter.dart';

mixin AngkutPresenter on PresenterState {
  @override
  void initState() {
    super.initState();
    loadingController.stopLoading();
    model.scoreValue = model.scoreValue ?? widget.score;
    controller = CircularChartController(
      value: new CircularChartValue(
        duration: Duration(milliseconds: 30),
        lowerColor: Color(0xffFF5C5C),
        middleColor: Color(0xffFFB948),
        higherColor: Color(0XFFE0FD00),
        strockWidth: 0,
        value: model.scoreValue / 10,
        maximum: 10,
      ),
    );
    getScore().then((onValue) {
      // controller.setValue(model.scoreValue);
      controller.starChart();
    }).catchError((onError) {});
  }
}
