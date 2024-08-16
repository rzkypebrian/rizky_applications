import 'package:json_annotation/json_annotation.dart';
part 'AngkutShipmentDescription.g.dart';

@JsonSerializable(explicitToJson: true)
class AngkutShipmentDescription {
  int itemId;
  int detailshipmentId;
  String item;
  String itemDescription;
  int qty;
  String remarks;

  AngkutShipmentDescription({
    this.itemId,
    this.detailshipmentId,
    this.item,
    this.itemDescription,
    this.qty,
    this.remarks,
  });

  factory AngkutShipmentDescription.fromJson(Map<String, dynamic> json) =>
      _$AngkutShipmentDescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$AngkutShipmentDescriptionToJson(this);
}
