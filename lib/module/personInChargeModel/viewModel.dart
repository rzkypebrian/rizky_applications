import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/WorkOrderModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  void commit() => notifyListeners();

  CircularProgressIndicatorController controller =
      CircularProgressIndicatorController();

  PersonInChargeModel personInChargeModel = PersonInChargeModel();

  set setPersonInChargeModel(PersonInChargeModel pm) {
    this.personInChargeModel = pm;
    commit();
  }

  void removePersonInChargeModel() {
    this.personInChargeModel = null;
    controller.stopLoading(
        message: "${System.data.resource.dataDeletedSuccessfully}");
    commit();
  }
}
