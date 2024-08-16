// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TripAllowanceSummaryModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripAllowanceSummary _$AngkutUangJalanSummaryViewModelFromJson(
    Map<String, dynamic> json) {
  return TripAllowanceSummary(
    summaryId: json['summaryId'] as int,
    tmsShipmentId: json['tmsShipmentId'] as int,
    driverId: json['driverId'] as int,
    driverNik: json['driverNik'] as String,
    driverName: json['driverName'] as String,
    driverImageUrl: json['driverImageUrl'] as String,
    driverBirthDate: json['driverBirthDate'] == null
        ? null
        : DateTime.parse(json['driverBirthDate'] as String),
    driverEmail: json['driverEmail'] as String,
    driverSimType: json['driverSimType'] as String,
    driverScore: (json['driverScore'] as num)?.toDouble(),
    driverAddress: json['driverAddress'] as String,
    driverPhoneNumber: json['driverPhoneNumber'] as String,
    vehicleId: json['vehicleId'] as int,
    vehicleName: json['vehicleName'] as String,
    vehicleNumber: json['vehicleNumber'] as String,
    vehicleIdVts: json['vehicleIdVts'] as int,
    vehicleRegNumber: json['vehicleRegNumber'] as String,
    vehicleRegDate: json['vehicleRegDate'] == null
        ? null
        : DateTime.parse(json['vehicleRegDate'] as String),
    vehicleStatusId: json['vehicleStatusId'] as int,
    vehicleStatusName: json['vehicleStatusName'] as String,
    vehicleTypeId: json['vehicleTypeId'] as int,
    vehicleTypeName: json['vehicleTypeName'] as String,
    transporterCode: json['transporterCode'] as String,
    transporterName: json['transporterName'] as String,
    transactionDate: json['transactionDate'] == null
        ? null
        : DateTime.parse(json['transactionDate'] as String),
    beginningBalance: (json['beginningBalance'] as num)?.toDouble(),
    totalExpense: (json['totalExpense'] as num)?.toDouble(),
    endingBalance: (json['endingBalance'] as num)?.toDouble(),
    status: json['status'] as int,
    remarks: json['remarks'] as String,
    uangJalanDetailExpense: (json['uangJalanDetailExpense'] as List)
        ?.map((e) => e == null
            ? null
            : TripAllowanceSummaryModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AngkutUangJalanSummaryViewModelToJson(
        TripAllowanceSummary instance) =>
    <String, dynamic>{
      'summaryId': instance.summaryId,
      'tmsShipmentId': instance.tmsShipmentId,
      'driverId': instance.driverId,
      'driverNik': instance.driverNik,
      'driverName': instance.driverName,
      'driverImageUrl': instance.driverImageUrl,
      'driverBirthDate': instance.driverBirthDate?.toIso8601String(),
      'driverEmail': instance.driverEmail,
      'driverSimType': instance.driverSimType,
      'driverScore': instance.driverScore,
      'driverAddress': instance.driverAddress,
      'driverPhoneNumber': instance.driverPhoneNumber,
      'vehicleId': instance.vehicleId,
      'vehicleName': instance.vehicleName,
      'vehicleNumber': instance.vehicleNumber,
      'vehicleIdVts': instance.vehicleIdVts,
      'vehicleRegNumber': instance.vehicleRegNumber,
      'vehicleRegDate': instance.vehicleRegDate?.toIso8601String(),
      'vehicleStatusId': instance.vehicleStatusId,
      'vehicleStatusName': instance.vehicleStatusName,
      'vehicleTypeId': instance.vehicleTypeId,
      'vehicleTypeName': instance.vehicleTypeName,
      'transporterCode': instance.transporterCode,
      'transporterName': instance.transporterName,
      'transactionDate': instance.transactionDate?.toIso8601String(),
      'beginningBalance': instance.beginningBalance,
      'totalExpense': instance.totalExpense,
      'endingBalance': instance.endingBalance,
      'status': instance.status,
      'remarks': instance.remarks,
      'uangJalanDetailExpense':
          instance.uangJalanDetailExpense?.map((e) => e?.toJson())?.toList(),
    };
