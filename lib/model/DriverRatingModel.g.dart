// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DriverRatingModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverRatingModel _$DriverRatingModelFromJson(Map<String, dynamic> json) {
  return DriverRatingModel(
    ratingId: json['ratingId'] as int,
    shipmentId: json['shipmentId'] as int,
    driverId: json['driverId'] as int,
    customerId: json['customerId'] as int,
    rating: (json['rating'] as num).toDouble(),
    comment: json['comment'] as String,
    ratingDate: json['ratingDate'] == null
        ? null
        : DateTime.parse(json['ratingDate'] as String),
  );
}

Map<String, dynamic> _$DriverRatingModelToJson(DriverRatingModel instance) =>
    <String, dynamic>{
      'ratingId': instance.ratingId,
      'shipmentId': instance.shipmentId,
      'driverId': instance.driverId,
      'customerId': instance.customerId,
      'rating': instance.rating,
      'comment': instance.comment,
      'ratingDate': instance.ratingDate?.toIso8601String(),
    };
