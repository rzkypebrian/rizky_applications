import 'dart:convert';
import 'dart:ui';

import 'package:enerren/app/angkut/aTransporter/localData.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/model/NotificationSettingModel.dart';
import 'package:enerren/util/ApiEndPointUtil.dart';
import 'package:enerren/util/ColorUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/NotificationHandlerUtil.dart';
import 'package:enerren/util/OneSignalMessaging.dart';
import 'package:enerren/util/ResourceUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/app/inovaPickUp/aTransporter/peopleTransportRoute.dart'
    as route;
import 'package:enerren/app/angkut/util/ColorUtil.dart';
import 'package:enerren/app/inovaPickup/util/ApiEndPoint.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:enerren/app/inovaPickUp/util/ResourceUtil.dart';

void main() {
  System.data.colorUtil = ColorUtil().angkutColor();
  System.data.resource = ResourceUtil.ind().peopleTransportId();
  System.data.initialRouteName = route.initialEouteName;
  System.data.unAuthorizeRouteName = route.RouteName.login;
  System.data.mapRoute = route.routes;
  System.data.localData = LocalData();
  System.data.apiEndPointUtil =
      ApiEndPointUtil().inovaPickUpTransporterEndPoint();
  System.data.oneSignalMessaging = new OneSignalMessaging(
      appId: "6796dcfe-b86b-40be-832f-439558df6698",
      notificationHandler: (notif) {
        ModeUtil.debugPrint("isi notif ${notif.body}");
        NotificationSettingModel _setting;
        try {
          _setting = NotificationSettingModel.fromJson(
              json.decode(notif.additionalData["setting"]));
        } catch (e) {
          ModeUtil.debugPrint("$e");
        }
        return ModalComponent.modalNotification(
          title: NotificationHandlerUtil.readNotification(
              notif.additionalData[ConstantUtil.title], notif.title),
          titleColor:
              _setting.titleColor != null ? Color(_setting.titleColor) : null,
          body: NotificationHandlerUtil.readNotification(
              notif.additionalData[ConstantUtil.body], notif.body),
          bodyColor:
              _setting.bodyColor != null ? Color(_setting.bodyColor) : null,
          imageUrl: notif.smallIcon,
          imageBackgroundColor: Color(0xffBEFFDA),
        );
      });
  System.data.androidUpdateUrl =
      "https://play.google.com/store/apps/details?id=com.enerren.angkut.transporter";
  inovaStye();
}

void inovaStye() {
  System.data.androidUpdateUrl =
      "https://play.google.com/store/apps/details?id=com.enerren.angkut.customer";
  //setting for sample App
  System.data.global.circularProgressIndicatorAnimatorAssets =
      "assets/flares/loader_general_2.flr";
  System.data.global.circularProgressIndicatorAnimatorLightAssets =
      "assets/flares/loader_general_2.flr";
  System.data.global.circularProgressIndicatorAnimation = "play";
  System.data.global.splascreenAnimationAssets =
      "assets/flares/inova_pickup.flr";
  System.data.global.splasscreenAnimationName = "play";
  System.data.global.companyVerticalLogoAssets =
      "assets/angkut/logo_inova_pickup_vertical.svg";
  System.data.global.companyHorizontalLogoAssets =
      "assets/angkut/logo_inova_pocup_horizontal.svg";
}
