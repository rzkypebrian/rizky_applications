import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/MaintenanceItemModel.dart';
import 'package:enerren/model/MaintenanceScheduleModel.dart';
import 'package:enerren/model/WorkOrderModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  void commit() => notifyListeners();

  String workOrderNumber = "wo0001";

  CircularProgressIndicatorController controller =
      CircularProgressIndicatorController();

  WorkOrderModel workOrderModel = WorkOrderModel();
  MaintenanceScheduleModel maintenanceScheduleModel; //= MaintenancesModel();
  PersonInChargeModel personInChargeModel; //= PersonInChargeModel();
  VendorModel vendorModel; //= VendorModel();

  InputComponentTextEditingController picController =
      InputComponentTextEditingController();
  InputComponentTextEditingController maintenanceController =
      InputComponentTextEditingController();
  InputComponentTextEditingController noteVendorController =
      InputComponentTextEditingController();
  InputComponentTextEditingController vendorController =
      InputComponentTextEditingController();

  void addMaintenancesModel() {
    if (maintenanceScheduleModel != null && personInChargeModel != null) {
      this.workOrderModel.personInChargeModel = personInChargeModel;
      this.workOrderModel.workOrderId = workOrderNumber;
      if (workOrderModel.listMaintenanceScheduleModel == null)
        this.workOrderModel.listMaintenanceScheduleModel = [];
      this
          .workOrderModel
          .listMaintenanceScheduleModel
          .add(maintenanceScheduleModel);
    }
    commit();
  }

  void removeMaintenance(MaintenanceItemModel mm) {
    this
        .workOrderModel
        .listMaintenanceScheduleModel
        .removeWhere((e) => e.maintenanceId == mm.maintenanceId);
    commit();
  }

  void sendMaintenance({VoidCallback onFinishLoading}) {
    this.workOrderModel.noteForVendor = noteVendorController.text;
    this.workOrderModel.vendorModel = vendorModel;
    controller.stopLoading(
      message: System.data.resource.dataSentSuccessfully,
      messageAlign: Alignment.topCenter,
      onFinishCallback: onFinishLoading,
      messageWidget: DecorationComponent.topMessageDecoration(
        backgroundColor: System.data.colorUtil.greenColor,
        message: System.data.resource.dataSentSuccessfully,
      ),
    );
    commit();
  }

  set setPersonInChargeModel(PersonInChargeModel pcm) {
    this.personInChargeModel = pcm;
    commit();
  }

  set setMaintenancesModel(MaintenanceScheduleModel mm) {
    this.maintenanceScheduleModel = mm;
    commit();
  }

  set setvendorModel(VendorModel vm) {
    this.vendorModel = vm;
    commit();
  }

  void setVPersonInChargeModel(PersonInChargeModel pcm) {
    this.personInChargeModel = pcm;
    commit();
  }

  void setVMaintenancesModel(MaintenanceScheduleModel mm) {
    this.workOrderModel.listMaintenanceScheduleModel.add(mm);
    commit();
  }
}
