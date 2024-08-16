import 'dart:convert';
import 'dart:io';

import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';

class SieradShipmentDetailHatcheryModel {
  int poultryShipmentId;
  int tmsShipmentId;
  int memberId;
  String axTransferId;
  String transferTypeCode;
  String transferTypeName;
  String hatcheryCodeOrigin;
  String hatcheryNameOrigin;
  String hatcheryCodeDestination;
  String hatcheryNameDestination;
  String farmCodeOrigin;
  String farmNameOrigin;
  String farmCodeDestination;
  String farmNameDestination;
  String poultryTypeCode;
  String poultryTypeName;
  String poultryStrainCode;
  String poultryStrainName;
  int orderQty;
  int bonusQty;
  int trayQty;
  String trayCode;
  String trayName;
  String basketCode;
  String basketName;
  String basketType;
  String basketColor;
  int basketQty;
  int deliveryQty;
  int deliveryBonusQty;
  int deliveryTrayQty;
  int deliveryBasketQty;
  String transporterCode;
  String transporterName;
  int serviceTime;
  int status;
  int tripNo;
  String customerNo;
  String customerName;
  String docGradeCode;
  String docGradeName;
  String docVaccineCode;
  String docVaccineName;
  String docHatchbrood;
  int deliveryLiveBird;
  int deliveryLiveBirdDead;

  SieradShipmentDetailHatcheryModel({
    this.poultryShipmentId,
    this.tmsShipmentId,
    this.memberId,
    this.axTransferId,
    this.transferTypeCode,
    this.transferTypeName,
    this.hatcheryCodeOrigin,
    this.hatcheryNameOrigin,
    this.hatcheryCodeDestination,
    this.hatcheryNameDestination,
    this.farmCodeOrigin,
    this.farmNameOrigin,
    this.farmCodeDestination,
    this.farmNameDestination,
    this.poultryTypeCode,
    this.poultryTypeName,
    this.poultryStrainCode,
    this.poultryStrainName,
    this.orderQty,
    this.bonusQty,
    this.trayQty,
    this.trayCode,
    this.trayName,
    this.basketCode,
    this.basketName,
    this.basketType,
    this.basketColor,
    this.basketQty,
    this.deliveryQty,
    this.deliveryBonusQty,
    this.deliveryTrayQty,
    this.deliveryBasketQty,
    this.transporterCode,
    this.transporterName,
    this.serviceTime,
    this.status,
    this.tripNo,
    this.customerNo,
    this.customerName,
    this.docGradeCode,
    this.docGradeName,
    this.docVaccineCode,
    this.docVaccineName,
    this.docHatchbrood,
    this.deliveryLiveBird,
    this.deliveryLiveBirdDead,
  });

  factory SieradShipmentDetailHatcheryModel.fromJson(
      Map<String, dynamic> json) {
    if (json == null) return null;
    return SieradShipmentDetailHatcheryModel(
      poultryShipmentId: json["poultryShipmentId"],
      tmsShipmentId: json["tmsShipmentId"],
      memberId: json["memberId"],
      axTransferId: json["axTransferId"],
      transferTypeCode: json["transferTypeCode"],
      transferTypeName: json["transferTypeName"],
      hatcheryCodeOrigin: json["hatcheryCodeOrigin"],
      hatcheryNameOrigin: json["hatcheryNameOrigin"],
      hatcheryCodeDestination: json["hatcheryCodeDestination"],
      hatcheryNameDestination: json["hatcheryNameDestination"],
      farmCodeOrigin: json["farmCodeOrigin"],
      farmNameOrigin: json["farmNameOrigin"],
      farmCodeDestination: json["farmCodeDestination"],
      farmNameDestination: json["farmNameDestination"],
      poultryTypeCode: json["poultryTypeCode"],
      poultryTypeName: json["poultryTypeName"],
      poultryStrainCode: json["poultryStrainCode"],
      poultryStrainName: json["poultryStrainName"],
      orderQty: json["orderQty"],
      bonusQty: json["bonusQty"],
      trayQty: json["trayQty"],
      trayCode: json["trayCode"],
      trayName: json["trayName"],
      basketCode: json["basketCode"],
      basketName: json["basketName"],
      basketType: json["basketType"],
      basketColor: json["basketColor"],
      basketQty: json["basketQty"],
      deliveryQty: json["deliveryQty"],
      deliveryBonusQty: json["deliveryBonusQty"],
      deliveryTrayQty: json["deliveryTrayQty"],
      deliveryBasketQty: json["deliveryBasketQty"],
      transporterCode: json["transporterCode"],
      transporterName: json["transporterName"],
      serviceTime: json["serviceTime"],
      status: json["status"],
      tripNo: json["tripNo"],
      customerNo: json["customerNo"],
      customerName: json["customerName"],
      docGradeCode: json["docGradeCode"],
      docGradeName: json["docGradeName"],
      docVaccineCode: json["docVaccineCode"],
      docVaccineName: json["docVaccineName"],
      docHatchbrood: json["docHatchbrood"],
      deliveryLiveBird: json["deliveryLiveBird"] as int,
      deliveryLiveBirdDead: json["deliveryLiveBirdDead"] as int,
    );
  }

