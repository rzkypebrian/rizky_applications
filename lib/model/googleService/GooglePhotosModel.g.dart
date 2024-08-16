// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GooglePhotosModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GooglePhotosModel _$GooglePhotosModelFromJson(Map<String, dynamic> json) {
  return GooglePhotosModel(
    height: json['height'] as int,
    // htmlAttributions:
    //     (json['html_attributions'] as List)?.map((e) => e as String)?.toList(),
    photoReference: json['photo_reference'] as String,
    width: json['width'] as int,
  );
}

Map<String, dynamic> _$GooglePhotosModelToJson(GooglePhotosModel instance) =>
    <String, dynamic>{
      'height': instance.height,
      'html_attributions': instance.htmlAttributions,
      'photo_reference': instance.photoReference,
      'width': instance.width,
    };
