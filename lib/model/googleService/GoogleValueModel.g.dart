// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GoogleValueModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleValueModel _$GoogleValueModelFromJson(Map<String, dynamic> json) {
  return GoogleValueModel()
    ..text = json['text'] as String
    ..value = (json['value'] as num)?.toDouble();
}

Map<String, dynamic> _$GoogleValueModelToJson(GoogleValueModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'value': instance.value,
    };
