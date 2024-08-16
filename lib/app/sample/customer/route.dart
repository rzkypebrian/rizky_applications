import 'package:enerren/app/sample/customer/module/login/main.dart' as login;
import 'package:enerren/module/home/main.dart' as home;
import 'package:enerren/module/chat/main.dart' as module;
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

//definisikan enum name alur program anda disini
class RouteName {
  static const String home = "home";
  static const String login = "login";
  static const String module = "module";
}

//definisikan initial root name
String initialRouteName = RouteName.module;

//definisikan alur program aplikasi anda disini
Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RouteName.home: (BuildContext context) => home.Presenter(
        onTapModule: () {
          ModeUtil.debugPrint("masuk sini");
          System.data.routes.pushNamed(context, RouteName.login);
        },
      ),
  RouteName.login: (BuildContext context) => login.Presenter(
        view: login.CustomerView(),
        onLoginSuccess: (json) {},
        onSubmitSuccess: () {},
      ),
  RouteName.module: (BuildContext context) => module.Presenter(
        senderId: 14,
        senderTypeId: 1,
        senderName: "agumtest@mail.com",
        tmsShipmentId: 841,
      )
};
