// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GooglePlaceModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GooglePlaceModel _$GooglePlaceModelFromJson(Map<String, dynamic> json) {
  json = json["result"];
  return GooglePlaceModel()
    ..addressComponents = (json['address_components'] as List)
        ?.map((e) => e == null
            ? null
            : GoogleAddressComponentModel.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..address = json['adr_address'] as String
    ..businessStatus = json['business_status'] as String
    ..formattedAddress = json['formatted_address'] as String
    ..formattedPhoneNumber = json['formatted_phone_number'] as String
    ..geometry = json['geometry'] == null
        ? null
        : GoogleGeometryModel.fromJson(json['geometry'] as Map<String, dynamic>)
    ..photos = (json['photos'] as List)
        ?.map((e) => e == null
            ? null
            : GooglePhotosModel.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..placeId = (json['place_id'] as String)
    ..rating = (json['rating'] as num)?.toDouble()
    ..reference = (json['reference'] as String)
    ..reviews = (json['reviews'] as List)
        ?.map((e) => e == null
            ? null
            : GoogleReviewModel.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..type = (json['type'] as List)?.map((e) => e as String)?.toList()
    ..url = json['url'] as String
    ..userRatingsTotal = json['user_ratings_total'] as int
    ..utcOffset = json['utc_offset'] as int
    ..vicinity = json['vicinity'] as String
    ..website = json['website'] as String;
}

Map<String, dynamic> _$GooglePlaceModelToJson(GooglePlaceModel instance) =>
    <String, dynamic>{
      'address_components':
          instance.addressComponents?.map((e) => e?.toJson())?.toList(),
      'adr_address': instance.address,
      'business_status': instance.businessStatus,
      'formatted_address': instance.formattedAddress,
      'formatted_phone_number': instance.formattedPhoneNumber,
      'geometry': instance.geometry?.toJson(),
      'photos': instance.photos?.map((e) => e?.toJson())?.toList(),
      'placeId': instance.placeId,
      'rating': instance.rating,
      'reference': instance.reference,
      'reviews': instance.reviews?.map((e) => e?.toJson())?.toList(),
      'type': instance.type,
      'url': instance.url,
      'user_ratings_total': instance.userRatingsTotal,
      'utc_offset': instance.utcOffset,
      'vicinity': instance.vicinity,
      'website': instance.website,
    };
