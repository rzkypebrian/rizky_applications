import 'package:enerren/model/DriverModel.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/app/sample/driver/module/login/main.dart' as login;

import 'localData.dart';

//definisikan enum name alur program anda disini
class RouteName {
  static const String login = "login";
}

//definisikan initial root name
String initialEouteName = RouteName.login;

//definisikan alur program aplikasi anda disini
Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RouteName.login: (BuildContext context) => login.Presenter(
        view: login.DriverView(),
        onLoginSuccess: ((response) {
          System.data.getLocal<LocalData>().user =
              DriverModel.fromJson(response);
          ModeUtil.debugPrint(
              System.data.getLocal<LocalData>().user.driverName);
        }),
        onSubmitSuccess: () {},
      ),
};

//initialize and add another route here
Map<String, WidgetBuilder> generateRoute() {
  Map<String, WidgetBuilder> data = routes;

  return data;
}
