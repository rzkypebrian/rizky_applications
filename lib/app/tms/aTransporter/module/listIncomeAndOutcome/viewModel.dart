import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:flutter/material.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/model/DropDowns.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/app/tms/model/IncomeAndOutcomeModel.dart';

class ViewModel extends ChangeNotifier {
  void commit() => notifyListeners();

  CircularProgressIndicatorController controller =
      CircularProgressIndicatorController();

  InputComponentTextEditingController inputController =
      InputComponentTextEditingController();
  InputComponentTextEditingController fromController =
      InputComponentTextEditingController();
  InputComponentTextEditingController toController =
      InputComponentTextEditingController();

  bool overlay = false;
  set setOverLay(bool overlay) {
    this.overlay = overlay;
    commit();
  }

  void setOverLayV() {
    this.overlay = !overlay;
    commit();
  }

  bool get getOverLay => this.overlay;

  DropDowns selectedCourier;
  List<DropDowns> listCourier = [
    DropDowns(id: 1, name: System.data.resource.instantCourier),
    DropDowns(id: 2, name: System.data.resource.instant),
  ];

  void changeDropDown(DropDowns dropDowns) {
    this.selectedCourier = dropDowns;
    commit();
  }

  DropDowns selectedStatus;
  List<DropDowns> listStatus = [
    DropDowns(id: 1, name: System.data.resource.paidOff),
    DropDowns(id: 2, name: System.data.resource.notYetPaidOff),
  ];

  void changeDropDownStatus(DropDowns dropDowns) {
    this.selectedStatus = dropDowns;
    commit();
  }

  List<IncomeAndOutcomeModel> listOrderIncome = IncomeAndOutcomeModel
      .listOrderModelDummy
      .where((e) => e.typeProcess == 1)
      .toList();
  List<IncomeAndOutcomeModel> listOrderOutcome = IncomeAndOutcomeModel
      .listOrderModelDummy
      .where((e) => e.typeProcess == 2)
      .toList();
}
