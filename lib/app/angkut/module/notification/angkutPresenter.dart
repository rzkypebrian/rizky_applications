import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/model/tmsNotificationModel.dart';
import 'package:enerren/module/notification/presenter.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/cupertino.dart';

mixin AngkutPresenter on PresenerState {
  ValueChanged<AngkutShipmentModel> onTapNotif;

  @override
  void onTapNotification(TmsNotificationModel notif) {
    AngkutShipmentModel.getAll(
      shipmentId: notif.shipmentId,
      limit: 1,
      token: System.data.global.token,
    ).then((onValue) {
      ModeUtil.debugPrint(onValue.first);
      onTapNotif(onValue?.first);
    }).catchError((onError) {
      //
    });
  }
}
