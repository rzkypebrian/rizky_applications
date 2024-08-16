import 'dart:async';
import 'dart:convert';

import 'package:enerren/app/angkut/aDriver/localData.dart';
import 'package:enerren/app/angkut/module/splashScreen/angkutPresenter.dart';
import 'package:enerren/model/DriverModel.dart';
import 'package:enerren/model/serchShipmentNumberHistory.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';

mixin DriverPresenter on AngkutPresenter {
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
            System.data.getLocal<LocalData>().user = DriverModel.fromJson(
              json.decode(
                System.data.sharedPreferences.getString(PrefsKey.user),
              ),
            );
          } catch (e) {
            System.data.getLocal<LocalData>().user = null;
          }
          try {
            System.data.global.historyReceiptSearch = (json.decode(
              System.data.sharedPreferences
                  .getString(PrefsKey.searchResiHistory),
            ) as List)
                .map((f) => SerchShipmentNumberHistory.fromJson(f))
                .toList();
          } catch (e) {
            print("masuk sini $e");
            System.data.global.historyReceiptSearch = [];
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
