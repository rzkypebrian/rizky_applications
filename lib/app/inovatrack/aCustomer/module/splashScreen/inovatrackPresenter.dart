import 'dart:async';
import 'dart:convert';

import 'package:enerren/app/inovatrack/aCustomer/localData.dart';
import 'package:enerren/app/inovatrack/model/userModel.dart';
import 'package:enerren/module/splashScreen/presenter.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';

mixin InovatrackPresenter on PresenterState {
  void onStart() {
    loadingController.startLoading(
      coverScreen: false,
    );
    try {
      Timer.periodic(Duration(seconds: 1), (t) {
        if (System.data.sharedPreferences != null) {
          t.cancel();
          try {
            //ambil data user
            System.data.getLocal<LocalData>().user = UserModel.fromJson(
                json.decode(
                    System.data.sharedPreferences.getString(PrefsKey.user)));
            //ambil data pin
            System.data.global.pin =
                System.data.sharedPreferences.getInt(PrefsKey.pin);
            //ambil data token
            System.data.global.token =
                System.data.sharedPreferences.get(PrefsKey.token);
          } catch (e) {
            System.data.getLocal<LocalData>().user = null;
          }
          super.onFinish();
        }
      });
    } catch (e) {
      print("masuk sini $e");
      super.onFinish();
    }
  }
}
