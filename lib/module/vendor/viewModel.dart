import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/WorkOrderModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  void commit() => notifyListeners();

  CircularProgressIndicatorController controller =
      CircularProgressIndicatorController();

  List<VendorModel> personInChargeModel = VendorModel.dummy;
}
