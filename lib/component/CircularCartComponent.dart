import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

typedef CircularChartChildBuilder = Widget Function(CircularChartValue value);

class CircularChartPainter extends CustomPainter {
  Color lineColor;
  Color completeColor;
  double completePercent;
  double totalAll;
  double width;
  double strockWidth;
  int status;
  CircularChartPainter({
    this.lineColor,
    this.completeColor,
    this.completePercent,
    this.width,
    this.totalAll,
    this.strockWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = new Offset(size.width / 2, size.height / 2);
    Offset center1 = new Offset(size.width / 2, size.height / 1.9);
    double radius = min(size.width / 2, size.height / 2);

    Rect rect = new Rect.fromCircle(
      center: center,
      radius: radius,
    );
    Rect rect1 = new Rect.fromCircle(
      center: center1,
      radius: radius,
    );

    var linearGradient = new LinearGradient(
      colors: <Color>[
        lineColor,
      ],
      stops: [
        1,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    final Gradient gradient = linearGradient;

    Paint complete = new Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Paint complete1 = new Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(10))
      ..strokeWidth = width * (strockWidth ?? 1.5)
      ..shader = gradient.createShader(rect);

    double arcAngle = 2 * pi * (completePercent / totalAll);

    canvas.drawArc(
      rect1,
      -pi / 2,
      arcAngle,
      false,
      complete1,
    );

    canvas.drawCircle(center, radius, line);

    canvas.drawArc(
      rect,
      -pi / 2,
      arcAngle,
      false,
      complete,
    );
  }

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CircularChartValue {
  Widget child;
  double value;
  double maximum;
  Color completeColor;
  Color lineColor;
  double width;
  double current;
  Color lowerColor;
  Color middleColor;
  Color higherColor;
  Duration duration;
  double lowerThreshold;
  double middleThreshold;
  double strockWidth;
  int status;
  CircularChartValue({
    this.child,
    this.maximum = 10,
    this.lineColor = Colors.white,
    this.width = 10,
    this.value = 100,
    this.current = 0,
    this.lowerColor = Colors.red,
    this.middleColor = Colors.yellow,
    this.higherColor = Colors.green,
    this.duration = const Duration(seconds: 2),
    this.middleThreshold,
    this.lowerThreshold,
    this.strockWidth,
    this.status,
  }) {
    setColor();
  }

  void setColor() {
    var _middleThreshold = middleThreshold ?? (maximum * 3 / 4);
    var _lowerThreshold = lowerThreshold ?? maximum / 2;

    if (current < _lowerThreshold) {
      completeColor = lowerColor;
      status = 0;
    } else if (current >= _lowerThreshold && current < _middleThreshold) {
      completeColor = middleColor;
      status = 1;
    } else {
      completeColor = higherColor;
      status = 2;
    }
  }
}

class CircularChartController extends ValueNotifier<CircularChartValue> {
  CircularChartController({CircularChartValue value})
      : super(value == null ? CircularChartValue() : value);

  Timer timers;
  bool startCountDown = false;

  void setValue(double val) {
    value.value = val;
    notifyListeners();
  }

  void starChart({
    Widget widget,
    Duration duration,
  }) {
    value.child = widget;
    startData();
  }

  void startData() {
    double _start = 0;
    double _end = value.value;
    notifyListeners();
    if (startCountDown) {
      timers.cancel();
    }

    timers = Timer.periodic(Duration(microseconds: 1), (s) {
      value.current =
          ((_end - _start) / value.duration.inMicroseconds) * s.tick;

      if (value.current > value.maximum) {
        value.current = value.maximum;
        startCountDown = false;
        timers.cancel();
      }

      value.setColor();

      startCountDown = true;

      if (s.tick == value.duration.inMicroseconds) {
        startCountDown = false;
        s.cancel();
      }

      notifyListeners();
    });
  }

  void stopChart() {
    if (startCountDown) {
      timers.cancel();
    }
    notifyListeners();
  }
}

class CircularCartComponent extends StatelessWidget {
  final CircularChartController controller;
  final CircularChartChildBuilder centerChild;
  final CircularChartChildBuilder bottomChild;
  final CircularChartChildBuilder backgroundChild;
  final double height;
  final double width;
  final double chartSize;

  CircularCartComponent({
    Key key,
    this.centerChild,
    this.controller,
    this.bottomChild,
    this.backgroundChild,
    this.height,
    this.width,
    this.chartSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CircularChartValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return Container(
          width: width ?? 223,
          height: height ?? 250,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: backgroundChild != null
                    ? backgroundChild(value)
                    : Container(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: bottomChild == null ? Container() : bottomChild(value),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: chartSize ?? 120,
                  height: chartSize ?? 120,
                  child: CustomPaint(
                    foregroundPainter: CircularChartPainter(
                      lineColor: value.lineColor,
                      completeColor: value.completeColor,
                      completePercent: value.current,
                      totalAll: value.maximum,
                      width: value.width,
                      strockWidth: value.strockWidth,
                    ),
                    child:
                        centerChild != null ? centerChild(value) : Container(),
                  ),
                ),
              ),
            ],
          ),
        );
        // value.child;
      },
    );
  }
}
