import 'dart:convert';
import 'dart:ui';

import 'package:enerren/app/tms/aCustomer/localData.dart';
import 'package:enerren/component/ModalComponent.dart';
// import 'package:enerren/model/NotificationModel.dart';
import 'package:enerren/model/NotificationSettingModel.dart';
import 'package:enerren/util/ApiEndPointUtil.dart';
import 'package:enerren/util/ColorUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/OneSignalMessaging.dart';
import 'package:enerren/util/ResourceUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/app/tms/aCustomer/route.dart' as route;
import 'package:enerren/app/tms/util/ColorUtil.dart';
import 'package:enerren/app/tms/util/ApiEndPointUtil.dart';
import 'package:enerren/util/constantUtil.dart';

Future<void> main() async {
  System.data.colorUtil = ColorUtil().tmsCustomerColor();
  System.data.resource = ResourceUtil.ind();
  System.data.initialRouteName = route.initialEouteName;
  System.data.unAuthorizeRouteName = route.RouteName.login;
  System.data.mapRoute = route.routes;
  System.data.localData = LocalData();
  System.data.apiEndPointUtil = ApiEndPointUtil().tmsCustomerApiEndPoimt();
  System.data.oneSignalMessaging = new OneSignalMessaging(
      appId: "6ad1200f-3014-4c51-b67f-38119b3f2d81",
      notificationHandler: (notif) {
        ModeUtil.debugPrint("on receive notification");
        NotificationSettingModel _setting;
        try {
          _setting = NotificationSettingModel.fromJson(
              json.decode(notif.additionalData["setting"]));
        } catch (e) {
          ModeUtil.debugPrint("$e");
        }
        // try {
        //   NotificationModel.addData(
        //     System.data.database.db,
        //     new NotificationModel(
        //       title: notif.title,
        //       body: notif.body,
        //       setting: _setting.toJson(),
        //       smallIcon: notif.smallIcon,
        //       userId: "",
        //       dataType: "",
        //       data: {},
        //     ),
        //   );
        // } catch (e) {
        //   ModeUtil.debugPrint("$e");
        // }
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
        );
      });
}
