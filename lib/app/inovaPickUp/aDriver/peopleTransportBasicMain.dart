import 'package:enerren/app/angkut/aDriver/localData.dart';
import 'package:enerren/util/ApiEndPointUtil.dart';
import 'package:enerren/util/ChatHandlingUtil.dart';
import 'package:enerren/util/ColorUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/OneSignalMessaging.dart';
import 'package:enerren/util/ResourceUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/app/inovaPickUp/aDriver/peopleTransportBasicRoute.dart'
    as route;
import 'package:enerren/app/angkut/util/ColorUtil.dart';
import 'package:enerren/app/inovaPickup/util/ApiEndPoint.dart';
import 'package:enerren/app/angkut/util/ResourceUtil.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  System.data.global.googleMapApiKey =
      "AIzaSyByt2IOztZscq6-dpO_3nGxVajuFOduDY0";
  System.data.initialRouteName = route.initialEouteName;
  System.data.unAuthorizeRouteName = route.RouteName.login;
  System.data.mapRoute = route.routes;
  System.data.colorUtil = ColorUtil().angkutDriver();
  System.data.localData = new LocalData();
  System.data.resource = new ResourceUtil.ind().angkutId();
  System.data.apiEndPointUtil =
      ApiEndPointUtil().inovaPickUpDriverApiEndPoint();
  System.data.androidUpdateUrl =
      "https://play.google.com/store/apps/details?id=com.enerren.angkut.driver";
  System.data.oneSignalMessaging = new OneSignalMessaging(
    appId: "7393454b-15bf-42b3-b181-0b938df232d9",
    notificationHandler: (value) {
      var data = value.additionalData["data"];
      String type = value.additionalData["type"];
      switch (type) {
        case "ChattingViewModel":
          ChatHandleUtil.handleTextChat(data);
          break;
      }
    },
    notificationClickedHandler: (value) {
      ModeUtil.debugPrint("notificationClickedHandler ");
      System.data.routes.pushNamed(System.data.context, route.RouteName.login);
    },
    notificationOpenedHandler: (value) {
      ModeUtil.debugPrint("notificationOpenedHandler ");
      ModeUtil.debugPrint(value.notification.body);
      // DeviceApps.openApp("com.enerren.sierad.customer");
    },
  );
  System.data.permission = [
    Permission.camera,
    Permission.location,
    Permission.reminders,
  ];
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
