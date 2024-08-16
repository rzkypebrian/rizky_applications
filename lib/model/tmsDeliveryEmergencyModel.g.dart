// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmsDeliveryEmergencyModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmsDeliveryEmergencyModel _$TmsDeliveryEmergencyModelFromJson(
    Map<String, dynamic> json) {
  return TmsDeliveryEmergencyModel(
      emergencyFileGuid: json['emergencyFileGuid'] as String,
      destinationId: json['destinationId'] as int,
      vehicleId: json['vehicleId'] as int,
      vehicleNumber: json['vehicleNumber'] as String,
      driverId: json['driverId'] as int,
      driverName: json['driverName'] as String,
      driverImageUrl: json['driverImageUrl'] as String,
      driverRating: json["driverRating"] as double,
      memberId: json['memberId'] as int,
      emergencyTime: json['emergencyTime'] == null
          ? null
          : DateTime.parse(json['emergencyTime'] as String),
      emergencyNote: json['emergencyNote'] as String,
      emergencyFile: json['emergencyFile'] as String,
      emergencyStatus: json['emergencyStatus'] as int,
      emergencyLat: json['emergencyLat'] as double,
      emergencyLon: json['emergencyLon'] as double,
      insertedBy: json['insertedBy'] as String,
      insertedDate: json['insertedDate'] == null
          ? null
          : DateTime.parse(json['insertedDate'] as String),
      modifiedBy: json['modifiedBy'] as String,
      modifiedDate: json['modifiedDate'] == null
          ? null
          : DateTime.parse(json['modifiedDate'] as String),
      lastShipmentStatus: json['lastShipmentStatus'] as int,
      driverData: DriverModel.fromJson(json["driverData"]));
}

Map<String, dynamic> _$TmsDeliveryEmergencyModelToJson(
        TmsDeliveryEmergencyModel instance) =>
    <String, dynamic>{
      'emergencyFileGuid': instance.emergencyFileGuid,
      'destinationId': instance.destinationId,
      "vehicleId": instance.vehicleId,
      'vehicleNumber': instance.vehicleNumber,
      'driverId': instance.driverId,
      'driverName': instance.driverName,
      "driverImageUrl": instance.driverImageUrl,
      "driverRating": instance.driverRating,
      'memberId': instance.memberId,
      'emergencyTime': instance.emergencyTime?.toIso8601String(),
      'emergencyNote': instance.emergencyNote,
      'emergencyFile': instance.emergencyFile,
      'emergencyStatus': instance.emergencyStatus,
      'emergencyLat': instance.emergencyLat,
      'emergencyLon': instance.emergencyLon,
      'insertedBy': instance.insertedBy,
      'insertedDate': instance.insertedDate?.toIso8601String(),
      'modifiedBy': instance.modifiedBy,
      'modifiedDate': instance.modifiedDate?.toIso8601String(),
      'lastShipmentStatus': instance.lastShipmentStatus,
      "driverData": instance.driverData.toJson(),
    };

TmsDeliveryEmergencyInputModel _$TmsDeliveryEmergencyInputModelFromJson(
    Map<String, dynamic> json) {
  return TmsDeliveryEmergencyInputModel(
    destinationId: json['destinationId'] as int,
    vehicleNumber: json['vehicleNumber'] as String,
    vehicleId: json['vehicleId'] as int,
    driverId: json['driverId'] as int,
    memberId: json['memberId'] as int,
    emergencyTime: json['emergencyTime'] == null
        ? null
        : DateTime.parse(json['emergencyTime'] as String),
    emergencyNote: json['emergencyNote'] as String,
    emergencyFile: json['emergencyFile'] as String,
    emergencyStatus: json['emergencyStatus'] as int,
    emergencyLat: json['emergencyLat'] as double,
    emergencyLon: json['emergencyLon'] as double,
    insertedBy: json['insertedBy'] as String,
  );
}

Map<String, dynamic> _$TmsDeliveryEmergencyInputModelToJson(
        TmsDeliveryEmergencyInputModel instance) =>
    <String, dynamic>{
      'destinationId': instance.destinationId,
      'vehicleNumber': instance.vehicleNumber,
      'vehicleId': instance.vehicleId,
      'driverId': instance.driverId,
      'memberId': instance.memberId,
      'emergencyTime': instance.emergencyTime?.toIso8601String(),
      'emergencyNote': instance.emergencyNote,
      'emergencyFile': instance.emergencyFile,
      'emergencyStatus': instance.emergencyStatus,
      'emergencyLat': instance.emergencyLat,
      'emergencyLon': instance.emergencyLon,
      'insertedBy': instance.insertedBy,
    };
