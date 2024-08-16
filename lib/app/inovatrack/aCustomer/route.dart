import 'dart:convert';

import 'package:enerren/app/inovatrack/aCustomer/localData.dart';
import 'package:enerren/app/inovatrack/aCustomer/module/dashboard/main.dart'
    as dashboard;
import 'package:enerren/app/inovatrack/aCustomer/module/login/main.dart'
    as login;
import 'package:enerren/app/inovatrack/aCustomer/module/Setting/main.dart'
    as setting;
import 'package:enerren/app/inovatrack/aCustomer/module/splashScreen/main.dart'
    as splashScreen;
import 'package:enerren/app/inovatrack/aCustomer/module/listVehicle/main.dart'
    as listVehicle;
import 'package:enerren/app/inovatrack/aCustomer/module/detailVehicle/main.dart'
    as detailVehicle;
import 'package:enerren/app/inovatrack/aCustomer/module/maps/main.dart' as maps;
import 'package:enerren/app/inovatrack/aCustomer/module/pin/main.dart' as pin;
import 'package:enerren/module/historyMap/main.dart' as history;
import 'package:enerren/module/contactAddress/main.dart' as contact;
import 'package:enerren/app/inovatrack/model/userModel.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/util/StringExtention.dart';

class RouteName {
  static const String dashboard = "dashboard";
  static const String login = "login";
  static const String setting = "setting";
  static const String splashScreen = "splashScreen";
  static const String maps = "maps";
  static const String listVehicle = "listVehicle";
  static const String detailVehicle = "detailVehicle";
  static const String pin = "pin";
  static const String inputPin = "inputPin";
  static const String history = "history";
  static const String contact = "contact";
}

enum ParamName {
  Dashboard,
  Login,
  Setting,
  VtsPositionModel,
}

String initialRouteName = RouteName.splashScreen;

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  RouteName.splashScreen: (BuildContext context) => splashScreen.Presenter(
        view: splashScreen.InovatrackView(),
        onFinishSpashScreen: () {
          if (System.data.getLocal<LocalData>().user == null) {
            System.data.routes.pushAndReplaceName(context, RouteName.login);
          } else {
            if (System.data.global.token.isNullOrEmpty()) {
              System.data.routes.pushAndReplaceName(context, RouteName.login);
            } else if (System.data.global.pin == null) {
              System.data.routes.pushAndReplaceName(context, RouteName.pin);
            } else {
              ModeUtil.debugPrint("pin is ${System.data.global.pin}");
              System.data.routes
                  .pushAndReplaceName(context, RouteName.inputPin);
            }
          }
        },
      ),
  RouteName.login: (BuildContext context) => login.Presenter(
        view: login.InovatrackView(),
        containerHeight: 408,
        onLoginSuccess: (data) {
          System.data.getLocal<LocalData>().user = UserModel.fromJson(data);
          System.data.sharedPreferences.setString(PrefsKey.user,
              json.encode(System.data.getLocal<LocalData>().user));
          System.data.global.token =
              System.data.getLocal<LocalData>().user.token;
          System.data.sharedPreferences
              .setString(PrefsKey.token, System.data.global.token);
          System.commit();
          System.data.routes.pushNamed(context, RouteName.pin);
        },
      ),
  RouteName.dashboard: (BuildContext context) => dashboard.Presenter(
        view: dashboard.InovatrackView(onTapSetting: () {
          System.data.routes.pushNamed(context, RouteName.setting);
        }, onTapListVehicle: () {
          System.data.routes.pushNamed(context, RouteName.listVehicle);
        }, onTapMaps: () {
          System.data.routes.pushNamed(context, RouteName.maps);
        }, onTapContact: () {
          System.data.routes.pushNamed(context, RouteName.contact);
        }),
      ),
  RouteName.setting: (BuildContext context) => setting.Presenter(
        view: setting.InovatrackView(
          logout: () {
            System.data.sharedPreferences.setString(PrefsKey.user, null);
            System.data.routes
                .pushNamedAndRemoveUntil(context, RouteName.login, "");
          },
        ),
      ),
  RouteName.maps: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return maps.Presenter(
      token: System.data.global.token,
      userId: System.data.getLocal<LocalData>().user.userId,
      view: maps.InovatrackView(
        selectedVehicle: arg[ParamName.VtsPositionModel],
        onTapinfo: (vehicle) {
          System.data.routes.pushNamed(
            context,
            RouteName.detailVehicle,
            arguments: {
              ParamName.VtsPositionModel: vehicle,
            },
          );
        },
      ),
    );
  },
  RouteName.listVehicle: (BuildContext context) => listVehicle.Presenter(
        tokemVts: System.data.global.token,
        userIdVts: System.data.getLocal<LocalData>().user.userId,
        onTapListItem: (vehicle) {
          System.data.routes
              .pushNamed(context, RouteName.detailVehicle, arguments: {
            ParamName.VtsPositionModel: vehicle,
          });
        },
      ),
  RouteName.detailVehicle: (BuildContext context) {
    Map<dynamic, dynamic> arg = ModalRoute.of(context).settings.arguments ?? {};
    return detailVehicle.Presenter(
      autoRefresh: true,
      vtsPositionModel: arg[ParamName.VtsPositionModel],
      onTapMap: (vehicle) {
        System.data.routes.pushNamed(context, RouteName.maps, arguments: {
          ParamName.VtsPositionModel: vehicle,
        });
      },
    );
  },
  RouteName.pin: (BuildContext context) => pin.Presenter(
        view: pin.InovatrackView(),
        onPinSaved: (pin) {
          System.data.routes
              .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
        },
        onTapRelogin: () {
          System.data.routes.pushNamed(context, RouteName.login);
        },
      ),
  RouteName.inputPin: (BuildContext context) => pin.Presenter(
        view: pin.InovatrackInputPinView(),
        onPinSaved: (pin) {
          System.data.routes
              .pushNamedAndRemoveUntil(context, RouteName.dashboard, "");
        },
        onTapRelogin: () {
          System.data.routes.pushNamed(context, RouteName.login);
        },
      ),
  RouteName.history: (BuildContext context) => history.Presenter(),
  RouteName.contact: (BuildContext context) => contact.Presenter(
        mainContentCorner: 0,
        backgroundHeighScala: 3.3,
        data: contact.ViewModel(
          headOfficeAddress:
              "Gedung Graha kapital 1, Lt 1, Suite 101 Jl. Kemang Raya No. 4, Jakarta Selatan, 12730, Indonesia",
          headOfficeLat: -6.2560945, 
          headOfficeLon: 106.8115211,
          headOfficePhone: ['021-719-8618', '021-719-8619'],
          headOfficeEmail: ['info@enerren.com'],
          headOfficeFax: '021-719-9525',
        ),
      )
};
