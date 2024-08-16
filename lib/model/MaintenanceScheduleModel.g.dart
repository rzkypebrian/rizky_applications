// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MaintenanceScheduleModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintenanceScheduleModel _$MaintenanceModelFromJson(Map<String, dynamic> json) {
  return MaintenanceScheduleModel(
    maintenanceId: json['id'] as String,
    dateTime: json['dateTime'] == null
        ? null
        : DateTime.parse(json['dateTime'] as String),
    typeMaintenance: json['typeMaintenance'] as int,
    desc: json['desc'] as String,
    pathIcon: json['pathIcon'] as String,
    typeMissing: json['typeMissing'] as int,
    total: json['total'] as int,
  );
}

Map<String, dynamic> _$MaintenanceModelToJson(
        MaintenanceScheduleModel instance) =>
    <String, dynamic>{
      'id': instance.maintenanceId,
      'dateTime': instance.dateTime?.toIso8601String(),
      'typeMaintenance': instance.typeMaintenance,
      'desc': instance.desc,
      'pathIcon': instance.pathIcon,
      'typeMissing': instance.typeMissing,
      'total': instance.total,
    };
