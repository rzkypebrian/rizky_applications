import 'package:json_annotation/json_annotation.dart';
part 'tmsShipmentHistory.g.dart';

@JsonSerializable(explicitToJson: true)
class TmsShipmentHistory {
  int trackingId;
  String trackingGuid;
  int memberId;
  int detailShipmentId;
  DateTime trackingDate;
  DateTime trackingEta;
  String shipmentStatus;
  String messageEn;
  String messageId;
  String remarks;

  TmsShipmentHistory({
    this.trackingId,
    this.trackingGuid,
    this.memberId,
    this.detailShipmentId,
    this.trackingDate,
    this.trackingEta,
    this.shipmentStatus,
    this.messageEn,
    this.messageId,
    this.remarks,
  });

  factory TmsShipmentHistory.fromJson(data) =>
      _$TmsShipmentHistoryFromJson(data);

  Map<String, dynamic> toJson() => _$TmsShipmentHistoryToJson(this);

  // static List<TmsShipmentHistory> fromJsonList(dynamic data) {
  //   try {
  //     return (data as List).map((f) => TmsShipmentHistory.fromJson(f)).toList();
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // factory TmsShipmentHistory.fromJson(Map<String, dynamic> data) {
  //   return TmsShipmentHistory(
  //     trackingId: data["trackingId"],
  //     trackingGuid: data["trackingGuid"],
  //     memberId: data["memberId"],
  //     detailShipmentId: data["detailShipmentId"],
  //     trackingDate: data["trackingDate"] != null
  //         ? DateTimeUtil.converDate(data["trackingDate"])
  //         : null,
  //     trackingEta: data["trackingEta"] != null
  //         ? DateTimeUtil.converDate(data["trackingEta"])
  //         : null,
  //     shipmentStatus: data["shipmentStatus"],
  //     messageEn: data["messageEn"],
  //     messageId: data["messageId"],
  //     remarks: data["remarks"],
  //   );
  // }
}
