import 'dart:async';

import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/util/ModeUtil.dart';

mixin MainProcess<T extends StatefulWidget> on State<T> {
  Timer autoRefresh;

  void globalTickRefresh() async {
    setState(() {
      ModeUtil.debugPrint("global tick refresh");
    });
  }

  void localTickRefresh() async {
    // await globalTickRefresh();
    ModeUtil.debugPrint("on tick refresh main");
  }

  void localTick() {
    setState(() {
      ModeUtil.debugPrint("local tick");
    });
  }

  @override
  void initState() {
    super.initState();
    initAutoRefresh();
  }

  void reInitAutoRefresh() {
    System.data.autoRefreshTimer.cancel();
    initAutoRefresh();
  }

  void initAutoRefresh() {
    ModeUtil.debugPrint("auto refresh ${System.data.autoRefresh}");
    if (System.data.autoRefresh == true &&
        System.data.autoRefreshDefined == false) {
      ModeUtil.debugPrint("init auto refresh");
      System.data.autoRefreshTimer =
          new Timer.periodic(Duration(seconds: 1), (t) {
        ModeUtil.debugPrint(
            "waiting refresh remain : ${((System.data.autoRefreshInterval.inSeconds * -1) + (t.tick % System.data.autoRefreshInterval.inSeconds))}");
        if (t.tick % System.data.autoRefreshInterval.inSeconds == 0) {
          ModeUtil.debugPrint(
              "run onTickRefresh() at ${DateTime.now().toIso8601String()}");
          globalTickRefresh();
          ModeUtil.debugPrint("global tick refresh finish");
          System.data.runCallback = true;
        }
      });

      System.data.autoRefreshDefined = true;
    } else if (System.data.autoRefresh == false) {
      ModeUtil.debugPrint("cancle auto refresh");
      try {
        System.data.autoRefreshTimer.cancel();
        System.data.autoRefreshDefined = false;
      } catch (e) {}
    }

    autoRefresh = Timer.periodic(Duration(seconds: 1), (t) {
      try {
        if (System.data.runCallback == true) {
          localTickRefresh();
          localTick();
          System.data.runCallback = false;
        } else {
          localTick();
        }
      } catch (e) {}
    });
  }

  @override
  void dispose() {
    autoRefresh?.cancel();
    //SavedDataUtil.data.autoRefreshTimer?.cancel();
    super.dispose();
  }
}
