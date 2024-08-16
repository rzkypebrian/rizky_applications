class AngkutBill {
  int billId;
  double debtAmount;
  String billNumber;
  double income;
  double fee;
  double ppn;
  double debtTotal;
  DateTime dateTimeDue;
  DateTime datePay;
  bool status;
  String bankName;
  String accountNumber;
  String accounHolderName;
  List<String> img;
  String typeBill;

  AngkutBill({
    this.debtAmount = 0,
    this.typeBill: "debt",
    this.billId,
    this.billNumber,
    this.income,
    this.fee = 0,
    this.ppn = 0,
    this.debtTotal = 0,
    this.dateTimeDue,
    this.datePay,
    this.status = false,
    this.bankName,
    this.accountNumber,
    this.accounHolderName,
    this.img,
  });
}
