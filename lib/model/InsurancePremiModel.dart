import 'package:json_annotation/json_annotation.dart';
part 'InsurancePremiModel.g.dart';

@JsonSerializable(explicitToJson: true)
class InsurancePremiModel {
  int premiId;
  int insuranceId;
  String premiCode;
  String premiName;
  double minThreshold;
  double maxThreshold;
  double insurancePercentage;
  double insuranceAmount;

  InsurancePremiModel({
    this.premiId,
    this.insuranceId,
    this.premiCode,
    this.premiName,
    this.minThreshold,
    this.maxThreshold,
    this.insurancePercentage,
    this.insuranceAmount,
  });

  factory InsurancePremiModel.fromJson(Map<String, dynamic> json) =>
      _$InsurancePremiModelFromJson(json);

  Map<String, dynamic> toJson() => _$InsurancePremiModelToJson(this);
}
