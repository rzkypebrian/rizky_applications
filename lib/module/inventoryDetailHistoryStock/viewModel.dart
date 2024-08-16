import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/HistoryStockModel.dart';
import 'package:enerren/model/StockModel.dart';
import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  void commit() => notifyListeners();

  CircularProgressIndicatorController controller =
      CircularProgressIndicatorController();

  HistoryStockModel historyStockModel;
  void vAddStock(HistoryStockModel historyStockModel) {
    this.historyStockModel = historyStockModel;
    commit();
  }

  set addStock(HistoryStockModel historyStockModel) {
    this.historyStockModel = historyStockModel;
    commit();
  }

  StockModel get getStockModel => historyStockModel.stocks.first;
  TmsVehicleModel get getVehicle => historyStockModel.vehicle;
}
