import 'dart:async';
import 'package:enerren/util/StringUtil.dart';
import 'package:flutter/material.dart';
import 'SystemUtil.dart';

class NavigationUtil {
  List<RouteHistory> routeHistory = [];

  NavigationUtil();

  static void navTo(BuildContext context, StatefulWidget page,
      {bool canBack = true, int second = 0}) {
    Timer(Duration(seconds: second), () {
      if (canBack) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      }
    });
  }

  static void navToAndClearHistory(BuildContext context, StatefulWidget page) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page),
        (x) => x.isActive == false);
  }

  //function for record history
  void pushNamed(
    BuildContext context,
    String routeName, {
    Object arguments,
    bool needConfirm = false,
    String confirmMessage = "",
    VoidCallback onBack,
  }) {
    // Navigator.of(context).pushNamed(routeName, arguments: arguments);
    System.data.navigatorKey.currentState
        .pushNamed(routeName, arguments: arguments);
    routeHistory.add(RouteHistory(
      routeName: routeName,
      needConfirm: needConfirm,
      confirmMessage: confirmMessage,
      onBack: onBack,
    ));
  }

  Future<void> push(
    BuildContext context,
    StatefulWidget page, {
    Object arguments,
    bool needConfirm = false,
    String confirmMessage = "",
    VoidCallback onBack,
  }) async {
    // Navigator.of(context).pushNamed(routeName, arguments: arguments);
    await System.data.navigatorKey.currentState.push(
      MaterialPageRoute(
        builder: (context) => page,
        settings: RouteSettings(arguments: arguments),
      ),
    );
    routeHistory.add(
      RouteHistory(
        routeName: StringUtil.getRandomString(10),
        needConfirm: needConfirm,
        confirmMessage: confirmMessage,
        onBack: onBack,
      ),
    );
  }

  void pushAndReplaceName(
    BuildContext context,
    String routeName, {
    Object arguments,
    bool needConfirm = false,
    String confirmMessage = "",
    VoidCallback onBack,
  }) {
    routeHistory.removeLast();
    routeHistory.add(
      RouteHistory(
        routeName: routeName,
        needConfirm: needConfirm,
        confirmMessage: confirmMessage,
        onBack: onBack,
      ),
    );
    // Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
    System.data.navigatorKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  void pushNamedAndRemoveUntil(
    BuildContext context,
    String routeName,
    String untilRouteName, {
    Object arguments,
    bool needConfirm = false,
    String confirmMessage = "",
    VoidCallback onBack,
  }) {
    // Navigator.of(context).pushNamedAndRemoveUntil(
    //     routeName, (x) => x.settings.name == untilRouteName,
    //     arguments: arguments);
    System.data.navigatorKey.currentState.pushNamedAndRemoveUntil(
        routeName, (x) => x.settings.name == untilRouteName,
        arguments: arguments);

    while (routeHistory.length > 0 &&
        routeHistory.last.routeName != untilRouteName) {
      routeHistory.removeLast();
    }

    routeHistory.add(RouteHistory(
      routeName: routeName,
      needConfirm: needConfirm,
      confirmMessage: confirmMessage,
      onBack: onBack,
    ));
  }

  void pop<T>(BuildContext context, [T result]) {
    removeLast();
    System.data.navigatorKey.currentState.pop(result);
  }

  void removeLast() {
    if (routeHistory.last.onBack != null) {
      routeHistory.last.onBack();
    }
    routeHistory.removeLast();
  }
}

class RouteHistory {
  String routeName;
  bool needConfirm;
  String confirmMessage;
  VoidCallback onBack;

  RouteHistory({
    this.routeName,
    this.needConfirm = false,
    this.confirmMessage = "",
    this.onBack,
  });
}
