// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GoogleLegsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleLegsModel _$GoogleLegsModelFromJson(Map<String, dynamic> json) {
  return GoogleLegsModel()
    ..distance = json['distance'] == null
        ? null
        : GoogleValueModel.fromJson(json['distance'] as Map<String, dynamic>)
    ..duration = json['duration'] == null
        ? null
        : GoogleValueModel.fromJson(json['duration'] as Map<String, dynamic>)
    ..endAddress = json['end_address'] as String
    ..endLocation = json['end_location'] == null
        ? null
        : GooglePosition.fromJson(json['end_location'] as Map<String, dynamic>)
    ..startAddress = json['start_address'] as String
    ..startLocation = json['start_location'] == null
        ? null
        : GooglePosition.fromJson(
            json['start_location'] as Map<String, dynamic>)
    ..steps = (json['steps'] as List)
        ?.map((e) => e == null
            ? null
            : GoogleStepModel.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GoogleLegsModelToJson(GoogleLegsModel instance) =>
    <String, dynamic>{
      'distance': instance.distance?.toJson(),
      'duration': instance.duration?.toJson(),
      'end_address': instance.endAddress,
      'end_location': instance.endLocation?.toJson(),
      'start_address': instance.startAddress,
      'start_location': instance.startLocation?.toJson(),
      'steps': instance.steps?.map((e) => e?.toJson())?.toList(),
    };
