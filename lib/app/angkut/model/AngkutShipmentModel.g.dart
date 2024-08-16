// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AngkutShipmentModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
AngkutShipmentModel _$AngkutShipmentModelFromJson(Map<String, dynamic> json) {
  return AngkutShipmentModel(
    mileage: json['mileage'] as double,
    tmsShipmentId: json['tmsShipmentId'] as int,
    shipmentNumber: json['shipmentNumber'] as String,
    shipmentDate: json['shipmentDate'] == null
        ? null
        : DateTime.parse(json['shipmentDate'] as String),
    needAcction: json['needAcction'] as bool,
    payed: json['payed'] as bool,
    deadlineCancelledDatetime: json['deadlineCancelledDatetime'] == null
        ? null
        : DateTime.parse(json['deadlineCancelledDatetime'] as String),
    distanceToPickUp: (json['distanceToPickup'] as num)?.toDouble(),
    arrivalEtaToPickUp: json['arrivalETAToPickup'] == null
        ? null
        : DateTime.parse(json['arrivalETAToPickup'] as String),
    distancePickupToDestination:
        (json['distancePickupToDestination'] as num)?.toDouble(),
    vtsShipmentId: json['vtsShipmentId'] as int,
    vehicleTypeId: json['vehicleTypeId'] as int,
    vehicleTypeName: json['vehicleTypeName'] as String,
    customerId: json['customerId'] as int,
    customerName: json['customerName'] as String,
    customerImageUrl: json['customerImageUrl'] as String,
    beginDatetime: json['beginDatetime'] == null
        ? null
        : DateTime.parse(json['beginDatetime'] as String),
    completeDatetime: json['completeDatetime'] == null
        ? null
        : DateTime.parse(json['completeDatetime'] as String),
    shipmentStatusId: json['shipmentStatusId'] as int,
    shipmentStatusName: json['shipmentStatusName'] as String,
    deliveryDescription: json['deliveryDescription'] as String,
    isDeleted: json['isDeleted'] as bool,
    iconUrl: json['iconUrl'] as String,
    shipmentTypeId: json['shipmentTypeId'] as int,
    scheduledDate: json['scheduledDate'] == null
        ? null
        : DateTime.parse(json['scheduledDate'] as String),
    isInstant: json['isInstant'] as bool,
    extraHelper: json['extraHelper'] as bool,
    extraHelperCount: json['extraHelperCount'] as int,
    extraHelperAmount: json['extraHelperAmount']?.toDouble(),
    deliveryNo: json['deliveryNo'] as String,
    basicPrice: (json['basicPrice'] as num)?.toDouble(),
    basicPriceAfterDiscount:
        (json['basicPriceAfterDiscount'] as num)?.toDouble(),
    subtotal: (json['subtotal'] as num)?.toDouble(),
    discountId: json['discountId'] as int,
    discountCode: json['discountCode'] as String,
    discountPersentage: (json['discountPersentage'] as num)?.toDouble(),
    discountAmount: (json['discountAmount'] as num)?.toDouble(),
    totalPrice: (json['totalPrice'] as num)?.toDouble(),
    feeService: (json['feeService'] as num)?.toDouble(),
    insuranceId: json['insuranceId'] as int,
    insuranceName: json['insuranceName'] as String,
    insuranceTypeId: json['insuranceTypeId'] as int,
    insuranceTypeName: json['insuranceTypeName'] as String,
    premiId: json['premiId'] as int,
    premiName: json['premiName'] as String,
    insuranceCode: json['insuranceCode'] as String,
    insuranceFormulaId: json['insuranceFormulaId'] as int,
    insuranceFormula: json['insuranceFormula'] as String,
    insuranceAmount: (json['insuranceAmount'] as num)?.toDouble(),
    payerPhoneNo: json["payerPhoneNo"] as String,
    payerName: json["payerName"] as String,
    isConfirmWaiting: json['isConfirmWaiting'] as bool,
    takeHomePayTransporter: (json['takeHomePayTransporter'] as num)?.toDouble(),
    estimateGoodsPrice: (json['estimateGoodsPrice'] as num)?.toDouble(),
    takeHomePayAngkut: (json['takeHomePayAngkut'] as num)?.toDouble(),
    totalShipCost: (json['totalShipCost'] as num)?.toDouble(),
    voucherId: json["voucherId"] as int,
    voucherCode: json["voucherCode"] as String,
    voucherPersentage: (json["voucherPersentage"] as num)?.toDouble(),
    voucherAmount: (json["voucherAmount"] as num)?.toDouble(),
    voucherErrorString: json["voucherErrorString"] as String,
    driverRating: json["driverRating"] == null
        ? null
        : DriverRatingModel.fromJson(json["driverRating"]),
    shipmentInvoice: json['shipmentInvoice'] == null
        ? null
        : AngkutInvoiceModel.fromJson(
            json['shipmentInvoice'] as Map<String, dynamic>),
    shipmentInvoiceItem: (json['shipmentInvoiceItem'] as List)
        ?.map((e) => e == null
            ? null
            : AngkutInvoiceItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    tmsShipmentDestinationList: (json['tmsShipmentDestinationList'] as List)
        ?.map((e) => e == null
            ? null
            : TmsShipmentDestinationModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    shipmentItemTypeList: (json['shipmentItemTypeList'] as List)
        ?.map((e) => e == null
            ? null
            : TripAllowanceModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    tmsShipmentHistoryList: (json['tmsShipmentHistoryList'] as List)
        ?.map((e) => e == null
            ? null
            : TmsShipmentHistory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AngkutShipmentModelToJson(
        AngkutShipmentModel instance) =>
    <String, dynamic>{
      'mileage': instance.mileage,
      'payed': instance.payed,
      'needAcction': instance.needAcction,
      'deadlineCancelledDatetime':
          instance.deadlineCancelledDatetime?.toIso8601String(),
      'distanceToPickUp': instance.distanceToPickUp,
      'arrivalETAToPickup': instance.arrivalEtaToPickUp?.toIso8601String(),
      'distancePickupToDestination': instance.distancePickupToDestination,
      'tmsShipmentId': instance.tmsShipmentId,
      'shipmentNumber': instance.shipmentNumber,
      'shipmentDate': instance.shipmentDate?.toIso8601String(),
      'vtsShipmentId': instance.vtsShipmentId,
      'vehicleTypeId': instance.vehicleTypeId,
      'vehicleTypeName': instance.vehicleTypeName,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerImageUrl': instance.customerImageUrl,
      'beginDatetime': instance.beginDatetime?.toIso8601String(),
      'completeDatetime': instance.completeDatetime?.toIso8601String(),
      'shipmentStatusId': instance.shipmentStatusId,
      'shipmentStatusName': instance.shipmentStatusName,
      'deliveryDescription': instance.deliveryDescription,
      'isDeleted': instance.isDeleted,
      'iconUrl': instance.iconUrl,
      'shipmentTypeId': instance.shipmentTypeId,
      'scheduledDate': instance.scheduledDate?.toIso8601String(),
      'isInstant': instance.isInstant,
      'extraHelper': instance.extraHelper,
      'extraHelperCount': instance.extraHelperCount,
      'extraHelperAmount': instance.extraHelperAmount,
      'deliveryNo': instance.deliveryNo,
      'basicPrice': instance.basicPrice,
      'basicPriceAfterDiscount': instance.basicPriceAfterDiscount,
      'subtotal': instance.subtotal,
      'discountId': instance.discountId,
      'discountCode': instance.discountCode,
      'discountPersentage': instance.discountPersentage,
      'discountAmount': instance.discountAmount,
      'totalPrice': instance.totalPrice,
      'feeService': instance.feeService,
      'insuranceId': instance.insuranceId,
      'insuranceName': instance.insuranceName,
      'insuranceTypeId': instance.insuranceTypeId,
      'insuranceTypeName': instance.insuranceTypeName,
      'premiId': instance.premiId,
      'premiName': instance.premiName,
      'insuranceCode': instance.insuranceCode,
      'insuranceFormulaId': instance.insuranceFormulaId,
      'insuranceFormula': instance.insuranceFormula,
      'insuranceAmount': instance.insuranceAmount,
      'shipmentInvoice': instance.shipmentInvoice?.toJson(),
      'payerPhoneNo': instance.payerPhoneNo,
      'payerName': instance.payerName,
      'isConfirmWaiting': instance.isConfirmWaiting,
      'estimateGoodsPrice': instance.estimateGoodsPrice,
      'totalShipCost': instance.totalShipCost,
      "voucherCode": instance.voucherCode,
      "voucherId": instance.voucherId,
      "voucherPersentage": instance.voucherPersentage,
      "voucherAmount": instance.voucherAmount,
      "voucherErrorString": instance.voucherErrorString,
      'shipmentInvoiceItem':
          instance.shipmentInvoiceItem?.map((e) => e?.toJson())?.toList(),
      'tmsShipmentDestinationList': instance.tmsShipmentDestinationList
          ?.map((e) => e?.toJson())
          ?.toList(),
      'shipmentItemTypeList':
          instance.shipmentItemTypeList?.map((e) => e?.toJson())?.toList(),
      'tmsShipmentHistoryList':
          instance.tmsShipmentHistoryList?.map((e) => e?.toJson())?.toList(),
      'driverRating': instance.driverRating?.toJson(),
    };
