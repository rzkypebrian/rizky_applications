// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmsVehicleCheckDocument.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmsVehicleCheckDocument _$TmsVehicleCheckDocumentFromJson(
    Map<String, dynamic> json) {
  return TmsVehicleCheckDocument(
    checkFileGuid: json['checkFileGuid'] as String,
    shipmentRef: json['shipmentRef'] as int,
    driverId: json['driverId'] as int,
    driverName: json["driverName"] as String,
    driverRegNumber: json["driverRegNumber"] as String,
    driverImageUrl: json["driverImageUrl"] as String,
    driverSimType: json["driverSimType"] as String,
    driverRating: json["driverRating"] as double,
    vehicleId: json['vehicleId'] as int,
    vehicleName: json["vehicleName"] as String,
    vehicleNumber: json["vehicleNumber"] as String,
    vehicleTypeId: json["vehicleTypeId"] as int,
    vehicleTypeName: json["vehicleTypeName"] as String,
    checkTime: json['checkTime'] == null
        ? null
        : DateTime.parse(json['checkTime'] as String),
    checkNote: json['checkNote'] as String,
    fuelLevel: json['fuelLevel'] as bool,
    machineTemperature: json['machineTemperature'] as bool,
    oilLevel: json['oilLevel'] as bool,
    accuStatus: json['accuStatus'] as bool,
    selfiePhoto:
        (json['selfiePhoto'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$TmsVehicleCheckDocumentToJson(
        TmsVehicleCheckDocument instance) =>
    <String, dynamic>{
      'checkFileGuid': instance.checkFileGuid,
      'shipmentRef': instance.shipmentRef,
      'driverId': instance.driverId,
      "driverName": instance.driverName,
      "driverRegNumber": instance.driverRegNumber,
      "driverSimType": instance.driverSimType,
      "driverRating": instance.driverRating,
      "vehicleId": instance.vehicleId,
      "vehicleName": instance.vehicleName,
      "vehicleNumber": instance.vehicleNumber,
      "vehicleTypeId": instance.vehicleTypeId,
      "vehicleTypeName": instance.vehicleTypeName,
      'checkTime': instance.checkTime?.toIso8601String(),
      'checkNote': instance.checkNote,
      'fuelLevel': instance.fuelLevel,
      'machineTemperature': instance.machineTemperature,
      'oilLevel': instance.oilLevel,
      'accuStatus': instance.accuStatus,
      'selfiePhoto': instance.selfiePhoto,
    };
