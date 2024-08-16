import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/AttendanceModel.dart';
import 'package:enerren/model/CheckStatus.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  TabController tabController;
  int currentIndexTab = 0;
  CircularProgressIndicatorController loadingController =
      CircularProgressIndicatorController();

  InputComponentTextEditingController searchController =
      InputComponentTextEditingController();

  AttendanceModel selectedAttendance = AttendanceModel();

  List<AttendanceModel> attendances = [];

  CheckStatus selectedStatus = CheckStatus();

  void commit() {
    notifyListeners();
  }

  set setCurrentIndexTab(int index) {
    this.currentIndexTab = index;
    commit();
  }

  void setCurrentofIndexTab(int index) {
    this.currentIndexTab = index;
    commit();
  }

  set selectStatus(CheckStatus i) {
    this.selectedStatus = selectedStatus;
    commit();
  }

  set selectAttendance(AttendanceModel attendanceModel) {
    this.selectedAttendance = selectedAttendance;
    commit();
  }

  List<CheckStatus> listCheckItem = [
    CheckStatus(
      id: 1,
      name: System.data.resource.all,
    ),
    CheckStatus(
      id: 2,
      name: System.data.resource.feasible,
    ),
    CheckStatus(
      id: 3,
      name: System.data.resource.unfeasible,
    ),
  ];

  List<CheckStatus> get allCheckItem => listCheckItem.toList();

  List<AttendanceModel> get listAttendanceModel =>
      attendances.where((p) => p.isPassed == null).toList();
  List<AttendanceModel> get resultAttendanceModel =>
      attendances.where((p) => p.isPassed != null).toList();

  List<AttendanceModel> get listLayakJalan =>
      attendances.where((p) => p.isPassed == true).toList();

  List<AttendanceModel> get listTidakLayakJalan =>
      attendances.where((p) => p.isPassed == false).toList();
}
