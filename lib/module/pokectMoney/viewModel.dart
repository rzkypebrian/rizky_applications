import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/ClaimModel.dart'; 
import 'package:enerren/model/HistoryStockModel.dart';
import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  void commit() => notifyListeners();

  void claimPoint() {
    int _status = 1;
    if (listInsentif.getTotalProcessClaim >= 100) {
      listInsentif.latestClaimStatus = _status;
      listInsentif.claimModels.add(
        ClaimModel(
          point: listInsentif.getTotalProcessClaim,
          amount: listInsentif.getTotalProcessClaim * listInsentif.multiplePoint,
          dateTime: DateTime.now(),
          status: _status,
        ),
      );
    }

    controller.stopLoading(
        message:
            "${System.data.resource.youHaveSuccessfullySubmittedAPointClaim}");
    commit();
  }

  int groupValue = 0;
  void setChangeValue(int index) {
    this.groupValue = index;
    commit();
  }

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

  HistoryStockModel selectedHistoryStockModel;
  set setHistoryStockModel(HistoryStockModel historyStockModel) {
    this.selectedHistoryStockModel = historyStockModel;
    commit();
  }

  HistoryStockModel get getSelectedHistoryStockModel =>
      selectedHistoryStockModel;

  List<HistoryStockModel> historyStockModel =
      HistoryStockModel.listHistoryStock;

  HistoryStockModel get listBalance =>
      historyStockModel.where((e) => e.pokect == 1).first;

  double get getRemainceBalance => listBalance == null
      ? 0
      : listBalance.stocks.fold(0, (p, e) => p + e.remainingBalance);

  HistoryStockModel get listSeep =>
      historyStockModel.where((e) => e.pokect == 2).first;

  HistoryStockModel get listInsentif =>
      historyStockModel.where((e) => e.pokect == 3).first;

  double get getRemainceSeep => listSeep == null
      ? 0
      : listSeep.stocks.fold(0, (p, e) => p + e.remainingBalance);

  TmsVehicleModel get vehicleBalance =>
      historyStockModel.where((e) => e.pokect == 1).first.vehicle;

  TmsVehicleModel get vehicleSeep =>
      historyStockModel.where((e) => e.pokect == 2).first.vehicle;

}
