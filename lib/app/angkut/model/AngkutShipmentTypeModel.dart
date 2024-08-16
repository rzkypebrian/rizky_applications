import 'package:json_annotation/json_annotation.dart';
part 'AngkutShipmentTypeModel.g.dart';

@JsonSerializable(explicitToJson: true)
class TripAllowanceModel {
  int itemId;
  String itemCode;
  String itemDescription;
  double pricing;
  int qty;

  TripAllowanceModel({
    this.itemId,
    this.itemCode,
    this.itemDescription,
    this.pricing,
    this.qty,
  });

  factory TripAllowanceModel.fromJson(Map<String, dynamic> json) =>
      _$ANgkutShipmentTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ANgkutShipmentTypeModelToJson(this);
}
