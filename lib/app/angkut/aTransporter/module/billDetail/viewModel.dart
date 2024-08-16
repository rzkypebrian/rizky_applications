import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:flutter/cupertino.dart';

// import 'package:intl/intl.dart';  //for date format
// import 'package:intl/date_symbol_data_local.dart';  //

class ViewModel extends ChangeNotifier {
  var pathFile;
  AngkutShipmentModel invoice;

  List<String> statusPayments = [
    'lunas',
    'belum lunas',
  ];
  List<String> couriers = ['instan', 'Same day', '3 hours'];

  String statusPayment;
  void setStatusPayment(String payment) {
    this.statusPayment = payment;
    commit();
  }

  String courier;
  void setCourier(String courier) {
    this.courier = courier;
    commit();
  }

  double totalYouget = 970000;
  void commit() {
    notifyListeners();
  }
}
