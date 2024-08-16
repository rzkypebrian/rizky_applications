
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  List<ReceiptId> receiptIdNumber= [];

  void receiptIdDummy(){
    this.receiptIdNumber =[
      new ReceiptId(
        receiptIdNum: "AGT123456XXX",
      ),
      new ReceiptId(
        receiptIdNum: "AGT456789XXX",
      ),
    ];
  }

}

class ReceiptId {
  String receiptIdNum;

  ReceiptId({
    this.receiptIdNum,
  });

}

