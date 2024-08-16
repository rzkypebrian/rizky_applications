// note
// typeMaintenance int
// 1 akan jatuh tempo
// 2 jatuh tempo
// 3 sudah service
// typeMissing int
// 1 km
// 2 hari
// pathIcon string
// type svg

import 'package:enerren/model/MaintenanceItemModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'MaintenanceScheduleModel.g.dart';

@JsonSerializable(explicitToJson: true)
class MaintenanceScheduleModel {
  String maintenanceId;
  DateTime dateTime;
  int typeMaintenance;
  String desc;
  String pathIcon;
  int typeMissing;
  int total;
  int status;
  MaintenanceItemModel maintenanceItemModel;

  MaintenanceScheduleModel({
    this.maintenanceId,
    this.dateTime,
    this.typeMaintenance,
    this.desc,
    this.pathIcon,
    this.typeMissing,
    this.total,
    this.maintenanceItemModel,
  });

  factory MaintenanceScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceModelToJson(this);

  static List<MaintenanceScheduleModel> get dummy {
    return [
      MaintenanceScheduleModel(
        typeMaintenance: 1,
        maintenanceId: "Id_000001",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_maps.svg",
        total: 10,
        typeMissing: 1,
        maintenanceItemModel: MaintenanceItemModel.dummy[1],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 1,
        maintenanceId: "Id_000002",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_times.svg",
        total: 10,
        typeMissing: 2,
        maintenanceItemModel: MaintenanceItemModel.dummy[2],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 1,
        maintenanceId: "Id_000003",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_maps.svg",
        total: 10,
        typeMissing: 1,
        maintenanceItemModel: MaintenanceItemModel.dummy[3],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 1,
        maintenanceId: "Id_000004",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_times.svg",
        total: 10,
        typeMissing: 2,
        maintenanceItemModel: MaintenanceItemModel.dummy[4],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 2,
        maintenanceId: "Id_000001",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_maps.svg",
        total: 10,
        typeMissing: 1,
        maintenanceItemModel: MaintenanceItemModel.dummy[5],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 2,
        maintenanceId: "Id_000002",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_maps.svg",
        total: 10,
        typeMissing: 1,
        maintenanceItemModel: MaintenanceItemModel.dummy[6],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 2,
        maintenanceId: "Id_000003",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_times.svg",
        total: 10,
        typeMissing: 2,
        maintenanceItemModel: MaintenanceItemModel.dummy[7],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 2,
        maintenanceId: "Id_000004",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_maps.svg",
        total: 10,
        typeMissing: 1,
        maintenanceItemModel: MaintenanceItemModel.dummy[8],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 3,
        maintenanceId: "Id_000001",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_check.svg",
        maintenanceItemModel: MaintenanceItemModel.dummy[9],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 3,
        maintenanceId: "Id_000002",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_check.svg",
        maintenanceItemModel: MaintenanceItemModel.dummy[10],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 3,
        maintenanceId: "Id_000003",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_check.svg",
        maintenanceItemModel: MaintenanceItemModel.dummy[0],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 3,
        maintenanceId: "Id_000004",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_check.svg",
        maintenanceItemModel: MaintenanceItemModel.dummy[1],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 1,
        maintenanceId: "Id_000001",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_maps.svg",
        total: 10,
        typeMissing: 1,
        maintenanceItemModel: MaintenanceItemModel.dummy[2],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 1,
        maintenanceId: "Id_000002",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_times.svg",
        total: 10,
        typeMissing: 2,
        maintenanceItemModel: MaintenanceItemModel.dummy[3],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 1,
        maintenanceId: "Id_000003",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_maps.svg",
        total: 10,
        typeMissing: 1,
        maintenanceItemModel: MaintenanceItemModel.dummy[4],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 1,
        maintenanceId: "Id_000004",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_times.svg",
        total: 10,
        typeMissing: 2,
        maintenanceItemModel: MaintenanceItemModel.dummy[5],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 2,
        maintenanceId: "Id_000001",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_maps.svg",
        total: 10,
        typeMissing: 1,
        maintenanceItemModel: MaintenanceItemModel.dummy[6],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 2,
        maintenanceId: "Id_000002",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_maps.svg",
        total: 10,
        typeMissing: 1,
        maintenanceItemModel: MaintenanceItemModel.dummy[7],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 2,
        maintenanceId: "Id_000003",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_times.svg",
        total: 10,
        typeMissing: 2,
        maintenanceItemModel: MaintenanceItemModel.dummy[8],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 2,
        maintenanceId: "Id_000004",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_maps.svg",
        total: 10,
        typeMissing: 1,
        maintenanceItemModel: MaintenanceItemModel.dummy[9],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 3,
        maintenanceId: "Id_000001",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_check.svg",
        maintenanceItemModel: MaintenanceItemModel.dummy[10],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 3,
        maintenanceId: "Id_000002",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_check.svg",
        maintenanceItemModel: MaintenanceItemModel.dummy[7],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 3,
        maintenanceId: "Id_000003",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_check.svg",
        maintenanceItemModel: MaintenanceItemModel.dummy[11],
      ),
      MaintenanceScheduleModel(
        typeMaintenance: 3,
        maintenanceId: "Id_000004",
        dateTime: DateTime.now(),
        desc: "oli",
        pathIcon: "assets/tms/icon_check.svg",
        maintenanceItemModel: MaintenanceItemModel.dummy[2],
      ),
    ];
  }
}
