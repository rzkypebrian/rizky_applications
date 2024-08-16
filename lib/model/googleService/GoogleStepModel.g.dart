// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GoogleStepModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleStepModel _$GoogleStepModelFromJson(Map<String, dynamic> json) {
  return GoogleStepModel()
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
    ..htmlIntruction = json['html_instructions'] as String
    ..polyLineObject = json['polyline']
    ..travelMode = json['travel_mode'] as String
    ..manuver = json['manuver'] as String;
}

Map<String, dynamic> _$GoogleStepModelToJson(GoogleStepModel instance) =>
    <String, dynamic>{
      'distance': instance.distance?.toJson(),
      'duration': instance.duration?.toJson(),
      'end_address': instance.endAddress,
      'end_location': instance.endLocation?.toJson(),
      'start_address': instance.startAddress,
      'start_location': instance.startLocation?.toJson(),
      'html_instructions': instance.htmlIntruction,
      'polyline': instance.polyLineObject,
      'travel_mode': instance.travelMode,
      'manuver': instance.manuver,
    };
