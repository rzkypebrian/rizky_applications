import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => super.vm,
      child: Consumer<ViewModel>(
        builder: (ctx, vm, child) {
          return Scaffold(
              appBar: appBar(vm),
              backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
              body: body(vm));
        },
      ),
    );
  }

  Widget appBar(ViewModel vm) {
    return BottonComponent.customAppBar1(
        context: context,
        actionText: "",
        title: System.data.resource.uploadImage,
        backgroundColor: System.data.colorUtil.primaryColor,
        titleStyle: System.data.textStyleUtil.mainTitle(
          color: System.data.colorUtil.lightTextColor,
        ),
        backButtonColor: System.data.colorUtil.lightTextColor);
  }

  Widget body(ViewModel vm) {
    return Container(
      height: 200,
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Image.asset(
            "assets/background_about.png",
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: 140,
              margin: EdgeInsets.only(left: 40),
              height: 160,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/sign_about.png",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 80,
                        width: 150,
                        color: Colors.red.withOpacity(0.3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${System.data.resource.appVersion}",
                              textAlign: TextAlign.center,
                              style: System.data.textStyleUtil.mainLabel(
                                fontSize: System.data.fontUtil.xl,
                              ),
                            ),
                            Text(
                              "${System.data.version}",
                              textAlign: TextAlign.center,
                              style: System.data.textStyleUtil.mainLabel(
                                fontSize: System.data.fontUtil.xl,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
