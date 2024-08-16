import 'dart:math';

import 'package:enerren/util/SystemUtil.dart';

class MaintenanceItemModel {
  String maintenanceId;
  String activity;
  PriorityModel priority;
  String limit;
  ThreshHoldModel threshHoldModel;
  DateTime thresholdDate;
  int threshold;
  bool repeat;
  ShowBeforeModel showBeforeModel;
  AssetModel asset;
  AssetsModel assetsModel;
  CategoryModel catergory;
  List<InstructionModel> instructionModels;
  DateTime dateTime;
  int typeOverDue; // 1 will overdue 2 overdue
  int total;

  MaintenanceItemModel({
    this.maintenanceId,
    this.activity,
    this.priority,
    this.limit,
    this.repeat = true,
    this.asset,
    this.threshold,
    this.showBeforeModel,
    this.thresholdDate,
    this.threshHoldModel,
    this.assetsModel,
    this.catergory,
    this.instructionModels,
    this.dateTime,
    this.typeOverDue = 1,
    this.total,
  });

  static List<MaintenanceItemModel> dummy = [
    MaintenanceItemModel(
      maintenanceId: "id_0001",
      activity: "tune up",
      dateTime: DateTime.now(),
      priority: PriorityModel.dummy[Random().nextInt(3)],
      threshHoldModel: ThreshHoldModel.dummy[(Random().nextInt(3))],
      threshold: 1,
      thresholdDate: DateTime.now(),
      repeat: true,
      asset: AssetModel.dummy[Random().nextInt(3)],
      assetsModel: AssetsModel.dummy[Random().nextInt(3)],
      catergory: CategoryModel.dummy[Random().nextInt(2)],
      instructionModels: InstructionModel.dummy,
      total: 30,
      showBeforeModel: ShowBeforeModel.dummy[Random().nextInt(14)],
      typeOverDue: 1,
    ),
    MaintenanceItemModel(
      maintenanceId: "id_0002",
      activity: "tune up",
      dateTime: DateTime.now(),
      priority: PriorityModel.dummy[Random().nextInt(3)],
      threshHoldModel: ThreshHoldModel.dummy[(Random().nextInt(3))],
      threshold: 1,
      thresholdDate: DateTime.now(),
      repeat: true,
      asset: AssetModel.dummy[Random().nextInt(3)],
      assetsModel: AssetsModel.dummy[Random().nextInt(3)],
      catergory: CategoryModel.dummy[Random().nextInt(1)],
      instructionModels: InstructionModel.dummy,
      total: 30,
      showBeforeModel: ShowBeforeModel.dummy[Random().nextInt(14)],
      typeOverDue: 1,
    ),
    MaintenanceItemModel(
      maintenanceId: "id_0003",
      activity: "tune up",
      dateTime: DateTime.now(),
      priority: PriorityModel.dummy[Random().nextInt(3)],
      threshHoldModel: ThreshHoldModel.dummy[(Random().nextInt(3))],
      threshold: 1,
      thresholdDate: DateTime.now(),
      repeat: true,
      asset: AssetModel.dummy[Random().nextInt(3)],
      assetsModel: AssetsModel.dummy[Random().nextInt(3)],
      catergory: CategoryModel.dummy[Random().nextInt(2)],
      instructionModels: InstructionModel.dummy,
      total: 30,
      showBeforeModel: ShowBeforeModel.dummy[Random().nextInt(14)],
      typeOverDue: 1,
    ),
    MaintenanceItemModel(
      maintenanceId: "id_0004",
      activity: "tune up",
      dateTime: DateTime.now(),
      priority: PriorityModel.dummy[Random().nextInt(3)],
      threshHoldModel: ThreshHoldModel.dummy[(Random().nextInt(3))],
      threshold: 1,
      thresholdDate: DateTime.now(),
      repeat: true,
      asset: AssetModel.dummy[Random().nextInt(3)],
      assetsModel: AssetsModel.dummy[Random().nextInt(3)],
      catergory: CategoryModel.dummy[Random().nextInt(2)],
      instructionModels: InstructionModel.dummy,
      total: 30,
      showBeforeModel: ShowBeforeModel.dummy[Random().nextInt(14)],
      typeOverDue: 1,
    ),
    MaintenanceItemModel(
      maintenanceId: "id_0001",
      activity: "tune up",
      dateTime: DateTime.now(),
      priority: PriorityModel.dummy[Random().nextInt(3)],
      threshHoldModel: ThreshHoldModel.dummy[(Random().nextInt(3))],
      threshold: 1,
      thresholdDate: DateTime.now(),
      repeat: true,
      asset: AssetModel.dummy[Random().nextInt(3)],
      assetsModel: AssetsModel.dummy[Random().nextInt(3)],
      catergory: CategoryModel.dummy[Random().nextInt(2)],
      instructionModels: InstructionModel.dummy,
      total: 30,
      showBeforeModel: ShowBeforeModel.dummy[Random().nextInt(14)],
      typeOverDue: 2,
    ),
    MaintenanceItemModel(
      maintenanceId: "id_0002",
      activity: "tune up",
      dateTime: DateTime.now(),
      priority: PriorityModel.dummy[Random().nextInt(3)],
      threshHoldModel: ThreshHoldModel.dummy[(Random().nextInt(3))],
      threshold: 1,
      thresholdDate: DateTime.now(),
      repeat: true,
      asset: AssetModel.dummy[Random().nextInt(3)],
      assetsModel: AssetsModel.dummy[Random().nextInt(3)],
      catergory: CategoryModel.dummy[Random().nextInt(2)],
      instructionModels: InstructionModel.dummy,
      total: 30,
      showBeforeModel: ShowBeforeModel.dummy[Random().nextInt(14)],
      typeOverDue: 2,
    ),
    MaintenanceItemModel(
      maintenanceId: "id_0003",
      activity: "tune up",
      dateTime: DateTime.now(),
      priority: PriorityModel.dummy[Random().nextInt(3)],
      threshHoldModel: ThreshHoldModel.dummy[(Random().nextInt(3))],
      threshold: 1,
      thresholdDate: DateTime.now(),
      repeat: true,
      asset: AssetModel.dummy[Random().nextInt(3)],
      assetsModel: AssetsModel.dummy[Random().nextInt(3)],
      catergory: CategoryModel.dummy[Random().nextInt(2)],
      instructionModels: InstructionModel.dummy,
      total: 30,
      showBeforeModel: ShowBeforeModel.dummy[Random().nextInt(14)],
      typeOverDue: 2,
    ),
    MaintenanceItemModel(
      maintenanceId: "id_0004",
      activity: "tune up",
      dateTime: DateTime.now(),
      priority: PriorityModel.dummy[Random().nextInt(3)],
      threshHoldModel: ThreshHoldModel.dummy[(Random().nextInt(3))],
      threshold: 1,
      thresholdDate: DateTime.now(),
      repeat: true,
      asset: AssetModel.dummy[Random().nextInt(3)],
      assetsModel: AssetsModel.dummy[Random().nextInt(3)],
      catergory: CategoryModel.dummy[Random().nextInt(2)],
      instructionModels: InstructionModel.dummy,
      total: 30,
      showBeforeModel: ShowBeforeModel.dummy[Random().nextInt(14)],
      typeOverDue: 2,
    ),
    MaintenanceItemModel(
      maintenanceId: "id_0004",
      activity: "tune up",
      dateTime: DateTime.now(),
      priority: PriorityModel.dummy[Random().nextInt(3)],
      threshHoldModel: ThreshHoldModel.dummy[(Random().nextInt(3))],
      threshold: 1,
      thresholdDate: DateTime.now(),
      repeat: true,
      asset: AssetModel.dummy[Random().nextInt(3)],
      assetsModel: AssetsModel.dummy[Random().nextInt(3)],
      catergory: CategoryModel.dummy[Random().nextInt(2)],
      instructionModels: InstructionModel.dummy,
      total: 30,
      showBeforeModel: ShowBeforeModel.dummy[Random().nextInt(14)],
      typeOverDue: 3,
    ),
    MaintenanceItemModel(
      maintenanceId: "id_0001",
      activity: "tune up",
      dateTime: DateTime.now(),
      priority: PriorityModel.dummy[Random().nextInt(3)],
      threshHoldModel: ThreshHoldModel.dummy[(Random().nextInt(3))],
      threshold: 1,
      thresholdDate: DateTime.now(),
      repeat: true,
      asset: AssetModel.dummy[Random().nextInt(3)],
      assetsModel: AssetsModel.dummy[Random().nextInt(3)],
      catergory: CategoryModel.dummy[Random().nextInt(2)],
      instructionModels: InstructionModel.dummy,
      total: 30,
      showBeforeModel: ShowBeforeModel.dummy[Random().nextInt(14)],
      typeOverDue: 3,
    ),
    MaintenanceItemModel(
      maintenanceId: "id_0002",
      activity: "tune up",
      dateTime: DateTime.now(),
      priority: PriorityModel.dummy[Random().nextInt(3)],
      threshHoldModel: ThreshHoldModel.dummy[(Random().nextInt(3))],
      threshold: 1,
      thresholdDate: DateTime.now(),
      repeat: true,
      asset: AssetModel.dummy[Random().nextInt(3)],
      assetsModel: AssetsModel.dummy[Random().nextInt(3)],
      catergory: CategoryModel.dummy[Random().nextInt(2)],
      instructionModels: InstructionModel.dummy,
      total: 30,
      showBeforeModel: ShowBeforeModel.dummy[Random().nextInt(14)],
      typeOverDue: 3,
    ),
    MaintenanceItemModel(
      maintenanceId: "id_0003",
      activity: "tune up",
      dateTime: DateTime.now(),
      priority: PriorityModel.dummy[Random().nextInt(3)],
      threshHoldModel: ThreshHoldModel.dummy[(Random().nextInt(3))],
      threshold: 1,
      thresholdDate: DateTime.now(),
      repeat: true,
      asset: AssetModel.dummy[Random().nextInt(3)],
      assetsModel: AssetsModel.dummy[Random().nextInt(3)],
      catergory: CategoryModel.dummy[Random().nextInt(2)],
      instructionModels: InstructionModel.dummy,
      total: 30,
      showBeforeModel: ShowBeforeModel.dummy[Random().nextInt(14)],
      typeOverDue: 3,
    ),
    MaintenanceItemModel(
      maintenanceId: "id_0004",
      activity: "tune up",
      dateTime: DateTime.now(),
      priority: PriorityModel.dummy[Random().nextInt(3)],
      threshHoldModel: ThreshHoldModel.dummy[(Random().nextInt(3))],
      threshold: 1,
      thresholdDate: DateTime.now(),
      repeat: true,
      asset: AssetModel.dummy[Random().nextInt(3)],
      assetsModel: AssetsModel.dummy[Random().nextInt(3)],
      catergory: CategoryModel.dummy[Random().nextInt(2)],
      instructionModels: InstructionModel.dummy,
      total: 30,
      showBeforeModel: ShowBeforeModel.dummy[Random().nextInt(14)],
      typeOverDue: 3,
    ),
  ];
}

