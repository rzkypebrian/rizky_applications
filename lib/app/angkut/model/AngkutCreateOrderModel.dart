import 'package:enerren/app/angkut/model/AngkutDestination.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentTypeModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'AngkutCreateOrderModel.g.dart';

@JsonSerializable(explicitToJson: true)
class AngkutCreateOrderModel {
  int customerId;
  int vehicleTypeId;
  DateTime scheduledDate;
  bool isInstant;
  bool extraHelper;
  int extraHelperCount;
  String deliveryNo;
  String itemDescription;
  double shipmentFee;
  int insuranceId;
  int premiId;
  double estimateGoodsPrice;
  String voucherCode;
  List<AngkutDestination> detailDestinationList;
  List<TripAllowanceModel> shipmentItemTypeList;

  AngkutCreateOrderModel({
    this.customerId,
    this.vehicleTypeId,
    this.scheduledDate,
    this.isInstant,
    this.extraHelper,
    this.extraHelperCount,
    this.deliveryNo,
    this.itemDescription,
    this.shipmentFee,
    this.insuranceId,
    this.premiId,
    this.estimateGoodsPrice,
    this.detailDestinationList,
    this.shipmentItemTypeList,
    this.voucherCode,
  });

  factory AngkutCreateOrderModel.fromJson(Map<String, dynamic> json) =>
      _$AngkutCreateOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$AngkutCreateOrderModelToJson(this);
}
