import 'package:enerren/model/StockModel.dart';

class SeepModel {
  String prNumber;
  DateTime dateTime;
  double balance;
  int status;
  StockModel stockModel;

  SeepModel({
    this.balance,
    this.dateTime,
    this.prNumber,
    this.status = 1,
    this.stockModel,
  });
}
