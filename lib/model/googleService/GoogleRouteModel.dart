import 'GooglePosition.dart';
import 'GoogleUtil.dart';
import 'GoogleBoundsModel.dart';
import 'GoogleLegsModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'GoogleRouteModel.g.dart';

@JsonSerializable(explicitToJson: true)
class GoogleRouteModel {
  @JsonKey(name: "bounds")
  GoogleBoundsModel bounds;

  @JsonKey(name: "legs")
  List<GoogleLegsModel> legs;

  @JsonKey(name: "overview_polyline")
  dynamic overViewPolyLineObject;

  @JsonKey(name: "summary")
  String summary;

  List<GooglePosition> get overViewPolyline {
    return GoogleUtil.convertToLatLng(
        GoogleUtil.decodePoly(this.overViewPolyLineObject["points"]));
  }

  static GoogleRouteModel fromJson(Map<String, dynamic> json) =>
      _$GoogleRouteModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleRouteModelToJson(this);
}
