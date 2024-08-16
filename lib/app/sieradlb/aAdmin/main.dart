import 'dart:convert';
import 'dart:ui';

import 'package:enerren/app/sierad/aTransporter/localData.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/model/NotificationSettingModel.dart';
import 'package:enerren/util/ApiEndPointUtil.dart';
import 'package:enerren/util/ColorUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/OneSignalMessaging.dart';
import 'package:enerren/util/ResourceUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/app/sieradlb/aAdmin/route.dart' as route;
import 'package:enerren/app/sieradlb/util/ColorUtil.dart';
import 'package:enerren/app/sieradlb/util/ApiEndPointUtil.dart';

void main() {
  System.data.colorUtil = ColorUtil().sieradLBAdminColor();
  System.data.resource = ResourceUtil.ind();
  System.data.initialRouteName = route.initialEouteName;
  System.data.unAuthorizeRouteName = route.RouteName.login;
  System.data.mapRoute = route.routes;
  System.data.localData = LocalData();
  System.data.apiEndPointUtil = ApiEndPointUtil().sieradLBAdminApiEndPoint();
  System.data.oneSignalMessaging = new OneSignalMessaging(
    appId: "779c36ef-93f6-478d-990a-9c06230c7c32",
    notificationHandler: (notif) {
      NotificationSettingModel _setting;
      try {
        _setting = NotificationSettingModel.fromJson(
            json.decode(notif.additionalData["setting"]));
      } catch (e) {
        ModeUtil.debugPrint("$e");
      }
      ModeUtil.debugPrint(notif.smallIcon);
      return ModalComponent.modalNotification(
        title: notif.title,
        titleColor:
            _setting.titleColor != null ? Color(_setting.titleColor) : null,
        body: notif.body,
        bodyColor:
            _setting.bodyColor != null ? Color(_setting.bodyColor) : null,
        imageUrl: notif.smallIcon,
        imageBackgroundColor: Color(0xffBEFFDA),
      );
    },
  );
}
