import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/MaintenanceItemModel.dart';
import 'package:enerren/model/WorkOrderModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  void commit() => notifyListeners();

  String workOrderNumber = "wo0001";

  CircularProgressIndicatorController controller =
      CircularProgressIndicatorController();

  WorkOrderModel workOrderModel = WorkOrderModel.dummy.first;
  set setgetWorkOrderModel(WorkOrderModel wo) {
    this.workOrderModel = wo;
    commit();
  }

  List<InstructionModel> get listInstuction => workOrderModel
      .listMaintenanceScheduleModel
      .first
      .maintenanceItemModel
      .instructionModels;

  InstructionModel instructionModel;

  void changeCheck(int index) {
    this.listInstuction[index].status = !listInstuction[index].status;
    commit();
  }

  InputComponentTextEditingController obstaclesController = InputComponentTextEditingController();
}