class PriorityModel {
  int id;
  String name;
  PriorityModel({
    this.id,
    this.name,
  });

  static List<PriorityModel> dummy = [
    PriorityModel(id: 1, name: System.data.resource.low),
    PriorityModel(id: 2, name: System.data.resource.medium),
    PriorityModel(id: 3, name: System.data.resource.high),
  ];
}

class AssetModel {
  int id;
  String name;
  AssetModel({this.id, this.name});

  static List<AssetModel> dummy = [
    AssetModel(id: 1, name: System.data.resource.vehicles),
    AssetModel(id: 2, name: System.data.resource.land),
    AssetModel(id: 3, name: System.data.resource.build),
  ];
}

class AssetsModel {
  int id;
  String name;
  AssetsModel({this.id, this.name});

  static List<AssetsModel> dummy = [
    AssetsModel(id: 1, name: "b 1234 fc"),
    AssetsModel(id: 2, name: "b 321 cf"),
    AssetsModel(id: 3, name: "b 213 cc"),
  ];
}

class ThreshHoldModel {
  int maintenanceItemId; // 1 date 2 hour 3 distance
  String name;
  String path;
  ThreshHoldModel({this.maintenanceItemId, this.name, this.path});

  static List<ThreshHoldModel> dummy = [
    ThreshHoldModel(
      maintenanceItemId: 1,
      name: System.data.resource.date,
      path: "assets/tms/icon_times.svg",
    ),
    ThreshHoldModel(
      maintenanceItemId: 2,
      name: System.data.resource.engineHour,
      path: "assets/tms/icon_times.svg",
    ),
    ThreshHoldModel(
      maintenanceItemId: 3,
      name: System.data.resource.distance,
      path: "assets/tms/icon_maps.svg",
    ),
  ];
}

