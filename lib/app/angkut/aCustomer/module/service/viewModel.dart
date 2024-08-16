import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/InsuranceModel.dart';
import 'package:enerren/model/InsurancePremiModel.dart';
import 'package:enerren/model/insuranceCategoryModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();
  int type = 0; //0 instant courier , 1 schedule
  int typee = 0; //0 for lokasi pick up, 1 for tujuan
  DateTime scheduleDate;
  bool extraPeople = false;
  int extraHelperCount = 0;
  String itemDescription;
  List<Payer> payers = [];
  bool useInsurance = false;
  ScrollController bodyController = new ScrollController();
  List<InsuraceCategoryModel> insurancesCategory = [];
  List<InsuranceModel> insurances = [];
  InsuraceCategoryModel selectedInsuranceCategory;
  InsurancePremiModel selectedInsurance;
  double estimateGoodsPrice;

  void payerDummy() {
    this.payers = [
      new Payer(
        name: "Nandang",
        phone: "0821129292",
      ),
    ];
  }

  void commit() {
    notifyListeners();
  }
}

class Payer {
  String name;
  String phone;
  bool selected;

  Payer({
    this.name,
    this.phone,
    this.selected,
  });
}
