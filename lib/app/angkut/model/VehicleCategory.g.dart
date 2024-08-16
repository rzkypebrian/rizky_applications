// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VehicleCategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleCategory _$VehicleCategoryFromJson(Map<String, dynamic> json) {
  return VehicleCategory(
    vehicleSizeId: json['vehicleSizeId'] as int,
    vehicleSizeName: json['vehicleSizeName'] as String,
    remarks: json['remarks'] as String,
    urlIcon: json['urlIcon'] as String,
    isAvailable: json['isAvailable'] as bool,
    vehicleTypeList: (json['vehicleTypeList'] as List)
        ?.map((e) =>
            e == null ? null : VehicleType.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VehicleCategoryToJson(VehicleCategory instance) =>
    <String, dynamic>{
      'vehicleSizeId': instance.vehicleSizeId,
      'vehicleSizeName': instance.vehicleSizeName,
      'remarks': instance.remarks,
      'urlIcon': instance.urlIcon,
      'isAvailable': instance.isAvailable,
      'vehicleTypeList':
          instance.vehicleTypeList?.map((e) => e?.toJson())?.toList(),
    };

VehicleType _$VehicleTypeFromJson(Map<String, dynamic> json) {
  return VehicleType(
    vehicleTypeId: json['vehicleTypeId'] as int,
    memberId: json['memberId'] as int,
    vehicleTypeName: json['vehicleTypeName'] as String,
    remarks: json['remarks'] as String,
    maxPassenger: json['maxPassenger'] as int,
    sizeId: json['sizeId'] as int,
    configWaitingDuration: (json['configWaitingDuration'] as num)?.toDouble(),
    configWaitingParameter: (json['configWaitingParameter'] as num)?.toDouble(),
    configDistanceThreshold:
        (json['configDistanceThreshold'] as num)?.toDouble(),
    configWaitingAfterConfirm:
        (json['configWaitingAfterConfirm'] as num)?.toDouble(),
    length: json['length'] as String,
    width: json['width'] as String,
    height: json['height'] as String,
    weight: json['weight'] as String,
    volume: json['volume'] as String,
    iconUrl: json['iconUrl'] as String,
    insertedBy: json['insertedBy'] as String,
    insertedDate: json['insertedDate'] == null
        ? null
        : DateTime.parse(json['insertedDate'] as String),
    modifiedBy: json['modifiedBy'] as String,
    isAvailable: json['isAvailable'] as bool,
    modifiedDate: json['modifiedDate'] == null
        ? null
        : DateTime.parse(json['modifiedDate'] as String),
  );
}

Map<String, dynamic> _$VehicleTypeToJson(VehicleType instance) =>
    <String, dynamic>{
      'vehicleTypeId': instance.vehicleTypeId,
      'memberId': instance.memberId,
      'vehicleTypeName': instance.vehicleTypeName,
      'remarks': instance.remarks,
      'maxPassenger': instance.maxPassenger,
      'sizeId': instance.sizeId,
      'configWaitingDuration': instance.configWaitingDuration,
      'configWaitingParameter': instance.configWaitingParameter,
      'configDistanceThreshold': instance.configDistanceThreshold,
      'configWaitingAfterConfirm': instance.configWaitingAfterConfirm,
      'length': instance.length,
      'width': instance.width,
      'height': instance.height,
      'weight': instance.weight,
      'volume': instance.volume,
      'iconUrl': instance.iconUrl,
      'insertedBy': instance.insertedBy,
      'insertedDate': instance.insertedDate?.toIso8601String(),
      'modifiedBy': instance.modifiedBy,
      'isAvailable': instance.isAvailable,
      'modifiedDate': instance.modifiedDate?.toIso8601String(),
    };
