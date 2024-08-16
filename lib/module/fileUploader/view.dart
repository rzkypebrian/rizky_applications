import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/imagePickerComponent.dart';
import 'package:enerren/component/signatureComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Image Uploader",
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    child: ImagePickerComponent(
                      controller: controller,
                      camera: true,
                      galery: true,
                      uploadField: "media",
                      uploadUrl:
                          "http://api-dev.turnamengame.com/api/Fileservice/upload?path=productcategory&name=987654321",
                      containerHeight: 100,
                      containerWidth: 100,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      child: Center(
                        child: BottonComponent.neonButton(
                          text: "Upload",
                          onTap: () {
                            print("start uoload");
                            uploadFile(controller.getFile());
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: System.data.colorUtil.primaryColor,
                        width: 1,
                      )),
                      child: Stack(
                        children: [
                          SignatureComponent(
                            controller: super.signControler,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Center(
                        child: BottonComponent.neonButton(
                          text: "Upload",
                          onTap: () {
                            print("start uoload");
                            // uploadByte(signControler.getByteData);
                            uploadSignature();
                          },
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
