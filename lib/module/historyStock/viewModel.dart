import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/HistoryStockModel.dart';
import 'package:enerren/model/StockModel.dart';
import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  void commit() => notifyListeners();

  CircularProgressIndicatorController controller =
      CircularProgressIndicatorController();

  InputComponentTextEditingController addController =
      InputComponentTextEditingController();
  InputComponentTextEditingController reduceController =
      InputComponentTextEditingController();

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

  set setDetailBalanceModel(StockModel index) {
    // this.selectedDetailBalanceModel = DetailBalanceModel(
    //     currentBalance: detailBalanceModel.currentBalance,
    //     dateTime: detailBalanceModel.dateTime,
    //     vehicleModel: detailBalanceModel.vehicleModel,
    //     pokectMoneyBalanceModels: [
    //       detailBalanceModel.pokectMoneyBalanceModels.first
    //     ]);
    // this.selectedDetailBalanceModel.pokectMoneyBalanceModels.first.stockModel =
    //     index;
    commit();
  }

  set setvDetailBalanceModel(StockModel index) {
    // this.selectedDetailBalanceModel = DetailBalanceModel(
    //     currentBalance: detailBalanceModel.currentBalance,
    //     dateTime: detailBalanceModel.dateTime,
    //     vehicleModel: detailBalanceModel.vehicleModel,
    //     pokectMoneyBalanceModels: [
    //       detailBalanceModel.pokectMoneyBalanceModels.first
    //     ]);
    // this.selectedDetailBalanceModel.pokectMoneyBalanceModels.first.stockModel =
    //     index;
    commit();
  }

  HistoryStockModel selectedHistoryStock;

  set setSelectedHistoryStock(StockModel stockModel) {
    this.selectedHistoryStock = HistoryStockModel(
      dateTime: DateTime.now(),
      pokect: 1,
      vehicle: getVehicle,
      stocks: [],
    );
    this.selectedHistoryStock.stocks.add(stockModel);
  }

  HistoryStockModel get getSelectedHistoryStockModel => selectedHistoryStock;

  HistoryStockModel historyStockModel =
      HistoryStockModel.listHistoryStock.first;

  List<StockModel> get addStockModel =>
      historyStockModel.stocks.where((e) => e.typeProcessIo == 1).toList();
  List<StockModel> get reduceStockModel =>
      historyStockModel.stocks.where((e) => e.typeProcessIo == 2).toList();

  TmsVehicleModel get getVehicle => historyStockModel.vehicle;
}
