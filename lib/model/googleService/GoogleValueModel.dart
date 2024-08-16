import 'package:json_annotation/json_annotation.dart';
part 'GoogleValueModel.g.dart';

@JsonSerializable(explicitToJson: true)
class GoogleValueModel {
  String text;
  double value;

  static GoogleValueModel fromJson(Map<String, dynamic> json) =>
      _$GoogleValueModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleValueModelToJson(this);
}
