// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmsVehicleModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmsVehicleModel _$TmsVehicleModelFromJson<T>(Map<String, dynamic> json,
    {ChildReader<T> childReader}) {
  return TmsVehicleModel<T>(
    vehicleId: json['vehicleId'] as int,
    vtsVehicleId: json['vehicleIdVts'] as int,
    vehicleName: json['vehicleName'] as String,
    vehicleNumber: json['vehicleNumber'] as String,
    vehicleRegNumber: json['vehicleRegNumber'] as String,
    vehicleRegDate: json['vehicleRegDate'] == null
        ? null
        : DateTime.parse(json['vehicleRegDate'] as String),
    vehicleStatusId: json['vehicleStatusId'] as int,
    vehicleStatusName: json['vehicleStatusName'] as String,
    vehicleTypeCode: json['vehicleTypeCode'] as String,
    vehicleTypeName: json['vehicleTypeName'] as String,
    vehicleTypeIconUrl: json['vehicleTypeIconUrl'] as String,
    vehicleTypeIconUrlTop: json['vehicleTypeIconUrlTop'] as String,
    vehicleTypeIconTopSize: json['vehicleTypeIconTopSize'] as int,
    vehicleSensor: json['vehicleSensor'] as String,
    vehicleBackDoorSensor: json["vehicleBackDoorSensor"],
    vehicleFanSensor: json["vehicleFanSensor"],
    vehicleTemperatureSensor: json["vehicleTemperatureSensor"],
    vehicleBackDoorSensorValue: json["vehicleBackDoorSensorValue"] as bool,
    vehicleFanSensorValue: json["vehicleFanSensorValue"] as bool,
    vehicleTemperatureSensorValue: json["vehicleTemperatureSensorValue"],
    transporterCode: json['transporterCode'] as String,
    transporterName: json['transporterName'] as String,
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
    shipmentHeaderData: json["shipmentHeaderData"] != null
        ? (json["shipmentHeaderData"] as List)
            .map((f) => childReader(f))
            .toList()
        : null,

    // TmsShipmentModel.fromJson<T>(json["shipmentHeaderData"],
    //     childReader: childReader)
  );
}

Map<String, dynamic> _$TmsVehicleModelToJson(TmsVehicleModel instance) =>
    <String, dynamic>{
      'vehicleId': instance.vehicleId,
      'vehicleIdVts': instance.vtsVehicleId,
      'vehicleName': instance.vehicleName,
      'vehicleNumber': instance.vehicleNumber,
      'vehicleRegNumber': instance.vehicleRegNumber,
      'vehicleRegDate': instance.vehicleRegDate?.toIso8601String(),
      'vehicleStatusId': instance.vehicleStatusId,
      'vehicleStatusName': instance.vehicleStatusName,
      'vehicleTypeCode': instance.vehicleTypeCode,
      'vehicleTypeName': instance.vehicleTypeName,
      'vehicleTypeIconUrl': instance.vehicleTypeIconUrl,
      'vehicleTypeIconUrlTop': instance.vehicleTypeIconUrlTop,
      'vehicleTypeIconTopSize': instance.vehicleTypeIconTopSize,
      'vehicleSensor': instance.vehicleSensor,
      'vehicleBackDoorSensor': instance.vehicleBackDoorSensor,
      'vehicleFanSensor': instance.vehicleFanSensor,
      'vehicleTemperatureSensor': instance.vehicleTemperatureSensor,
      'vehicleBackDoorSensorValue': instance.vehicleBackDoorSensorValue,
      'vehicleFanSensorValue': instance.vehicleFanSensorValue,
      'vehicleTemperatureSensorValue': instance.vehicleTemperatureSensorValue,
      'transporterCode': instance.transporterCode,
      'transporterName': instance.transporterName,
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
      'shipmentHeaderData':
          instance.shipmentHeaderData.map((f) => f.toJson()).toList(),
    };
