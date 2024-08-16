import 'dart:typed_data';

import 'package:enerren/component/BottonComponent.dart';
import 'package:flutter/material.dart';
import 'package:enerren/util/ImageUtil.dart';

class GenerateImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GenerateImageView();
  }
}

abstract class GenerateImageState extends State<GenerateImage> {}

class GenerateImageView extends GenerateImageState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BottonComponent.customAppBar1(
        context: context,
        actionText: "",
        title: "Generate Image",
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.red,
              child: FutureBuilder<ByteData>(
                future: ImageUtil.createLabelImage(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<ByteData> snapshot,
                ) {
                  return Image.memory(snapshot.data.buffer.asUint8List());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
