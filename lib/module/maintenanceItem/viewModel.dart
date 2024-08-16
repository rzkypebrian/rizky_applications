import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/MaintenanceItemModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  void commit() => notifyListeners();

  CircularProgressIndicatorController controller =
      CircularProgressIndicatorController();

  List<MaintenanceItemModel> maintenancesModel = MaintenanceItemModel.dummy;
}
