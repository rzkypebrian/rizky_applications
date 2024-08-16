import 'package:json_annotation/json_annotation.dart';
part 'PaymentMethodeDetailModel.g.dart';

@JsonSerializable(explicitToJson: true)
class PaymentMethodeDetailModel {
  @JsonKey(name: 'methoDetailId')
  int methoDetailId;
  @JsonKey(name: 'methodId')
  int methodId;
  @JsonKey(name: 'iconUrl')
  String iconUrl;
  @JsonKey(name: 'methodDetailCode')
  String methodDetailCode;
  @JsonKey(name: 'methodDetailName')
  String methodDetailName;
  @JsonKey(name: 'apiGuid')
  String apiGuid;
  @JsonKey(name: 'transactionFeeType')
  int transactionFeeType;
  @JsonKey(name: 'transactionFeeAmount')
  double transactionFeeAmount;
  @JsonKey(name: 'transactionFeePersentage')
  double transactionFeePersentage;
  @JsonKey(name: 'remarks')
  String remarks;
  @JsonKey(name: 'ipay88Id')
  int ipay88Id;

  PaymentMethodeDetailModel({
    this.methoDetailId,
    this.methodId,
    this.iconUrl,
    this.methodDetailCode,
    this.methodDetailName,
    this.apiGuid,
    this.transactionFeeType,
    this.transactionFeeAmount,
    this.transactionFeePersentage,
    this.remarks,
    this.ipay88Id,
  });

  factory PaymentMethodeDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodeDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodeDetailModelToJson(this);
}
