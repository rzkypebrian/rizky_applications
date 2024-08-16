import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/HistoryStockModel.dart';
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

  List<HistoryStockModel> listDetailSeepModel =
      HistoryStockModel.listHistoryStock.where((e) => e.pokect == 2).toList();
  List<HistoryStockModel> listDetailInsentifModel =
      HistoryStockModel.listHistoryStock.where((e) => e.pokect == 3).toList();

  // List<DetailInsentifModel> listDetailInsentifModel =
  //     DetailInsentifModel.listDetailInsentifModelDummy;

  List<HistoryStockModel> listDetailBalanceModel =
      HistoryStockModel.listHistoryStock.where((e) => e.pokect == 1).toList();
}