  static Future<List<TmsShipmentModel<SieradShipmentDetailHatcheryModel>>>
      getAll({
    String token,
    int limit,
    int shipmentId,
    bool withRoute,
    bool isLowerThanId,
    int destinationId,
    String searchKey,
  }) {
    return get(
        token: token,
        url: getAllSieradShipmentDetailHatchery(
          shipmentId: shipmentId,
          dataLimit: limit,
          withRoute: withRoute,
          isLowerThanId: isLowerThanId,
          destinationId: destinationId,
          searchKey: searchKey,
        ));
  }

  static Future<List<TmsShipmentModel<SieradShipmentDetailHatcheryModel>>>
      getOpened({
    String token,
    int limit,
    int shipmentId,
    bool withRoute,
    bool isLowerThanId,
    int destinationId,
    String searchKey,
  }) {
    return get(
        token: token,
        url: getOpenedSieradShipmentDetailHatchery(
          shipmentId: shipmentId,
          dataLimit: limit,
          isLowerThanId: withRoute,
          descparam: isLowerThanId,
          destinationId: destinationId,
          searchKey: searchKey,
        ));
  }

  static Future<List<TmsShipmentModel<SieradShipmentDetailHatcheryModel>>>
      getProcessed({
    String token,
    int limit,
    int shipmentId,
    bool withRoute,
    bool isLowerThanId,
    int destinationId,
    String searchKey,
  }) {
    return get(
        token: token,
        url: getProcsessedSieradShipmentDetailHatchery(
          shipmentId: shipmentId,
          dataLimit: limit,
          isLowerThanId: withRoute,
          descparam: isLowerThanId,
          destinationId: destinationId,
          searchKey: searchKey,
        ));
  }

  static Future<List<TmsShipmentModel<SieradShipmentDetailHatcheryModel>>>
      getFinish({
    String token,
    int limit,
    int shipmentId,
    bool withRoute,
    bool isLowerThanId,
    int destinationId,
    String searchKey,
  }) {
    return get(
        token: token,
        url: getFinishedSieradShipmentDetailHatchery(
          shipmentId: shipmentId,
          dataLimit: limit,
          isLowerThanId: withRoute,
          descparam: isLowerThanId,
          destinationId: destinationId,
          searchKey: searchKey,
        ));
  }

  static Future<List<TmsShipmentModel<SieradShipmentDetailHatcheryModel>>>
      getCancel({
    String token,
    int limit,
    int shipmentId,
    bool withRoute,
    bool isLowerThanId,
    int destinationId,
    String searchKey,
  }) {
    return get(
        token: token,
        url: getCanceledSieradShipmentDetailHatchery(
          shipmentId: shipmentId,
          dataLimit: limit,
          isLowerThanId: withRoute,
          descparam: isLowerThanId,
          destinationId: destinationId,
          searchKey: searchKey,
        ));
  }

