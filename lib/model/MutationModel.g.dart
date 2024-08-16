// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MutationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MutationModel _$MutationModelFromJson(Map<String, dynamic> json) {
  return MutationModel(
    title: json['title'] as String,
    inputs: (json['inputs'] as num)?.toDouble(),
    outs: (json['outs'] as num)?.toDouble(),
    lasts: (json['lasts'] as num)?.toDouble(),
    finals: (json['finals'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$MutationModelToJson(MutationModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'inputs': instance.inputs,
      'outs': instance.outs,
      'lasts': instance.lasts,
      'finals': instance.finals,
    };
