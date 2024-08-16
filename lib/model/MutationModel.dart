import 'package:json_annotation/json_annotation.dart';

part 'MutationModel.g.dart';
@JsonSerializable(explicitToJson: true)

class MutationModel {
  String title;
  double inputs;
  double outs;
  double lasts;
  double finals;

  MutationModel({
    this.title,
    this.inputs,
    this.outs,
    this.lasts,
    this.finals,
  });

  factory MutationModel.fromJson(Map<String, dynamic> json) =>
      _$MutationModelFromJson(json);

  Map<String, dynamic> toJson() => _$MutationModelToJson(this);
}