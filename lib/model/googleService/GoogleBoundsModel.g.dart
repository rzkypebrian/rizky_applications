// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GoogleBoundsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleBoundsModel _$GoogleBoundsModelFromJson(Map<String, dynamic> json) {
  return GoogleBoundsModel()
    ..northeast = json['northeast'] == null
        ? null
        : GooglePosition.fromJson(json['northeast'] as Map<String, dynamic>)
    ..southwest = json['southwest'] == null
        ? null
        : GooglePosition.fromJson(json['southwest'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GoogleBoundsModelToJson(GoogleBoundsModel instance) =>
    <String, dynamic>{
      'northeast': instance.northeast?.toJson(),
      'southwest': instance.southwest?.toJson(),
    };
