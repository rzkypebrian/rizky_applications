import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/component/signatureComponent.dart';
import 'package:enerren/module/deliveryPod/ViewModel.dart';
import 'package:enerren/module/deliveryPod/signatureOnlyPresenter.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignatureOnlyView extends SignatureOnlyPresenterState {
  @override
  Widget build(Object context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (ctx) => super.model,
      child: Scaffold(
        appBar: appBar(),
        body: Stack(
          children: [
            body(),
            circularProgressIndicatorDecoration(),
          ],
        ),
        backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
        bottomNavigationBar: buttonNavigationBar(),
      ),
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularProgressDecoration(
      controller: super.model.loadingController,
    );
  }

  Widget body() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            height: 420,
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                   BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
                ]),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        "${System.data.resource.signature}",
                        style: System.data.textStyleUtil.linkLabel(),
                      ),
                      Consumer<ViewModel>(
                        builder: (ctx, data, child) {
                          return Container(
                            height: 320,
                            margin: EdgeInsets.only(top: 15),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: model.isValidImagePicker
                                    ? Colors.transparent
                                    : System.data.colorUtil.redColor,
                              ),
                            ),
                            child: SignatureComponent(
                              controller:
                                  super.model.signatureComponentController,
                              onSign: () {},
                              builder: (context, value, component) {
                                return Container(
                                  margin: EdgeInsets.only(top: 20),
                                  height: 300,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2,
                                          color: super.model.isSignatureValid ==
                                                  true
                                              ? System.data.colorUtil
                                                  .borderInputColor
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  super
                                                      .model
                                                      .signatureComponentController
                                                      .clear();
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(FontAwesomeLight(
                                                      FontAwesomeId.fa_eraser)),
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
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget circularProgressIndicator() {
    return DecorationComponent.circularProgressDecoration(
      controller: model.loadingController,
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      context: context,
      actionText: "",
      title: "${widget.title ?? System.data.resource.pod}",
      titleStyle: System.data.textStyleUtil.mainTitle(
        color: System.data.colorUtil.lightTextColor,
      ),
      backButtonColor: System.data.colorUtil.lightTextColor,
      backgroundColor: System.data.colorUtil.primaryColor,
    );
  }

  Widget buttonNavigationBar() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: BottonComponent.mainBotton(
        text: "${System.data.resource.next}",
        backgroundColor: System.data.colorUtil.primaryColor,
        onTap: () {
          if (!model.loadingController.onLoading) {
            submit();
          }
        },
      ),
    );
  }
}
