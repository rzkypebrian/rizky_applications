import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/MaintenanceScheduleModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  void commit() => notifyListeners();

  CircularProgressIndicatorController controller =
      CircularProgressIndicatorController();

  TabController tabController;
  int currentIndexTab = 0;

  set setCurrentIndexTab(int index) {
    this.currentIndexTab = index;
    commit();
  }

  void setVCurrentIndexTab(int index) {
    this.currentIndexTab = index;
    commit();
  }

  set setListMaintenance(List<MaintenanceScheduleModel> listMaintenance) {
    this.listMaintenance = listMaintenance;
    commit();
  }

  set addListMaintenance(MaintenanceScheduleModel addlistMaintenance) {
    this.listMaintenance.add(addlistMaintenance);
    commit();
  }

  List<MaintenanceScheduleModel> listMaintenance =
      MaintenanceScheduleModel.dummy;

  // List<MaintenanceScheduleModel> listMaintenance = [
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 1,
  //     maintenanceId: "Id_000001",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_maps.svg",
  //     total: 10,
  //     typeMissing: 1,
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 1,
  //     maintenanceId: "Id_000002",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_times.svg",
  //     total: 10,
  //     typeMissing: 2,
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 1,
  //     maintenanceId: "Id_000003",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_maps.svg",
  //     total: 10,
  //     typeMissing: 1,
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 1,
  //     maintenanceId: "Id_000004",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_times.svg",
  //     total: 10,
  //     typeMissing: 2,
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 2,
  //     maintenanceId: "Id_000001",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_maps.svg",
  //     total: 10,
  //     typeMissing: 1,
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 2,
  //     maintenanceId: "Id_000002",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_maps.svg",
  //     total: 10,
  //     typeMissing: 1,
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 2,
  //     maintenanceId: "Id_000003",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_times.svg",
  //     total: 10,
  //     typeMissing: 2,
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 2,
  //     maintenanceId: "Id_000004",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_maps.svg",
  //     total: 10,
  //     typeMissing: 1,
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 3,
  //     maintenanceId: "Id_000001",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_check.svg",
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 3,
  //     maintenanceId: "Id_000002",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_check.svg",
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 3,
  //     maintenanceId: "Id_000003",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_check.svg",
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 3,
  //     maintenanceId: "Id_000004",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_check.svg",
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 1,
  //     maintenanceId: "Id_000001",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_maps.svg",
  //     total: 10,
  //     typeMissing: 1,
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 1,
  //     maintenanceId: "Id_000002",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_times.svg",
  //     total: 10,
  //     typeMissing: 2,
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 1,
  //     maintenanceId: "Id_000003",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_maps.svg",
  //     total: 10,
  //     typeMissing: 1,
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 1,
  //     maintenanceId: "Id_000004",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_times.svg",
  //     total: 10,
  //     typeMissing: 2,
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 2,
  //     maintenanceId: "Id_000001",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_maps.svg",
  //     total: 10,
  //     typeMissing: 1,
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 2,
  //     maintenanceId: "Id_000002",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_maps.svg",
  //     total: 10,
  //     typeMissing: 1,
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 2,
  //     maintenanceId: "Id_000003",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_times.svg",
  //     total: 10,
  //     typeMissing: 2,
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 2,
  //     maintenanceId: "Id_000004",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_maps.svg",
  //     total: 10,
  //     typeMissing: 1,
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 3,
  //     maintenanceId: "Id_000001",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_check.svg",
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 3,
  //     maintenanceId: "Id_000002",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_check.svg",
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 3,
  //     maintenanceId: "Id_000003",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_check.svg",
  //   ),
  //   MaintenanceScheduleModel(
  //     typeMaintenance: 3,
  //     maintenanceId: "Id_000004",
  //     dateTime: DateTime.now(),
  //     desc: "oli",
  //     pathIcon: "assets/tms/icon_check.svg",
  //   ),
  // ];

  List<MaintenanceScheduleModel> get getWillDue =>
      listMaintenance.where((e) => e.typeMaintenance == 1).toList();
  List<MaintenanceScheduleModel> get getDue =>
      listMaintenance.where((e) => e.typeMaintenance == 2).toList();
  List<MaintenanceScheduleModel> get getAlreadyFinish =>
      listMaintenance.where((e) => e.typeMaintenance == 3).toList();
}
