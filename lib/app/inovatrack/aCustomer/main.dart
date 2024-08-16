import 'package:enerren/app/inovatrack/aCustomer/localData.dart';
import 'package:enerren/util/ApiEndPointUtil.dart';
import 'package:enerren/util/OneSignalMessaging.dart';

import 'route.dart' as route;

import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/ColorUtil.dart';
import 'package:enerren/app/inovatrack/util/colorUtil.dart';
import 'package:enerren/app/inovatrack/util/apiEndPointUtil.dart';

void main() {
  System.data.colorUtil = ColorUtil().inovatrackColor();
  System.data.apiEndPointUtil = ApiEndPointUtil().inovatrackApi();
  System.data.localData = new LocalData();
  System.data.initialRouteName = route.initialRouteName;
  System.data.mapRoute = route.routes;
  System.data.oneSignalMessaging = new OneSignalMessaging(
      // appId: "1b81728c-4694-406d-bbeb-a332ccbcc777",
      // notificationHandler: (notif) {},
      );
  return;
}
