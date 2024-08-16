import 'package:enerren/model/tmsDbGeometryModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'tmsRouteModel.g.dart';

@JsonSerializable(explicitToJson: true)
class TmsRouteModel {
  int routeId;
  int memberId;
  String routeName;
  String routeCode;
  int fromGeofenceId;
  int toGeofenceId;
  bool twoWay;
  double xmin;
  double ymin;
  double xmax;
  double ymax;
  DbGeometryModel geom;
  DbGeometryModel buffer;
  int bufferDistance;
  DbGeometryModel waypoints;
  bool deleted;
  String insertedBy;
  DateTime insertedDate;
  String modifiedBy;
  DateTime modifiedDate;

  TmsRouteModel({
    this.routeId,
    this.memberId,
    this.routeName,
    this.routeCode,
    this.fromGeofenceId,
    this.toGeofenceId,
    this.twoWay,
    this.xmin,
    this.ymin,
    this.xmax,
    this.ymax,
    this.geom,
    this.buffer,
    this.bufferDistance,
    this.waypoints,
    this.deleted,
    this.insertedBy,
    this.insertedDate,
    this.modifiedBy,
    this.modifiedDate,
  });

  factory TmsRouteModel.fromJson(data) => _$TmsRouteModelFromJson(data);

  Map<String, dynamic> toJson() => _$TmsRouteModelToJson(this);

  // static List<TmsRouteModel> fromJsonList(dynamic data) {
  //   try {
  //     return (data as List).map((f) => TmsRouteModel.fromJson(f)).toList();
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // factory TmsRouteModel.fromJson(Map<String, dynamic> json) {
  //   return TmsRouteModel(
  //     routeId: json["routeId"],
  //     memberId: json["memberId"],
  //     routeName: json["routeName"],
  //     routeCode: json["routeCode"],
  //     fromGeofenceId: json["fromGeofenceId"],
  //     toGeofenceId: json["toGeofenceId"],
  //     twoWay: json["twoWay"],
  //     xmin: json["xmin"],
  //     ymin: json["ymin"],
  //     xmax: json["xmax"],
  //     ymax: json["ymax"],
  //     geom: DbGeometryModel.fromJson(json["geom"]),
  //     buffer: DbGeometryModel.fromJson(json["buffer"]),
  //     bufferDistance: json["bufferDistance"],
  //     waypoints: DbGeometryModel.fromJson(json["waypoints"]),
  //     deleted: json["deleted"],
  //     insertedBy: json["insertedBy"],
  //     insertedDate: json["insertedDate"] != null
  //         ? DateTimeUtil.converDate(json["insertedDate"])
  //         : null,
  //     modifiedBy: json["modifiedBy"],
  //     modifiedDate: json["modifiedDate"] != null
  //         ? DateTimeUtil.converDate(json["modifiedDate"])
  //         : null,
  //   );
  // }
}
