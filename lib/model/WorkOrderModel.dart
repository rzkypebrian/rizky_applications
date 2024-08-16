import 'dart:math';
import 'package:enerren/model/MaintenanceScheduleModel.dart';
import 'package:enerren/model/StockModel.dart';

class WorkOrderModel {
  String workOrderId;
  VendorModel vendorModel;
  PersonInChargeModel personInChargeModel;
  List<MaintenanceScheduleModel> listMaintenanceScheduleModel;
  String noteForVendor;
  String obstacles;
  int typeWorkOrder; // 1 new 2 process 3 finish 4 delay
  StockModel stock;

  WorkOrderModel({
    this.workOrderId,
    this.vendorModel,
    this.personInChargeModel,
    this.listMaintenanceScheduleModel,
    this.noteForVendor,
    this.typeWorkOrder = 1,
    this.stock,
    this.obstacles,
  });

  int get totalActitity => listMaintenanceScheduleModel.length;

  static List<WorkOrderModel> dummy = [
    WorkOrderModel(
      workOrderId: "woi xxxx 1",
      vendorModel:
          VendorModel.dummy[Random().nextInt(VendorModel.dummy.length)],
      personInChargeModel: PersonInChargeModel
          .dummy[Random().nextInt(PersonInChargeModel.dummy.length)],
      listMaintenanceScheduleModel: MaintenanceScheduleModel.dummy,
      noteForVendor: "Tungguin saat pemasangan",
      stock: StockModel.dummy[Random().nextInt(StockModel.dummy.length)],
    ),
    WorkOrderModel(
      workOrderId: "woi xxxx 1",
      vendorModel:
          VendorModel.dummy[Random().nextInt(VendorModel.dummy.length)],
      personInChargeModel: PersonInChargeModel
          .dummy[Random().nextInt(PersonInChargeModel.dummy.length)],
      listMaintenanceScheduleModel: MaintenanceScheduleModel.dummy,
      noteForVendor: "Tungguin saat pemasangan",
      stock: StockModel.dummy[Random().nextInt(StockModel.dummy.length)],
    ),
    WorkOrderModel(
      workOrderId: "woi xxxx 1",
      vendorModel:
          VendorModel.dummy[Random().nextInt(VendorModel.dummy.length)],
      personInChargeModel: PersonInChargeModel
          .dummy[Random().nextInt(PersonInChargeModel.dummy.length)],
      listMaintenanceScheduleModel: MaintenanceScheduleModel.dummy,
      noteForVendor: "Tungguin saat pemasangan",
      stock: StockModel.dummy[Random().nextInt(StockModel.dummy.length)],
    ),
    WorkOrderModel(
      workOrderId: "woi xxxx 1",
      vendorModel:
          VendorModel.dummy[Random().nextInt(VendorModel.dummy.length)],
      personInChargeModel: PersonInChargeModel
          .dummy[Random().nextInt(PersonInChargeModel.dummy.length)],
      listMaintenanceScheduleModel: MaintenanceScheduleModel.dummy,
      noteForVendor: "Tungguin saat pemasangan",
      stock: StockModel.dummy[Random().nextInt(StockModel.dummy.length)],
    ),
    WorkOrderModel(
      workOrderId: "woi xxxx 2",
      vendorModel:
          VendorModel.dummy[Random().nextInt(VendorModel.dummy.length)],
      personInChargeModel: PersonInChargeModel
          .dummy[Random().nextInt(PersonInChargeModel.dummy.length)],
      listMaintenanceScheduleModel: MaintenanceScheduleModel.dummy,
      noteForVendor: "Tungguin saat pemasangan",
      stock: StockModel.dummy[Random().nextInt(StockModel.dummy.length)],
      typeWorkOrder: 2,
    ),
    WorkOrderModel(
      workOrderId: "woi xxxx 3",
      vendorModel:
          VendorModel.dummy[Random().nextInt(VendorModel.dummy.length)],
      personInChargeModel: PersonInChargeModel
          .dummy[Random().nextInt(PersonInChargeModel.dummy.length)],
      listMaintenanceScheduleModel: MaintenanceScheduleModel.dummy,
      noteForVendor: "Tungguin saat pemasangan",
      stock: StockModel.dummy[Random().nextInt(StockModel.dummy.length)],
      typeWorkOrder: 2,
    ),
    WorkOrderModel(
      workOrderId: "woi xxxx 2",
      vendorModel:
          VendorModel.dummy[Random().nextInt(VendorModel.dummy.length)],
      personInChargeModel: PersonInChargeModel
          .dummy[Random().nextInt(PersonInChargeModel.dummy.length)],
      listMaintenanceScheduleModel: MaintenanceScheduleModel.dummy,
      noteForVendor: "Tungguin saat pemasangan",
      stock: StockModel.dummy[Random().nextInt(StockModel.dummy.length)],
      typeWorkOrder: 2,
    ),
    WorkOrderModel(
      workOrderId: "woi xxxx 3",
      vendorModel:
          VendorModel.dummy[Random().nextInt(VendorModel.dummy.length)],
      personInChargeModel: PersonInChargeModel
          .dummy[Random().nextInt(PersonInChargeModel.dummy.length)],
      listMaintenanceScheduleModel: MaintenanceScheduleModel.dummy,
      noteForVendor: "Tungguin saat pemasangan",
      stock: StockModel.dummy[Random().nextInt(StockModel.dummy.length)],
      typeWorkOrder: 2,
    ),
    WorkOrderModel(
      workOrderId: "woi xxxx 2",
      vendorModel:
          VendorModel.dummy[Random().nextInt(VendorModel.dummy.length)],
      personInChargeModel: PersonInChargeModel
          .dummy[Random().nextInt(PersonInChargeModel.dummy.length)],
      listMaintenanceScheduleModel: MaintenanceScheduleModel.dummy,
      noteForVendor: "Tungguin saat pemasangan",
      stock: StockModel.dummy[Random().nextInt(StockModel.dummy.length)],
      typeWorkOrder: 3,
    ),
    WorkOrderModel(
      workOrderId: "woi xxxx 3",
      vendorModel:
          VendorModel.dummy[Random().nextInt(VendorModel.dummy.length)],
      personInChargeModel: PersonInChargeModel
          .dummy[Random().nextInt(PersonInChargeModel.dummy.length)],
      listMaintenanceScheduleModel: MaintenanceScheduleModel.dummy,
      noteForVendor: "Tungguin saat pemasangan",
      stock: StockModel.dummy[Random().nextInt(StockModel.dummy.length)],
      typeWorkOrder: 3,
    ),
    WorkOrderModel(
      workOrderId: "woi xxxx 2",
      vendorModel:
          VendorModel.dummy[Random().nextInt(VendorModel.dummy.length)],
      personInChargeModel: PersonInChargeModel
          .dummy[Random().nextInt(PersonInChargeModel.dummy.length)],
      listMaintenanceScheduleModel: MaintenanceScheduleModel.dummy,
      noteForVendor: "Tungguin saat pemasangan",
      stock: StockModel.dummy[Random().nextInt(StockModel.dummy.length)],
      typeWorkOrder: 3,
    ),
    WorkOrderModel(
      workOrderId: "woi xxxx 3",
      vendorModel:
          VendorModel.dummy[Random().nextInt(VendorModel.dummy.length)],
      personInChargeModel: PersonInChargeModel
          .dummy[Random().nextInt(PersonInChargeModel.dummy.length)],
      listMaintenanceScheduleModel: MaintenanceScheduleModel.dummy,
      noteForVendor: "Tungguin saat pemasangan",
      stock: StockModel.dummy[Random().nextInt(StockModel.dummy.length)],
      typeWorkOrder: 3,
    ),
    WorkOrderModel(
      workOrderId: "woi xxxx 2",
      vendorModel:
          VendorModel.dummy[Random().nextInt(VendorModel.dummy.length)],
      personInChargeModel: PersonInChargeModel
          .dummy[Random().nextInt(PersonInChargeModel.dummy.length)],
      listMaintenanceScheduleModel: MaintenanceScheduleModel.dummy,
      noteForVendor: "Tungguin saat pemasangan",
      stock: StockModel.dummy[Random().nextInt(StockModel.dummy.length)],
      typeWorkOrder: 4,
    ),
    WorkOrderModel(
      workOrderId: "woi xxxx 3",
      vendorModel:
          VendorModel.dummy[Random().nextInt(VendorModel.dummy.length)],
      personInChargeModel: PersonInChargeModel
          .dummy[Random().nextInt(PersonInChargeModel.dummy.length)],
      listMaintenanceScheduleModel: MaintenanceScheduleModel.dummy,
      noteForVendor: "Tungguin saat pemasangan",
      stock: StockModel.dummy[Random().nextInt(StockModel.dummy.length)],
      typeWorkOrder: 4,
    ),
    WorkOrderModel(
      workOrderId: "woi xxxx 2",
      vendorModel:
          VendorModel.dummy[Random().nextInt(VendorModel.dummy.length)],
      personInChargeModel: PersonInChargeModel
          .dummy[Random().nextInt(PersonInChargeModel.dummy.length)],
      listMaintenanceScheduleModel: MaintenanceScheduleModel.dummy,
      noteForVendor: "Tungguin saat pemasangan",
      stock: StockModel.dummy[Random().nextInt(StockModel.dummy.length)],
      typeWorkOrder: 4,
    ),
    WorkOrderModel(
      workOrderId: "woi xxxx 3",
      vendorModel:
          VendorModel.dummy[Random().nextInt(VendorModel.dummy.length)],
      personInChargeModel: PersonInChargeModel
          .dummy[Random().nextInt(PersonInChargeModel.dummy.length)],
      listMaintenanceScheduleModel: MaintenanceScheduleModel.dummy,
      noteForVendor: "Tungguin saat pemasangan",
      stock: StockModel.dummy[Random().nextInt(StockModel.dummy.length)],
      typeWorkOrder: 4,
    ),
    WorkOrderModel(
      workOrderId: "woi xxxx 2",
      vendorModel:
          VendorModel.dummy[Random().nextInt(VendorModel.dummy.length)],
      personInChargeModel: PersonInChargeModel
          .dummy[Random().nextInt(PersonInChargeModel.dummy.length)],
      listMaintenanceScheduleModel: MaintenanceScheduleModel.dummy,
      noteForVendor: "Tungguin saat pemasangan",
      stock: StockModel.dummy[Random().nextInt(StockModel.dummy.length)],
    ),
    WorkOrderModel(
      workOrderId: "woi xxxx 3",
      vendorModel:
          VendorModel.dummy[Random().nextInt(VendorModel.dummy.length)],
      personInChargeModel: PersonInChargeModel
          .dummy[Random().nextInt(PersonInChargeModel.dummy.length)],
      listMaintenanceScheduleModel: MaintenanceScheduleModel.dummy,
      noteForVendor: "Tungguin saat pemasangan",
      stock: StockModel.dummy[Random().nextInt(StockModel.dummy.length)],
      typeWorkOrder: 2,
    ),
    WorkOrderModel(
      workOrderId: "woi xxxx 2",
      vendorModel:
          VendorModel.dummy[Random().nextInt(VendorModel.dummy.length)],
      personInChargeModel: PersonInChargeModel
          .dummy[Random().nextInt(PersonInChargeModel.dummy.length)],
      listMaintenanceScheduleModel: MaintenanceScheduleModel.dummy,
      noteForVendor: "Tungguin saat pemasangan",
      stock: StockModel.dummy[Random().nextInt(StockModel.dummy.length)],
      typeWorkOrder: 3,
    ),
    WorkOrderModel(
      workOrderId: "woi xxxx 3",
      vendorModel:
          VendorModel.dummy[Random().nextInt(VendorModel.dummy.length)],
      personInChargeModel: PersonInChargeModel
          .dummy[Random().nextInt(PersonInChargeModel.dummy.length)],
      listMaintenanceScheduleModel: MaintenanceScheduleModel.dummy,
      noteForVendor: "Tungguin saat pemasangan",
      stock: StockModel.dummy[Random().nextInt(StockModel.dummy.length)],
      typeWorkOrder: 4,
    ),
  ];
}

