// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AngkutInvoiceModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AngkutInvoiceModel _$AngkutInvoiceModelFromJson(Map<String, dynamic> json) {
  return AngkutInvoiceModel(
    invoiceId: json['invoiceId'] as int,
    invoiceGuid: json['invoiceGuid'] as String,
    tmsShipmentId: json['tmsShipmentId'] as int,
    invoiceDate: json['invoiceDate'] == null
        ? null
        : DateTime.parse(json['invoiceDate'] as String),
    dueDate: json['dueDate'] == null
        ? null
        : DateTime.parse(json['dueDate'] as String),
    subtotalInvoice: (json['subtotalInvoice'] as num)?.toDouble(),
    ppn: (json['ppn'] as num)?.toDouble(),
    discountPercentage: (json['discountPercentage'] as num)?.toDouble(),
    amtDiscount: (json['amtDiscount'] as num)?.toDouble(),
    totalOthers: (json['totalOthers'] as num)?.toDouble(),
    totalInvoice: (json['totalInvoice'] as num)?.toDouble(),
    bankCode: json["bankCode"] as String,
    bankName: json["bankName"] as String,
    bankIconUrl: json["bankIconUrl"] as String,
    methodId: json["methodId"] as int,
    methodDetailId: json["methodDetailId"] as int,
    methodDetailCode: json["methodDetailCode"] as String,
    methodDetailName: json["methodDetailName"] as String,
    methodDetailIpay88Id: json["methodDetailIpay88Id"] as int,
    methodCode: json["methodCode"] as String,
    methodName: json["methodName"] as String,
    paidStatus: json['paidStatus'] as int,
    paidStatusName: json['paidStatusName'] as String,
    paidAmount: (json['paidAmount'] as num)?.toDouble(),
    isInstallment: json['isInstallment'] as bool,
    tenor: json['tenor'] as int,
    remarks: json['remarks'] as String,
    shipmentInvoiceItem: (json['shipmentInvoiceItem'] as List)
        ?.map((e) => e == null
            ? null
            : AngkutInvoiceItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    billPayStatus: json['billPayStatus'] as int,
  );
}

Map<String, dynamic> _$AngkutInvoiceModelToJson(AngkutInvoiceModel instance) =>
    <String, dynamic>{
      'invoiceId': instance.invoiceId,
      'invoiceGuid': instance.invoiceGuid,
      'tmsShipmentId': instance.tmsShipmentId,
      'invoiceDate': instance.invoiceDate?.toIso8601String(),
      'dueDate': instance.dueDate?.toIso8601String(),
      'subtotalInvoice': instance.subtotalInvoice,
      'ppn': instance.ppn,
      'discountPercentage': instance.discountPercentage,
      'amtDiscount': instance.amtDiscount,
      'totalOthers': instance.totalOthers,
      'totalInvoice': instance.totalInvoice,
      'bankCode': instance.bankCode,
      'bankName': instance.bankName,
      'bankIconUrl': instance.bankIconUrl,
      'methodId': instance.methodId,
      'methodDetailId': instance.methodDetailId,
      'methodDetailCode': instance.methodDetailCode,
      'methodDetailName': instance.methodDetailName,
      'methodDetailIpay88Id': instance.methodDetailIpay88Id,
      'methodCode': instance.methodCode,
      'methodName': instance.methodName,
      'paidStatus': instance.paidStatus,
      'paidStatusName': instance.paidStatusName,
      'paidAmount': instance.paidAmount,
      'isInstallment': instance.isInstallment,
      'tenor': instance.tenor,
      'remarks': instance.remarks,
      'shipmentInvoiceItem':
          instance.shipmentInvoiceItem?.map((e) => e?.toJson())?.toList(),
    };
