import 'package:enerren/model/StockModel.dart';

class BalanceModel {
  String prNumber;
  DateTime dateTime;
  int typeProcess;
  double balance;
  String imagePath;
  StockModel stockModel;

  BalanceModel({
    this.prNumber,
    this.dateTime,
    this.typeProcess,
    this.balance,
    this.imagePath,
    this.stockModel,
  });
}