// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmsCountModelShipmentSummaryModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmsCountShipmentSummaryModel _$TmsCountShipmentSummaryModelFromJson(
    Map<String, dynamic> json) {
  return TmsCountShipmentSummaryModel(
    process: json['process'] as int,
    shipped: json['shipped'] as int,
    finish: json['finish'] as int,
    cancel: json['cancel'] as int,
  );
}

Map<String, dynamic> _$TmsCountShipmentSummaryModelToJson(
        TmsCountShipmentSummaryModel instance) =>
    <String, dynamic>{
      'process': instance.process,
      'shipped': instance.shipped,
      'finish': instance.finish,
      'cancel': instance.cancel,
    };
