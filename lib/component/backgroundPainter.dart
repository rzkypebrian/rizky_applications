import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  BackgroundPainter();
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = System.data.colorUtil.scaffoldBackgroundColor;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height - 110);
    path.quadraticBezierTo(
        size.width / 2, size.height - 0, size.width, size.height - 110);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
