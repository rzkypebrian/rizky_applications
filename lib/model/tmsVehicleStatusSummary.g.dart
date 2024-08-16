// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmsVehicleStatusSummary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmsVehicleStatusSummary _$TmsVehicleStatusSummaryFromJson(
    Map<String, dynamic> json) {
  return TmsVehicleStatusSummary(
    rest: json['rest'] as int,
    standby: json['standby'] as int,
    order: json['order'] as int,
  );
}

Map<String, dynamic> _$TmsVehicleStatusSummaryToJson(
        TmsVehicleStatusSummary instance) =>
    <String, dynamic>{
      'rest': instance.rest,
      'standby': instance.standby,
      'order': instance.order,
    };
