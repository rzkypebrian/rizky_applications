import 'package:enerren/app/angkut/model/AngkutBill.dart';
import 'package:flutter/cupertino.dart';

class ViewModel extends ChangeNotifier {
  List<AngkutBill> listAngkutBill = [
    AngkutBill(
      billId: 1,
      accounHolderName: 'tranporter1',
      accountNumber: '01234567890',
      bankName: 'bca',
      income: 5000000,
      billNumber: 'no1234567890',
      debtTotal: 5000000,
      datePay: DateTime.now(),
      dateTimeDue: DateTime.now(),
      fee: 0,
      ppn: 0,
      status: true,
      // img: '',
      typeBill: 'credit',
    ),
    AngkutBill(
      billId: 1,
      accounHolderName: 'tranporter2',
      accountNumber: '01234567891',
      bankName: 'bca',
      income: 5000000,
      billNumber: 'no1234567891',
      debtTotal: 5000000,
      datePay: DateTime.now(),
      dateTimeDue: DateTime.now(),
      fee: 0,
      ppn: 0,
      status: false,
      // img: '',
      typeBill: 'debt',
    ),
  ];

  void commit() {
    notifyListeners();
  }
}