class PersonInChargeModel {
  int id;
  String name;
  String address;
  String phoneNumber;
  String email;
  String image;
  bool status;

  PersonInChargeModel({
    this.id,
    this.name,
    this.address,
    this.phoneNumber,
    this.email,
    this.image,
    this.status = true,
  });

  static List<PersonInChargeModel> dummy = [
    PersonInChargeModel(
      id: 1,
      name: "Person In Charge  1",
      address:
          "Jalan Margonda Raya, Kelurahan Pondok Cina,Kecamatan Beji, Kota Depok,Propinsi Jawa Barat",
      phoneNumber: "0821",
      email: "personincharge@mail.com",
      image: "https://freepngimg.com/thumb/man/22654-6-man.png",
    ),
    PersonInChargeModel(
      id: 2,
      name: "Person In Charge  2",
      address:
          "Jalan Margonda Raya, Kelurahan Pondok Cina,Kecamatan Beji, Kota Depok,Propinsi Jawa Barat",
      phoneNumber: "0821",
      email: "personincharge@mail.com",
    ),
    PersonInChargeModel(
        id: 3,
        name: "Person In Charge  3",
        address:
            "Jalan Margonda Raya, Kelurahan Pondok Cina,Kecamatan Beji, Kota Depok,Propinsi Jawa Barat",
        phoneNumber: "0821",
        email: "personincharge@mail.com",
        image: "https://freepngimg.com/thumb/man/22654-6-man.png",
        status: false),
    PersonInChargeModel(
      id: 4,
      name: "Person In Charge  4",
      address:
          "Jalan Margonda Raya, Kelurahan Pondok Cina,Kecamatan Beji, Kota Depok,Propinsi Jawa Barat",
      phoneNumber: "0821",
      email: "personincharge@mail.com",
    ),
    PersonInChargeModel(
      id: 5,
      name: "Person In Charge  5",
      address:
          "Jalan Margonda Raya, Kelurahan Pondok Cina,Kecamatan Beji, Kota Depok,Propinsi Jawa Barat",
      phoneNumber: "0821",
      email: "personincharge@mail.com",
      image: "https://freepngimg.com/thumb/man/22654-6-man.png",
    ),
    PersonInChargeModel(
      id: 6,
      name: "Person In Charge  6",
      address:
          "Jalan Margonda Raya, Kelurahan Pondok Cina,Kecamatan Beji, Kota Depok,Propinsi Jawa Barat",
      phoneNumber: "0821",
      email: "personincharge@mail.com",
      image: "https://freepngimg.com/thumb/man/22654-6-man.png",
    ),
    PersonInChargeModel(
      id: 7,
      name: "Person In Charge  7",
      address:
          "Jalan Margonda Raya, Kelurahan Pondok Cina,Kecamatan Beji, Kota Depok,Propinsi Jawa Barat",
      phoneNumber: "0821",
      email: "personincharge@mail.com",
      image: "https://freepngimg.com/thumb/man/22654-6-man.png",
    ),
    PersonInChargeModel(
      id: 8,
      name: "Person In Charge  8",
      address:
          "Jalan Margonda Raya, Kelurahan Pondok Cina,Kecamatan Beji, Kota Depok,Propinsi Jawa Barat",
      phoneNumber: "0821",
      email: "personincharge@mail.com",
      image: "https://freepngimg.com/thumb/man/22654-6-man.png",
    ),
  ];
}

