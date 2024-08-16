// import 'dart:typed_data';
import 'package:json_annotation/json_annotation.dart';
part 'tmsDbGeometryModel.g.dart';

@JsonSerializable(explicitToJson: true)
class DbGeometryModel {
  int coordinateSystemId;
  String wellKnownText;
  // ByteData wellKnownBinary;

  DbGeometryModel({
    this.coordinateSystemId,
    // this.wellKnownBinary,
    this.wellKnownText,
  });

  factory DbGeometryModel.fromJson(data) => _$DbGeometryModelFromJson(data);

  Map<String, dynamic> toJson() => _$DbGeometryModelToJson(this);

  // factory DbGeometryModel.fromJson(Map<String, dynamic> json) {
  //   try {
  //     return DbGeometryModel(
  //       coordinateSystemId: json["Geometry"]["coordinateSystemId"],
  //       // wellKnownBinary: json["Geometry"]["wellKnownBinary"],
  //       wellKnownText: json["Geometry"]["wellKnownText"],
  //     );
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
