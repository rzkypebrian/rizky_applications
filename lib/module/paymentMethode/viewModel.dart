import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/PaymentMethodeDetailModel.dart';
import 'package:enerren/model/PaymentMethodeModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  List<PaymentMethodeModel> paymentMethods = [];
  PaymentMethodeModel selectedPaymentMethods;
  PaymentMethodeDetailModel selectedMethodDetail;
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  void commit() {
    notifyListeners();
  }
}
