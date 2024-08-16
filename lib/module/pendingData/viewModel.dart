import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/listDataComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/PendingDataModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  Map<int, CircularProgressIndicatorController> loadingController = {};
  ListDataComponentController<PendingDataModel> pendingDataModelController =
      new ListDataComponentController<PendingDataModel>();
  Map<int, String> messageStatus = {};

  void commit() {
    notifyListeners();
  }

  void getNewPendingData(PendingDataModel data, ScrollController ctrl) {
    pendingDataModelController.value.loadingController.startLoading();
    PendingDataModel.get(
      System.data.database,
      skip: 0,
      take: 5,
    ).then((value) {
      pendingDataModelController.value.data = [];
      pendingDataModelController.value.data = value ?? [];
      pendingDataModelController.value.loadingController.stopLoading();
      createItemController();
      pendingDataModelController.commit();
    }).catchError((onError) {
      pendingDataModelController.value.loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: onError.toString(),
        ),
      );
    });
  }

  void getOldPendingData(PendingDataModel data, ScrollController ctrl) {
    pendingDataModelController.value.loadingController.startLoading();
    PendingDataModel.get(
      System.data.database,
      skip: pendingDataModelController.value.data.length,
      take: 5,
    ).then((value) {
      pendingDataModelController.value.data.addAll(value);
      pendingDataModelController.value.loadingController.stopLoading();
      createItemController();
      pendingDataModelController.commit();
    }).catchError((onError) {
      pendingDataModelController.value.loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: onError.toString(),
        ),
      );
    });
  }

  void createItemController() {
    loadingController = {};
    pendingDataModelController.value.data.forEach((element) {
      loadingController[element.id] = new CircularProgressIndicatorController();
      loadingController[element.id].stopLoading();
      messageStatus[element.id] = element.status == PendingDataStatus.sent
          ? "${System.data.resource.sent}"
          : "";
    });
    commit();
  }

  void getNewPendingDataFromFile(PendingDataModel data, ScrollController ctrl) {
    pendingDataModelController.value.loadingController.startLoading();
    PendingDataModel.getFromFile(
            // dataType: PendingDataType.podData,
            )
        .then((value) {
      pendingDataModelController.value.data = [];
      pendingDataModelController.value.data = value ?? [];
      pendingDataModelController.value.loadingController.stopLoading();
      createItemController();
      pendingDataModelController.commit();
    }).catchError((onError) {
      pendingDataModelController.value.loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: onError.toString(),
        ),
      );
    });
  }
}