class VendorModel {
  int id;
  String name;
  String address;
  String phoneNumber;
  String email;
  String workerDay;
  String workerTime;
  String image;
  VendorModel(
      {this.id,
      this.name,
      this.address,
      this.phoneNumber,
      this.email,
      this.workerDay,
      this.workerTime,
      this.image});

  static List<VendorModel> dummy = [
    VendorModel(
      id: 1,
      name: "vendor 1",
      address:
          "Jalan Margonda Raya, Kelurahan Pondok Cina,Kecamatan Beji, Kota Depok,Propinsi Jawa Barat",
      phoneNumber: "0821",
      email: "vendor@mail.com",
      workerDay: "senin - sabtu",
      workerTime: "08:00-16:00",
      image: "https://freepngimg.com/thumb/man/22654-6-man.png",
    ),
    VendorModel(
      id: 2,
      name: "vendor 2",
      address:
          "Jalan Margonda Raya, Kelurahan Pondok Cina,Kecamatan Beji, Kota Depok,Propinsi Jawa Barat",
      phoneNumber: "0821",
      email: "vendor@mail.com",
      workerDay: "senin - sabtu",
      workerTime: "08:00-16:00",
      image: "https://freepngimg.com/thumb/man/22654-6-man.png",
    ),
    VendorModel(
      id: 3,
      name: "vendor 3",
      address:
          "Jalan Margonda Raya, Kelurahan Pondok Cina,Kecamatan Beji, Kota Depok,Propinsi Jawa Barat",
      phoneNumber: "0821",
      email: "vendor@mail.com",
      workerDay: "senin - sabtu",
      workerTime: "08:00-16:00",
      image: "https://freepngimg.com/thumb/man/22654-6-man.png",
    ),
    VendorModel(
      id: 4,
      name: "vendor 4",
      address:
          "Jalan Margonda Raya, Kelurahan Pondok Cina,Kecamatan Beji, Kota Depok,Propinsi Jawa Barat",
      phoneNumber: "0821",
      email: "vendor@mail.com",
      workerDay: "senin - sabtu",
      workerTime: "08:00-16:00",
      image: "https://freepngimg.com/thumb/man/22654-6-man.png",
    ),
    VendorModel(
      id: 5,
      name: "vendor 5",
      address:
          "Jalan Margonda Raya, Kelurahan Pondok Cina,Kecamatan Beji, Kota Depok,Propinsi Jawa Barat",
      phoneNumber: "0821",
      email: "vendor@mail.com",
      workerDay: "senin - sabtu",
      workerTime: "08:00-16:00",
      image: "https://freepngimg.com/thumb/man/22654-6-man.png",
    ),
    VendorModel(
      id: 6,
      name: "vendor 6",
      address:
          "Jalan Margonda Raya, Kelurahan Pondok Cina,Kecamatan Beji, Kota Depok,Propinsi Jawa Barat",
      phoneNumber: "0821",
      email: "vendor@mail.com",
      workerDay: "senin - sabtu",
      workerTime: "08:00-16:00",
      image: "https://freepngimg.com/thumb/man/22654-6-man.png",
    ),
    VendorModel(
      id: 7,
      name: "vendor 7",
      address:
          "Jalan Margonda Raya, Kelurahan Pondok Cina,Kecamatan Beji, Kota Depok,Propinsi Jawa Barat",
      phoneNumber: "0821",
      email: "vendor@mail.com",
      workerDay: "senin - sabtu",
      workerTime: "08:00-16:00",
      image: "https://freepngimg.com/thumb/man/22654-6-man.png",
    ),
    VendorModel(
      id: 8,
      name: "vendor 8",
      address:
          "Jalan Margonda Raya, Kelurahan Pondok Cina,Kecamatan Beji, Kota Depok,Propinsi Jawa Barat",
      phoneNumber: "0821",
      email: "vendor@mail.com",
      workerDay: "senin - sabtu",
      workerTime: "08:00-16:00",
      image: "https://freepngimg.com/thumb/man/22654-6-man.png",
    ),
  ];
}
