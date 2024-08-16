import 'package:json_annotation/json_annotation.dart';
part 'DriverRatingModel.g.dart';

@JsonSerializable(explicitToJson: true)
class DriverRatingModel {
  int ratingId;
  int shipmentId;
  int driverId;
  int customerId;
  double rating;
  String comment;
  DateTime ratingDate;

  DriverRatingModel({
    this.ratingId,
    this.shipmentId,
    this.driverId,
    this.customerId,
    this.rating,
    this.comment,
    this.ratingDate,
  });

  factory DriverRatingModel.fromJson(Map<String, dynamic> json) =>
      _$DriverRatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverRatingModelToJson(this);
}
