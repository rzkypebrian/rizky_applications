import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:enerren/util/DateTimeExtention.dart';

// import 'package:intl/intl.dart';  //for date format
// import 'package:intl/date_symbol_data_local.dart';  //

class ViewModel extends ChangeNotifier {
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  List<AngkutShipmentModel> invoiceModels = [];

  int month;
  int year;
  DateTime firstDate;
  DateTime lastDate;

  void setMonth(int month) {
    this.month = month;
    calcDate();
    commit();
  }

  void setYear(int year) {
    this.year = year;
    calcDate();
    commit();
  }

  void calcDate() {
    firstDate = DateTime(
      year,
      month,
      1,
    );
    lastDate = firstDate.add(Duration(days: firstDate.daysInMounth - 1));
  }

  double get sumTakeHoePayTransporter {
    double total = 0;
    invoiceModels
        .where((a) => a.shipmentInvoice.billPayStatus != 2)
        .toList()
        .forEach((e) {
      total = total + (e.takeHomePayTransporter ?? 0);
    });

    return total;
  }

  double get sumTakeHoePayAngkut {
    double total = 0;
    invoiceModels
        .where((a) => a.shipmentInvoice.billPayStatus != 2)
        .toList()
        .forEach((e) {
      total = total + (e.takeHomePayAngkut ?? 0);
    });

    return total;
  }

  void commit() {
    notifyListeners();
  }
}
