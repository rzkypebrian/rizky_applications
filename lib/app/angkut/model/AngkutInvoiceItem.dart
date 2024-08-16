import 'package:json_annotation/json_annotation.dart';
part 'AngkutInvoiceItem.g.dart';

@JsonSerializable(explicitToJson: true)
class AngkutInvoiceItem {
  int detailId;
  int paymentId;
  int invoiceId;
  int itemId;
  String itemCode;
  String itemName;
  int qty;
  double pricing;
  double itemDiscountPercentage;
  int itemAmtDiscount;
  double totalPricing;
  String remarks;

  AngkutInvoiceItem({
    this.detailId,
    this.paymentId,
    this.invoiceId,
    this.itemId,
    this.itemCode,
    this.itemName,
    this.qty,
    this.pricing,
    this.itemDiscountPercentage,
    this.itemAmtDiscount,
    this.totalPricing,
    this.remarks,
  });

  factory AngkutInvoiceItem.fromJson(Map<String, dynamic> json) =>
      _$AngkutInvoiceItemFromJson(json);

  Map<String, dynamic> toJson() => _$AngkutInvoiceItemToJson(this);
}
