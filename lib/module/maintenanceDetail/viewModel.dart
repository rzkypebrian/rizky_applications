import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/MaintenanceItemModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  void commit() => notifyListeners();

  CircularProgressIndicatorController controller =
      CircularProgressIndicatorController();

  MaintenanceItemModel maintenancesModel = MaintenanceItemModel();

  set setMaintenancesModel(MaintenanceItemModel mm) {
    this.maintenancesModel = mm;
    commit();
  }

  void removeMaintenanceItemModel(){
    this.maintenancesModel = null;
    this.controller.stopLoading(message: "${System.data.resource.dataDeletedSuccessfully}");
    commit();
  }
}
