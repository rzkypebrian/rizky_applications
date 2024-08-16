import 'dart:async';
import 'dart:convert';

import 'package:enerren/app/angkut/aTransporter/localData.dart';
import 'package:enerren/app/angkut/module/splashScreen/angkutPresenter.dart';
import 'package:enerren/model/TransporterModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';

mixin TransporterPresenter on AngkutPresenter {
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
            System.data.getLocal<LocalData>().user = TransporterModel.fromJson(
              json.decode(
                System.data.sharedPreferences.getString(PrefsKey.user),
              ),
            );
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
