import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/util/DateTimeExtention.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

import 'presenter.dart';

mixin OutComePresenter on PresenterState {
  void getOutComeSummary() {
    model.loadingController.startLoading();
    var date = DateTime(
      DateTime.now().year,
      model.month,
      1,
    );
    AngkutShipmentModel.getOurcome(
      token: System.data.global.token,
      startDate: date,
      endDate: date.add(Duration(days: date.daysInMounth - 1)),
    ).then((value) {
      model.invoiceModels = value;
      model.commit();
      model.loadingController.stopLoading();
    }).catchError((onError) {
      model.loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: ErrorHandlingUtil.handleApiError(onError),
        ),
      );
    });
  }
}
