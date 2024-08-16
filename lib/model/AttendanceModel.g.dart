// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AttendanceModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceModel _$AttendanceModelFromJson(Map<String, dynamic> json) {
  return AttendanceModel(
    driverId: json['driverId'] as int,
    driverName: json['driverName'] as String,
    vehicleIdVts: json['vehicleIdVts'] as int,
    vehicleTypeName: json['vehicleTypeName'] as String,
    vehicleNumber: json['vehicleNumber'] as String,
    reason: json['reason'] as String,
    attDate: json['attDate'] == null
        ? null
        : DateTime.parse(json['attDate'] as String),
    attendanceLat: (json['attendanceLat'] as num)?.toDouble(),
    attendanceLon: (json['attendanceLon'] as num)?.toDouble(),
    isPassed: (json['isPassed'] as bool),
    listItemAttendance: (json['listItemAttendance'] as List)
        ?.map((e) => e == null
            ? null
            : AttendanceItemModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AttendanceModelToJson(AttendanceModel instance) =>
    <String, dynamic>{
      'driverId': instance.driverId,
      'driverName': instance.driverName,
      'vehicleIdVts': instance.vehicleIdVts,
      'vehicleTypeName': instance.vehicleTypeName,
      'vehicleNumber': instance.vehicleNumber,
      'reason': instance.reason,
      'attDate': instance.attDate?.toIso8601String(),
      'attendanceLat': instance.attendanceLat,
      'attendanceLon': instance.attendanceLon,
      'listItemAttendance':
          instance.listItemAttendance?.map((e) => e?.toJson())?.toList(),
    };
