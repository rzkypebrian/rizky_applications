import 'package:enerren/util/ApiEndPointUtil.dart';
import 'package:enerren/util/ChatHandlingUtil.dart';
import 'package:enerren/util/ColorUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/OneSignalMessaging.dart';
import 'package:enerren/util/ResourceUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/app/sample/util/ColorUtil.dart';
import 'package:enerren/app/sample/customer/route.dart' as route;
import 'package:enerren/app/sample/util/ApiEndPointUtil.dart';
// import 'package:flutter/material.dart';

void main() {
  System.data.resource = ResourceUtil.ind();
  System.data.initialRouteName = route.initialRouteName;
  System.data.mapRoute = route.routes;
  System.data.apiEndPointUtil = ApiEndPointUtil().sampleDriverApiEndPoimt();
  System.data.colorUtil = ColorUtil().sieradCustomerColor();
  // System.data.global.token = //customer
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9zaWQiOiIxNCIsImFjdG9ydCI6IkMiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9tb2JpbGVwaG9uZSI6Iis2Mjg1NzE0MjY4Njc0IiwiY2VydHNlcmlhbG51bWJlciI6ImJmZjQ1NzA4LWExNmQtNGFiZC05YWI2LTU1Njk2ZGEwMTc3OCIsIm5iZiI6MTYxODM5NTUxOSwiZXhwIjoxNjM0MTIwMzE5LCJpYXQiOjE2MTgzOTU1MTl9.hkK7643fYu3dJm-fWqgwvJWaozk6ASpXNJPDTDpT3uc";
  System.data.global.token = //driver
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9zaWQiOiIxMiIsImFjdG9ydCI6IkQiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9tb2JpbGVwaG9uZSI6IjA4NTcxNDI2ODY3NCIsImNlcnRzZXJpYWxudW1iZXIiOiIyZjZmMzdjYi1iOTc1LTQ5M2YtYjk3My03NDE1YjM2OWRjYjUiLCJuYmYiOjE2MTgzOTMxNTksImV4cCI6MTYzNDExNzk1OSwiaWF0IjoxNjE4MzkzMTU5fQ.gy23Hf-lC59yyBgmXp6wYJVDd_NL1EecucF3crluK3Y";
  // System.data.oneSignalMessaging = new OneSignalMessaging(
  System.data.oneSignalMessaging = new OneSignalMessaging(
    // appId: "153fc0c9-eb4f-4136-bbd1-b60deca7fbd0", //customer
    appId: "7393454b-15bf-42b3-b181-0b938df232d9", //driver
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
}
