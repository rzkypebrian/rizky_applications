import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/WorkOrderModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  void commit() => notifyListeners();

  String workOrderNumber = "wo0001";

  CircularProgressIndicatorController controller =
      CircularProgressIndicatorController();
  TabController tabController;
  int indexTab = 0;
  void changeIndexTab(int i) {
    this.indexTab = i;
    commit();
  }

  List<WorkOrderModel> workOrderModel = WorkOrderModel.dummy;
  List<WorkOrderModel> get newWo =>
      workOrderModel.where((e) => e.typeWorkOrder == 1).toList();
  List<WorkOrderModel> get processWo =>
      workOrderModel.where((e) => e.typeWorkOrder == 2).toList();
  List<WorkOrderModel> get finishWo =>
      workOrderModel.where((e) => e.typeWorkOrder == 3).toList();
  List<WorkOrderModel> get postponeWo =>
      workOrderModel.where((e) => e.typeWorkOrder == 4).toList();
}