class CategoryModel {
  int id;
  String name;
  CategoryModel({this.id, this.name});

  static List<CategoryModel> dummy = [
    CategoryModel(id: 1, name: "perawatan"),
    CategoryModel(id: 2, name: "pemeliharaan"),
  ];
}

class InstructionModel {
  int id;
  String name;
  bool status;

  InstructionModel({this.id, this.name, this.status});

  static List<InstructionModel> dummy = [
    InstructionModel(
      id: 1,
      name: "cek pengapian",
      status: true,
    ),
    InstructionModel(
      id: 2,
      name: "cek kelistrikan",
      status: false,
    ),
    InstructionModel(
      id: 3,
      name: "cek kaki kaki",
      status: false,
    ),
    InstructionModel(
      id: 1,
      name: "cek pengapian",
      status: true,
    ),
    InstructionModel(
      id: 2,
      name: "cek kelistrikan",
      status: false,
    ),
    InstructionModel(
      id: 3,
      name: "cek kaki kaki",
      status: false,
    ),
  ];
}

class ShowBeforeModel {
  int id;
  String name;
  bool status;
  int typeThreshold;

  ShowBeforeModel({this.id, this.name, this.status, this.typeThreshold = 1});

  static List<ShowBeforeModel> dummy = [
    ShowBeforeModel(id: 1, name: "1", status: true, typeThreshold: 1),
    ShowBeforeModel(id: 2, name: "2", status: false, typeThreshold: 1),
    ShowBeforeModel(id: 3, name: "3", status: false, typeThreshold: 1),
    ShowBeforeModel(id: 4, name: "4", status: false, typeThreshold: 1),
    ShowBeforeModel(id: 1, name: "100", status: true, typeThreshold: 3),
    ShowBeforeModel(id: 2, name: "200", status: false, typeThreshold: 3),
    ShowBeforeModel(id: 3, name: "300", status: false, typeThreshold: 3),
    ShowBeforeModel(id: 4, name: "400", status: false, typeThreshold: 3),
    ShowBeforeModel(id: 5, name: "500", status: false, typeThreshold: 3),
    ShowBeforeModel(id: 1, name: "10", status: true, typeThreshold: 2),
    ShowBeforeModel(id: 2, name: "20", status: false, typeThreshold: 2),
    ShowBeforeModel(id: 3, name: "30", status: false, typeThreshold: 2),
    ShowBeforeModel(id: 4, name: "40", status: false, typeThreshold: 2),
    ShowBeforeModel(id: 5, name: "50", status: false, typeThreshold: 2),
    ShowBeforeModel(id: 6, name: "60", status: false, typeThreshold: 2),
  ];
}
