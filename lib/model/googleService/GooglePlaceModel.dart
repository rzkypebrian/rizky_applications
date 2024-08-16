import 'dart:convert';

import 'package:enerren/model/googleService/GoogleApiEndPointUtil.dart';
import 'package:enerren/util/NetworkUtil.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'GoogleAddressComponentModel.dart';
import 'GoogleGeometryModel.dart';
import 'GooglePhotosModel.dart';
import 'GoogleReviewModel.dart';
part 'GooglePlaceModel.g.dart';

@JsonSerializable(explicitToJson: true)
class GooglePlaceModel {
  @JsonKey(name: "address_components")
  List<GoogleAddressComponentModel> addressComponents;

  @JsonKey(name: "adr_address")
  String address;

  @JsonKey(name: "business_status")
  String businessStatus;

  @JsonKey(name: "formatted_address")
  String formattedAddress;

  @JsonKey(name: "formatted_phone_number")
  String formattedPhoneNumber;

  @JsonKey(name: "geometry")
  GoogleGeometryModel geometry;

  @JsonKey(name: "photos")
  List<GooglePhotosModel> photos;

  @JsonKey(name: "place_id")
  String placeId;

  @JsonKey(name: "rating")
  double rating;

  @JsonKey(name: "reference")
  String reference;

  @JsonKey(name: "reviews")
  List<GoogleReviewModel> reviews;

  @JsonKey(name: "type")
  List<String> type;

  @JsonKey(name: "url")
  String url;

  @JsonKey(name: "user_ratings_total")
  int userRatingsTotal;

  @JsonKey(name: "utc_offset")
  int utcOffset;

  @JsonKey(name: "vicinity")
  String vicinity;

  @JsonKey(name: "website")
  String website;

  GooglePlaceModel({
    this.addressComponents,
    this.address,
    this.businessStatus,
    this.formattedAddress,
    this.formattedPhoneNumber,
    this.geometry,
    this.photos,
    this.rating,
    this.reference,
    this.reviews,
    this.type,
    this.url,
    this.userRatingsTotal,
    this.utcOffset,
    this.vicinity,
    this.website,
  });

  factory GooglePlaceModel.fromJson(Map<String, dynamic> json) =>
      _$GooglePlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$GooglePlaceModelToJson(this);

  static Future<GooglePlaceModel> getByPlaceId({
    @required String placeId,
    @required String apiKey,
  }) {
    return NetworkUtil()
        .get(
      GoogleApiEndPointUtil().getPlace(
        placeid: placeId,
        apiKey: apiKey,
      ),
    )
        .then((value) {
      return GooglePlaceModel.fromJson(json.decode(value));
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }
}
