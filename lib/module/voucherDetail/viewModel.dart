import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/TmsVoucherModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  TmsVoucherModel voucher = new TmsVoucherModel();
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  ViewModel();
}
