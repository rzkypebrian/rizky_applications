import 'package:json_annotation/json_annotation.dart';
part 'serchShipmentNumberHistory.g.dart';

@JsonSerializable(explicitToJson: true)
class SerchShipmentNumberHistory {
  String shipmentNumber;

  SerchShipmentNumberHistory({
    this.shipmentNumber,
  });

  factory SerchShipmentNumberHistory.fromJson(Map<String, dynamic> json) =>
      _$SerchShipmentNumberHistoryFromJson(json);

   Map<String, dynamic> toJson() => _$SerchShipmentNumberHistoryToJson(this);
}
