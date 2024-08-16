import 'dart:async';
import 'dart:convert';

import 'package:enerren/app/tms/aCustomer/localData.dart';
import 'package:enerren/app/tms/module/splashScreen/tmsPresenter.dart';
import 'package:enerren/model/CustomerModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';

mixin CustomerPresenter on TmsPresenter {
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