  static Future<List<TmsShipmentModel<SieradShipmentDetailHatcheryModel>>>
      getShipped({
    String token,
    int limit,
    int shipmentId,
    bool withRoute,
    bool isLowerThanId,
    int destinationId,
    String searchKey,
  }) {
    return get(
        token: token,
        url: getCanceledSieradShipmentDetailHatchery(
          shipmentId: shipmentId,
          dataLimit: limit,
          isLowerThanId: withRoute,
          descparam: isLowerThanId,
          destinationId: destinationId,
          searchKey: searchKey,
        ));
  }

  static Future<List<TmsShipmentModel<SieradShipmentDetailHatcheryModel>>> get({
    String token,
    String url,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.post(url, headers: {
      "lang": "${System.data.resource.lang}",
      HttpHeaders.authorizationHeader: "bearer $token",
      HttpHeaders.contentTypeHeader: "application/json",
    }).then((onValue) {
      return ((json.decode(onValue.toString())) as List)
          .map(
            (f) => TmsShipmentModel.fromJson<SieradShipmentDetailHatcheryModel>(
              f,
              childReader: (data) =>
                  SieradShipmentDetailHatcheryModel.fromJson(data),
            ),
          )
          .toList();
    }).catchError((onError) {
      throw onError;
    });
  }

  static getAllSieradShipmentDetailHatchery({
    int shipmentId,
    int dataLimit,
    bool withRoute,
    bool isLowerThanId,
    int destinationId,
    String searchKey,
  }) {
    return System.data.apiEndPointUtil.url +
        "Shipment/getAllShipment?shipmentId=${shipmentId ?? ""}&datalimit=${dataLimit ?? ""}&withRoute=${withRoute ?? false}&isLowerThanId=${isLowerThanId ?? true}&destinationId=${destinationId ?? ""}&searchKey=${searchKey ?? ""}";
  }

  static getOpenedSieradShipmentDetailHatchery({
    int shipmentId,
    int dataLimit,
    bool isLowerThanId,
    bool descparam,
    int destinationId,
    String searchKey,
  }) {
    return System.data.apiEndPointUtil.url +
        "Shipment/getOpenedShipment?shipmentId=${shipmentId ?? ""}&datalimit=${dataLimit ?? ""}&withRoute=${isLowerThanId ?? false}&isLowerThanId=${descparam ?? true}&destinationId=${destinationId ?? ""}&searchKey=${searchKey ?? ""}";
  }

  static getProcsessedSieradShipmentDetailHatchery({
    int shipmentId,
    int dataLimit,
    bool isLowerThanId,
    bool descparam,
    int destinationId,
    String searchKey,
  }) {
    return System.data.apiEndPointUtil.url +
        "Shipment/getProcessedShipment?shipmentId=${shipmentId ?? ""}&datalimit=${dataLimit ?? ""}&withRoute=${isLowerThanId ?? false}&isLowerThanId=${descparam ?? true}&destinationId=${destinationId ?? ""}&searchKey=${searchKey ?? ""}";
  }

  static getFinishedSieradShipmentDetailHatchery({
    int shipmentId,
    int dataLimit,
    bool isLowerThanId,
    bool descparam,
    int destinationId,
    String searchKey,
  }) {
    return System.data.apiEndPointUtil.url +
        "Shipment/getFinishedShipment?shipmentId=${shipmentId ?? ""}&datalimit=${dataLimit ?? ""}&withRoute=${isLowerThanId ?? false}&isLowerThanId=${descparam ?? true}&destinationId=${destinationId ?? ""}&searchKey=${searchKey ?? ""}";
  }

  static getCanceledSieradShipmentDetailHatchery({
    int shipmentId,
    int dataLimit,
    bool isLowerThanId,
    bool descparam,
    int destinationId,
    String searchKey,
  }) {
    return System.data.apiEndPointUtil.url +
        "Shipment/getCanceledShipment?shipmentId=${shipmentId ?? ""}&datalimit=${dataLimit ?? ""}&withRoute=${isLowerThanId ?? false}&isLowerThanId=${descparam ?? true}&destinationId=${destinationId ?? ""}&searchKey=${searchKey ?? ""}";
  }
}
