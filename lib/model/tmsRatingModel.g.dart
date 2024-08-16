// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmsRatingModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmsRatingModel _$TmsRatingModelFromJson(Map<String, dynamic> json) {
  return TmsRatingModel(
    shipmentId: json['shipmentId'] as int,
    memberId: json['memberId'] as int,
    ratingValue: (json['ratingValue'] as num)?.toDouble(),
    comment: json['comment'] as String,
    driverId: json['driverId'] as int,
    driverNik: json['driverNik'] as String,
    customerNo: json['customerNo'] as String,
  );
}

Map<String, dynamic> _$TmsRatingModelToJson(TmsRatingModel instance) =>
    <String, dynamic>{
      'shipmentId': instance.shipmentId,
      'memberId': instance.memberId,
      'ratingValue': instance.ratingValue,
      'comment': instance.comment,
      'driverId': instance.driverId,
      'driverNik': instance.driverNik,
      'customerNo': instance.customerNo,
      "customerId": instance.customerNo,
      "rating": instance.ratingValue,
    };
