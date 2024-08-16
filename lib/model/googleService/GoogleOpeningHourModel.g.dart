// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GoogleOpeningHourModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleOpeningHourModel _$GoogleOpeningHourModelFromJson(
    Map<String, dynamic> json) {
  return GoogleOpeningHourModel(
    openNow: json['open_now'] as bool,
    periods: json['periods'] as List,
    weekdayText:
        (json['weekday_text'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$GoogleOpeningHourModelToJson(
        GoogleOpeningHourModel instance) =>
    <String, dynamic>{
      'open_now': instance.openNow,
      'periods': instance.periods,
      'weekday_text': instance.weekdayText,
    };
