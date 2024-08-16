import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:enerren/util/StringExtention.dart';

// import 'package:intl/intl.dart';  //for date format
// import 'package:intl/date_symbol_data_local.dart';  //

class ViewModel extends ChangeNotifier {
  List<AngkutShipmentModel> invoices = [];
  List<AngkutShipmentModel> filteredInvoice = [];
  InputComponentTextEditingController searchController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController dateController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController courierController =
      new InputComponentTextEditingController();
  DateTime selectedDate;

  int statusPayment;
  bool courier;

  Map<int, String> statusPayments = Map.fromEntries([
    MapEntry(null, ""),
    MapEntry(0, System.data.resource.notPayed),
    MapEntry(1, System.data.resource.payed),
    MapEntry(3, System.data.resource.pending),
  ]);

  Map<bool, String> couriers = Map.fromEntries([
    MapEntry(null, ""),
    MapEntry(true, System.data.resource.instant),
    MapEntry(false, System.data.resource.scheduled),
  ]);

  void filter() {
    filteredInvoice = invoices;

    if (selectedDate != null) {
      filteredInvoice = filteredInvoice
          .where((e) =>
              DateFormat("dd-mm-yyyy").format(e.shipmentDate) ==
              DateFormat("dd-mm-yyyy").format(selectedDate))
          .toList();
    }

    if (statusPayment != null) {
      filteredInvoice = filteredInvoice
          .where((e) => (e.shipmentInvoice.billPayStatus ?? 0) == statusPayment)
          .toList();
    }

    if (courier != null) {
      filteredInvoice =
          filteredInvoice.where((e) => e.isInstant == courier).toList();
    }

    if (searchController.text.isNullOrEmpty() == false) {
      filteredInvoice = filteredInvoice
          .where((e) =>
              e.shipmentNumber
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()) ||
              e.tmsShipmentDestinationList.first.driverName
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()))
          .toList();
    }

    commit();
  }

  void setStatusPayment(int payment) {
    this.statusPayment = payment;
    filter();
  }

  void setCourier(bool courier) {
    this.courier = courier;
    filter();
  }

  void commit() {
    notifyListeners();
  }
}
