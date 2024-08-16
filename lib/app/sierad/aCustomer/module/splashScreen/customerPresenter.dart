import 'dart:async';
import 'dart:convert';

import 'package:enerren/app/sierad/aCustomer/localData.dart';
import 'package:enerren/app/sierad/module/splashScreen/sieradPresenter.dart';
import 'package:enerren/model/CustomerModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';

mixin CustomerPresenter on SieradPresenter {
  @override
  void onStart() {
    loadingController.startLoading(
      coverScreen: false,
    );
    //read driver session data
    try {
      Timer.periodic(Duration(seconds: 1), (t) {
        if (System.data.sharedPreferences != null) {
          t.cancel();
          try {
            System.data.getLocal<LocalData>().user = CustomerModel.fromJson(
                json.decode(
                    System.data.sharedPreferences.getString(PrefsKey.user)));
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
