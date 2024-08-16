import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/cgPicker.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/module/emptyModule/presenterImageCompress.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:flutter/material.dart';

class ViewCompress extends PresenterStateImageCompress {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Copress image"),
                Container(
                  width: 100,
                  margin: EdgeInsets.only(top: 10),
                  child: BottonComponent.roundedButton(
                    text: "open gelery",
                    onPressed: () {
                      cgPickerController.getImages();
                    },
                  ),
                ),
                images(),
              ],
            ),
          ),
          CircularProgressIndicatorComponent(
            controller: controller,
            height: 100,
            width: 100,
            aligment: Alignment.bottomCenter,
          )
        ],
      ),
    );
  }

  Widget images() {
    return Container(
      margin: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          // getBase64
          ModeUtil.debugPrint(cgPickerController.getAll()[0]);
          ModeUtil.debugPrint(cgPickerController.getAll()[1]);
          ModeUtil.debugPrint(cgPickerController.getAll()[2].toString());
          // to clear data
          cgPickerController.disposes();
        },
        child: CgPicker(
          // circular: false,
          radius: 10,
          cgPickerController: cgPickerController,
          width: 300,
          height: 300,
          childs: Center(
            child: IconButton(
              iconSize: 70,
              onPressed: () {
                cgPickerController.getImages();
              },
              icon: Icon(Icons.camera),
            ),
          ),
        ),
      ),
    );
  }
}
