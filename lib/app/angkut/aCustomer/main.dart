import 'package:enerren/app/angkut/aCustomer/LocalData.dart';
import 'package:enerren/util/ApiEndPointUtil.dart';
import 'package:enerren/util/ChatHandlingUtil.dart';
import 'package:enerren/util/ColorUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/OneSignalMessaging.dart';
import 'package:enerren/util/ResourceUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/app/angkut/aCustomer/route.dart' as route;
import 'package:enerren/app/angkut/util/ColorUtil.dart';
import 'package:enerren/app/angkut/util/ApiEndPoint.dart';
import 'package:enerren/app/angkut/util/ResourceUtil.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  System.data.global.googleMapApiKey =
      "AIzaSyByt2IOztZscq6-dpO_3nGxVajuFOduDY0";
  System.data.initialRouteName = route.initialRouteName;
  System.data.unAuthorizeRouteName = route.RouteName.login;
  System.data.unAuthorizeRouteNameLimit = route.RouteName.dashboard;
  System.data.mapRoute = route.routes;
  System.data.colorUtil = ColorUtil().angkutColor();
  System.data.localData = LocalData();
  System.data.resource = ResourceUtil.ind().angkutId();
  System.data.apiEndPointUtil = ApiEndPointUtil().angkutCustomerApiEndPoint();
  System.data.oneSignalMessaging = new OneSignalMessaging(
    // appId: "153fc0c9-eb4f-4136-bbd1-b60deca7fbd0", //customer
    appId: "7121fff2-67b6-48b5-a5b4-58856dd81ae9", //customer new
    // appId: "7393454b-15bf-42b3-b181-0b938df232d9", //driver
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
  System.data.permission.add(Permission.location);
  System.data.androidUpdateUrl =
      "https://play.google.com/store/apps/details?id=com.enerren.angkut.customer";
  System.data.iosUpdateUrl = "https://apps.apple.com/app/id1566868828";
  System.data.global.otpAddressSource = "ANGKUT";
  // inovaStye();
}

void inovaStye() {
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
