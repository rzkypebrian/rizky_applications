import 'dart:convert';
import 'package:enerren/app/sierad/aDriver/localData.dart';
import 'package:enerren/app/sierad/aDriver/route.dart' as route;
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/model/NotificationSettingModel.dart';
import 'package:enerren/util/ApiEndPointUtil.dart';
import 'package:enerren/util/ColorUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/OneSignalMessaging.dart';
import 'package:enerren/util/ResourceUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/app/sierad/util/ColorUtil.dart';
import 'package:enerren/app/sierad/util/ApiEndPointUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  System.data.colorUtil = ColorUtil().sieradColor();
  System.data.resource = ResourceUtil.ind();
  System.data.initialRouteName = route.initialEouteName;
  System.data.unAuthorizeRouteName = route.RouteName.login;
  System.data.mapRoute = route.routes;
  System.data.localData = LocalData();
  System.data.apiEndPointUtil = ApiEndPointUtil().sieradApiEndPoint();
  System.data.oneSignalMessaging = new OneSignalMessaging(
    appId: "2bc39b30-91c4-4afc-96a6-bfbed2e8ba54",
    notificationHandler: (notif) {
      NotificationSettingModel _setting;
      try {
        _setting = NotificationSettingModel.fromJson(
            json.decode(notif.additionalData[ConstantUtil.setting]));
      } catch (e) {
        ModeUtil.debugPrint("$e");
      }
      ModeUtil.debugPrint(notif.smallIcon);
      return ModalComponent.modalNotification(
        title: json.decode(notif.additionalData[ConstantUtil.title])[
            "${System.data.resource.lang.replaceAll("-", "_")}"],
        titleColor:
            _setting.titleColor != null ? Color(_setting.titleColor) : null,
        body: json.decode(notif.additionalData[ConstantUtil.body])[
            "${System.data.resource.lang.replaceAll("-", "_")}"],
        bodyColor:
            _setting.bodyColor != null ? Color(_setting.bodyColor) : null,
        imageUrl: notif.smallIcon,
        imageBackgroundColor: Color(0xffBEFFDA),
        onTapOk: () {
          switch (notif.additionalData[ConstantUtil.messageType]) {
            case ConstantUtil.ship2D:
              System.data.routes.pushNamed(
                  System.data.navigatorKey.currentContext,
                  route.RouteName.history);
              break;
            default:
              return;
              break;
          }
        },
      );
    },
  );
  System.data.permission = [
    Permission.camera,
    Permission.location,
    Permission.microphone,
    Permission.accessMediaLocation,
  ];
}
