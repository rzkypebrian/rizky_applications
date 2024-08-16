import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageUtil {
  ImageUtil();

  static String getExtension(String string) {
    List<String> getList = string.split(".");
    String data = getList.last.replaceAll("'", "");
    String result;
    if (data == "png") {
      result = "data:image/png;base64,";
    } else if (data == "jpeg") {
      result = "data:image/jpeg;base64,";
    } else if (data == "jpg") {
      result = "data:image/jpg;base64,";
    } else if (data == "gif") {
      result = "data:image/gif;base64,";
    }
    return result;
  }

  static Future<String> compressFile({File file, int quality}) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      quality: quality,
    );

    return getExtension(file.toString()) + base64.encode(result);
  }

  static Future<ByteData> createLabelImage({
    String text,
    Color backgroundColor,
    TextStyle textStyle,
  }) {
    Paint paint = Paint();

    paint.color = backgroundColor ?? Colors.white;

    PictureRecorder recorder = new PictureRecorder();
    Canvas c = new Canvas(recorder);
    c.drawPaint(paint); // etc

    TextSpan span = new TextSpan(
        style: textStyle ??
            new TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
        text: " ${text ?? "label"} ");
    TextPainter tp = new TextPainter(
      text: span,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(c, new Offset(0.0, 0.0));

    Picture p = recorder.endRecording();

    return p
        .toImage(tp.size.width.toInt(), tp.size.height.toInt())
        .then((value) {
      return value.toByteData(format: ImageByteFormat.png);
    });
  }

  //void
}
