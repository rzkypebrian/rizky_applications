import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/signatureComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'view.dart';

class PopUpSignaturePad extends View {
  @override
  List<Widget> listComponent() {
    return <Widget>[
      inputReceiverName(),
      viewPod(),
      inputImage(),
      inputBarcode(),
    ];
  }

  Widget viewPod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "e-POD",
          style: System.data.textStyleUtil.mainLabel(),
        ),
        SignatureComponent(
          controller: super.model.signatureComponentController,
          onSign: onSign,
          builder: (context, value, component) {
            return Container(
              margin: EdgeInsets.only(top: 20),
              height: 300,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2,
                      color: super.model.isSignatureValid == true
                          ? System.data.colorUtil.borderInputColor
                          : Colors.red,
                      style: BorderStyle.solid)),
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            image: (Uri.parse(value?.base64File)?.data)
                                        ?.contentAsBytes() !=
                                    null
                                ? DecorationImage(
                                    image: MemoryImage(
                                      (Uri.parse(value?.base64File)?.data)
                                          ?.contentAsBytes(),
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            popUpPod();
                          },
                          child: Container(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              popUpPod();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(FontAwesomeLight(
                                  FontAwesomeId.fa_pencil_alt)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }

  void popUpPod() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            color: Colors.grey.withOpacity(0.1),
            child: Center(
              child: Container(
                color: Colors.white,
                width: double.infinity,
                margin: EdgeInsets.only(left: 15, right: 15),
                padding: EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height / 2,
                child: inputPod(
                  newContext: ctx,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget inputPod({BuildContext newContext}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SignatureComponent(
          controller: super.model.signatureComponentController,
          onSign: onSign,
          builder: (newContext, value, component) {
            return Container(
              margin: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height / 2 - 110,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2,
                      color: super.model.isSignatureValid == true
                          ? System.data.colorUtil.borderInputColor
                          : Colors.red,
                      style: BorderStyle.solid)),
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  component,
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              super.model.signatureComponentController.clear();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                  FontAwesomeLight(FontAwesomeId.fa_eraser)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: BottonComponent.roundedButton(
              text: System.data.resource.ok,
              colorBackground: System.data.colorUtil.primaryColor,
              textstyle: System.data.textStyleUtil.mainTitle(
                color: System.data.colorUtil.lightTextColor,
              ),
              onPressed: () {
                Navigator.of(newContext).pop();
              }),
        )
      ],
    );
  }
}
