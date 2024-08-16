import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/tmsShipmentDestinationModel.dart';
import 'package:flutter/material.dart';
import 'package:enerren/app/tms/model/IncomeAndOutcomeModel.dart';

class ViewModel extends ChangeNotifier {
  void commit() => notifyListeners();

  CircularProgressIndicatorController controller =
      CircularProgressIndicatorController();

  IncomeAndOutcomeModel incomeAndOutcomeModel;
  void setIncomeAndOutcomeModelV(IncomeAndOutcomeModel incomeAndOutcomeModel) {
    this.incomeAndOutcomeModel = incomeAndOutcomeModel;
    commit();
  }

  set setIncomeAndOutcomeModel(IncomeAndOutcomeModel incomeAndOutcomeModel) {
    this.incomeAndOutcomeModel = incomeAndOutcomeModel;
    commit();
  }

  IncomeAndOutcomeModel get getIncomeAndOutcomeModel => incomeAndOutcomeModel;
  TmsShipmentDestinationModel tmsShipmentDestinationModel =
      TmsShipmentDestinationModel(
    transporterName: "Sumber bumi",
    originAddress:
        "Jalan Kemang Raya No 4, RT.11/RW.1, Bangka, Kec. Mampang Prpt., Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12730. Gedung Graha Kapital 1 Lt 1",
    deliveryAddress:
        "Jl. Margonda Raya No.100RT.3/RW.7, Pondok Cina, Kecamatan Beji, Kota Depok, Jawa Barat 16424",
    arrivalETAToDestination: DateTime.now(),
    distanceOriginToDestination: 123.45,

  );
}
