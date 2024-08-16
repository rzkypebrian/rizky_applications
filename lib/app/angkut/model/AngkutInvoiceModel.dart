import 'package:enerren/app/angkut/model/AngkutInvoiceItem.dart';
import 'package:json_annotation/json_annotation.dart';
part 'AngkutInvoiceModel.g.dart';

@JsonSerializable(explicitToJson: true)
class AngkutInvoiceModel {
  int invoiceId;
  String invoiceGuid;
  int tmsShipmentId;
  DateTime invoiceDate;
  DateTime dueDate;
  double subtotalInvoice;
  double ppn;
  double discountPercentage;
  double amtDiscount;
  double totalOthers;
  double totalInvoice;
  String bankCode;
  String bankName;
  String bankIconUrl;
  int methodId;
  String methodCode;
  String methodName;
  int methodDetailId;
  String methodDetailCode;
  String methodDetailName;
  int methodDetailIpay88Id;
  int paidStatus;
  String paidStatusName;
  double paidAmount;
  bool isInstallment;
  int tenor;
  String remarks;
  int billPayStatus;
  List<AngkutInvoiceItem> shipmentInvoiceItem;

  AngkutInvoiceModel({
    this.invoiceId,
    this.invoiceGuid,
    this.tmsShipmentId,
    this.invoiceDate,
    this.dueDate,
    this.subtotalInvoice,
    this.ppn,
    this.discountPercentage,
    this.amtDiscount,
    this.totalOthers,
    this.totalInvoice,
    this.bankCode,
    this.bankName,
    this.bankIconUrl,
    this.methodId,
    this.methodCode,
    this.methodName,
    this.paidStatus,
    this.paidStatusName,
    this.paidAmount,
    this.isInstallment,
    this.tenor,
    this.remarks,
    this.methodDetailId,
    this.methodDetailCode,
    this.methodDetailName,
    this.methodDetailIpay88Id,
    this.shipmentInvoiceItem,
    this.billPayStatus,
  });

  factory AngkutInvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$AngkutInvoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AngkutInvoiceModelToJson(this);
}
