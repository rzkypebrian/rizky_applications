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
      typeBill: 'debt',
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
      typeBill: 'credit',
    ),
  ];
  List<String> listBank = [
    'Bank Bca',
    'Bank Bri',
    'Bank Bni',
    'Bank Bjb',
    'Bank Dki',
    'Bank Mandiri'
  ]; 

  AngkutBill angkutBill = AngkutBill();

  String bank;
  void setbank(String bank) {
    this.bank = bank;
    commit();
  }

  void commit() {
    notifyListeners();
  }
}
