import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/imagePickerComponent.dart';
import 'package:enerren/model/HistoryStockModel.dart';
import 'package:enerren/model/StockModel.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  void commit() => notifyListeners();

  CircularProgressIndicatorController controller =
      CircularProgressIndicatorController();

  InputComponentTextEditingController addBalanceController =
      InputComponentTextEditingController();
  InputComponentTextEditingController imageController =
      InputComponentTextEditingController();
  ImagePickerController imagePickerController = ImagePickerController();

  HistoryStockModel historyStock;

  int groupValue = 0;
  void setChangeValue(int index) {
    this.groupValue = index;
    commit();
  }

  set setHistoryStock(HistoryStockModel hsm) {
    this.historyStock = hsm;
    commit();
  }

  void addBalance() {
    StockModel aa = StockModel(
      incomeBalance: double.parse(addBalanceController.text),
      balance: double.parse(addBalanceController.text),
      dateTime: DateTime.now(),
      flowBalance: 2,
      image: imagePickerController.getBase64Compress() ?? "",
    );
    ModeUtil.debugPrint(
        "before ${historyStock.stocks.length} ${imagePickerController.getBase64Compress()}");
    historyStock.stocks.add(aa);
    addBalanceController.text = "";
    imageController.text = "";
    controller.stopLoading(message: "${System.data.resource.finish}");
    ModeUtil.debugPrint("afther ${historyStock.stocks.length}");
    commit();
  }

  void addSeep({
    int index,
  }) {
    historyStock.stocks[index].balance +=
        (historyStock.stocks[index].remainingBalance * -1);
    historyStock.stocks[index].seepStatus = 2;
    historyStock.stocks[index].dateTime = DateTime.now();
    historyStock.stocks[index].image = imagePickerController.getBase64();
    commit();
  }

  void claimPoint() {
    int claimStatus = 2;
    historyStock.latestClaimStatus = claimStatus;
    historyStock.claimModels.forEach((e) {
      e.status = claimStatus;
      e.dateTime = DateTime.now();
      e.amount = e.point * historyStock.multiplePoint;
      e.image = imagePickerController.getBase64();
    });
    ModeUtil.debugPrint("message ${historyStock.claimModels.first.status}");
    commit();
  }
}
