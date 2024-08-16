import 'package:enerren/app/angkut/aDriver/module/doPhoto/main.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

import '../../localData.dart';

mixin DoPhotoFinish on PresenterState {
  int idDestination;
  ValueChanged<AngkutShipmentModel> onTapNext;
  AngkutShipmentModel shipment;

  @override
  void initState() {
    super.initState();
    model.angkutShipmentModel = shipment;
    model.loadingController.stopLoading();
    model.commit();
  }

  void submitDoPhotoFinish() {
    
    model.loadingController.startLoading();
    AngkutShipmentModel.finishDetailDestinationOrder(
      token: System.data.global.token,
      driverId: System.data.getLocal<LocalData>().user.driverId,
      tmsshipmentId: model.angkutShipmentModel.tmsShipmentId,
      detailShipmentId: model.angkutShipmentModel
          .tmsShipmentDestinationList[idDestination].detailshipmentId,
    ).then((onValue) {
      ModeUtil.debugPrint(onValue);
      onTapNext(onValue);
    }).whenComplete(() {
      model.loadingController.stopLoading();
      model.commit();
    }).catchError((onError) {
      model.loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError)),
      );
      model.commit();
    });
  }
}
