import 'dart:convert';
import 'dart:io';

import 'package:enerren/app/angkut/model/AngkutCreateOrderModel.dart';
import 'package:enerren/app/angkut/model/AngkutInvoiceModel.dart';
import 'package:enerren/model/DriverRatingModel.dart';
import 'package:enerren/model/tmsShipmentDestinationModel.dart';
import 'package:enerren/model/tmsShipmentHistory.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'AngkutInvoiceItem.dart';
import 'AngkutShipmentTypeModel.dart';
part 'AngkutShipmentModel.g.dart';

@JsonSerializable(explicitToJson: true)
class AngkutShipmentModel {
  double mileage;
  int tmsShipmentId;
  String shipmentNumber;
  DateTime shipmentDate;
  int vtsShipmentId;
  int vehicleTypeId;
  String vehicleTypeName;
  int customerId;
  String customerName;
  String customerImageUrl;
  DateTime beginDatetime;
  DateTime completeDatetime;
  int shipmentStatusId;
  String shipmentStatusName;
  String deliveryDescription;
  bool isDeleted;
  String iconUrl;
  int shipmentTypeId;
  DateTime scheduledDate;
  bool isInstant;
  bool extraHelper;
  int extraHelperCount;
  double extraHelperAmount;
  String deliveryNo;
  double basicPrice;
  double basicPriceAfterDiscount;
  double subtotal;
  int discountId;
  String discountCode;
  double discountPersentage;
  double discountAmount;
  double totalPrice;
  double feeService;
  int insuranceId;
  String insuranceName;
  int insuranceTypeId;
  String insuranceTypeName;
  int premiId;
  String premiName;
  String insuranceCode;
  int insuranceFormulaId;
  String insuranceFormula;
  double insuranceAmount;
  String payerPhoneNo;
  String payerName;
  bool payed;
  bool needAcction;
  DateTime deadlineCancelledDatetime;
  double distanceToPickUp;
  DateTime arrivalEtaToPickUp;
  double distancePickupToDestination;
  AngkutInvoiceModel shipmentInvoice;
  List<AngkutInvoiceItem> shipmentInvoiceItem;
  bool isConfirmWaiting;
  // List<AngkutShipmentDestination> tmsShipmentDestinationList;
  double takeHomePayTransporter;
  double takeHomePayAngkut;
  double estimateGoodsPrice;
  double totalShipCost;
  int voucherId;
  String voucherCode;
  double voucherPersentage;
  double voucherAmount;
  String voucherErrorString;
  List<TmsShipmentHistory> tmsShipmentHistoryList;
  List<TmsShipmentDestinationModel> tmsShipmentDestinationList;
  List<TripAllowanceModel> shipmentItemTypeList;
  DriverRatingModel driverRating;

  AngkutShipmentModel({
    this.voucherId,
    this.voucherCode,
    this.voucherPersentage,
    this.voucherAmount,
    this.voucherErrorString,
    this.mileage = 0,
    this.needAcction = false,
    this.payed = false,
    this.deadlineCancelledDatetime,
    this.distanceToPickUp,
    this.arrivalEtaToPickUp,
    this.distancePickupToDestination,
    this.tmsShipmentId,
    this.shipmentNumber,
    this.shipmentDate,
    this.vtsShipmentId,
    this.vehicleTypeId,
    this.vehicleTypeName,
    this.customerId,
    this.customerName,
    this.customerImageUrl,
    this.beginDatetime,
    this.completeDatetime,
    this.shipmentStatusId,
    this.shipmentStatusName,
    this.deliveryDescription,
    this.isDeleted,
    this.iconUrl,
    this.shipmentTypeId,
    this.scheduledDate,
    this.isInstant,
    this.extraHelper,
    this.extraHelperAmount,
    this.deliveryNo,
    this.basicPrice,
    this.subtotal,
    this.discountId,
    this.discountCode,
    this.discountPersentage,
    this.discountAmount,
    this.totalPrice,
    this.feeService,
    this.insuranceId,
    this.insuranceName,
    this.insuranceTypeId,
    this.insuranceTypeName,
    this.premiId,
    this.premiName,
    this.insuranceCode,
    this.insuranceFormulaId,
    this.insuranceFormula,
    this.insuranceAmount,
    this.payerPhoneNo,
    this.payerName,
    this.shipmentInvoice,
    this.shipmentItemTypeList,
    this.isConfirmWaiting,
    this.shipmentInvoiceItem,
    this.takeHomePayTransporter,
    this.takeHomePayAngkut,
    this.estimateGoodsPrice,
    this.totalShipCost,
    this.tmsShipmentHistoryList,
    this.tmsShipmentDestinationList,
    this.extraHelperCount,
    this.basicPriceAfterDiscount,
    this.driverRating,
  });

  factory AngkutShipmentModel.fromJson(Map<String, dynamic> json) =>
      _$AngkutShipmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AngkutShipmentModelToJson(this);

  static Future<List<AngkutShipmentModel>> getAll({
    String token,
    int limit,
    bool withRoute,
    int shipmentId,
    bool isLowerThanId,
    int destinationId,
  }) {
    return get(
      token: token,
      url: System.data.apiEndPointUtil.getAllShipment(
        shipmentId: shipmentId,
        dataLimit: limit,
        withRoute: withRoute,
        isLowerThanId: isLowerThanId,
        destinationId: destinationId,
      ),
    );
  }

  static getProcessed({
    String token,
    int limit,
    bool withRoute,
    int shipmentId,
    bool isLowerThanId,
    int destinationId,
  }) {
    return get(
        token: token,
        url: System.data.apiEndPointUtil.getProcessShipment(
          shipmentId: shipmentId,
          dataLimit: limit,
          withRoute: withRoute,
          isLowerThanId: isLowerThanId,
          destinationId: destinationId,
        ));
  }

  static getOpened({
    String token,
    int limit,
    bool withRoute,
    int shipmentId,
    bool isLowerThanId,
    int destinationId,
  }) {
    return get(
        token: token,
        url: System.data.apiEndPointUtil.getOppenedShipment(
          shipmentId: shipmentId,
          dataLimit: limit,
          withRoute: withRoute,
          isLowerThanId: isLowerThanId,
          destinationId: destinationId,
        ));
  }

  static getFinish({
    String token,
    int limit,
    bool withRoute,
    int shipmentId,
    bool isLowerThanId,
    int destinationId,
  }) {
    return get(
        token: token,
        url: System.data.apiEndPointUtil.getFinishedShipment(
          shipmentId: shipmentId,
          dataLimit: limit,
          withRoute: withRoute,
          isLowerThanId: isLowerThanId,
          destinationId: destinationId,
        ));
  }

  static getShippedShipment({
    String token,
    int limit,
    bool withRoute,
    int shipmentId,
    bool isLowerThanId,
    int destinationId,
  }) {
    return get(
        token: token,
        url: System.data.apiEndPointUtil.getShippedShipment(
          shipmentId: shipmentId,
          dataLimit: limit,
          withRoute: withRoute,
          isLowerThanId: isLowerThanId,
          destinationId: destinationId,
        ));
  }

  static getCanceled({
    String token,
    int limit,
    bool withRoute,
    int shipmentId,
    bool isLowerThanId,
    int destinationId,
  }) {
    return get(
        token: token,
        url: System.data.apiEndPointUtil.getCaceledShipment(
          shipmentId: shipmentId,
          dataLimit: limit,
          withRoute: withRoute,
          isLowerThanId: isLowerThanId,
          destinationId: destinationId,
        ));
  }

  static getNotRated({
    String token,
  }) {
    return get(
      token: token,
      url: System.data.apiEndPointUtil.notYetRattedShipment(),
    );
  }

  static Future<AngkutShipmentModel> acceptShipment(
      {String token,
      int shipmentId,
      int vahicleId,
      int driverId,
      double vehicleLat,
      double vehicleLon,
      int vehicleOdometer}) {
    return post(
      token: token,
      url: System.data.apiEndPointUtil.getAcceptOrder(
        shipmentId: shipmentId,
        vehicleId: vahicleId,
        driverId: driverId,
        vehicleLat: vehicleLat,
        vehicleLon: vehicleLon,
        vehicleOdometer: vehicleOdometer,
      ),
    );
  }

  static Future<List<AngkutShipmentModel>> get({
    String token,
    String url,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.post(
      url,
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((onValue) {
      return ((json.decode(onValue.toString())) as List)
          .map(
            (f) => AngkutShipmentModel.fromJson(f),
          )
          .toList();
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<AngkutShipmentModel> post({
    String token,
    String url,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.post(url, headers: {
      "lang": "${System.data.resource.lang}",
      HttpHeaders.authorizationHeader: "bearer $token",
      HttpHeaders.contentTypeHeader: "application/json",
    }).then((onValue) {
      return AngkutShipmentModel.fromJson(json.decode(onValue));
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<AngkutShipmentModel> calculate({
    String token,
    AngkutCreateOrderModel createOrderModel,
  }) {
    return NetworkUtil()
        .post(
      System.data.apiEndPointUtil.getCalculatePriceOrder(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: createOrderModel.toJson(),
    )
        .then((onValue) {
      ModeUtil.debugPrint("masuk sini");
      try {
        return AngkutShipmentModel.fromJson(json.decode(onValue));
      } catch (e) {
        throw e;
      }
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  static Future<AngkutShipmentModel> createOrder({
    String token,
    AngkutShipmentModel angkutShipmentModel,
  }) {
    return NetworkUtil()
        .post(
      System.data.apiEndPointUtil.createOder(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: angkutShipmentModel.toJson(),
    )
        .then((onValue) {
      ModeUtil.debugPrint("success add order");
      ModeUtil.debugPrint(onValue);
      try {
        return AngkutShipmentModel.fromJson(json.decode(onValue));
      } catch (e) {
        throw e;
      }
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

// acceptOrder
  static Future<AngkutShipmentModel> pickupOrder({
    String token,
    @required int shipmentId,
    @required int driverId,
    @required double vehicleLat,
    @required double vehicleLon,
    @required double vehicleOdometer,
  }) {
    return NetworkUtil().post(
      System.data.apiEndPointUtil.pickupOrder(
        driverId: driverId,
        shipmentId: shipmentId,
        vehicleLat: vehicleLat,
        vehicleLon: vehicleLon,
        vehicleOdometer: vehicleOdometer.toInt(),
      ),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((onValue) {
      ModeUtil.debugPrint("success add order");
      ModeUtil.debugPrint(onValue);
      try {
        return AngkutShipmentModel.fromJson(json.decode(onValue));
      } catch (e) {
        throw e;
      }
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  static Future<AngkutShipmentModel> submitDetailPickupOrder({
    @required String token,
    @required int tmsshipmentId,
    @required int driverId,
  }) {
    return NetworkUtil().post(
      System.data.apiEndPointUtil.submitDetailPickupOrder(
          driverId: driverId, tmsshipmentId: tmsshipmentId),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((onValue) {
      try {
        return AngkutShipmentModel.fromJson(json.decode(onValue));
      } catch (e) {
        throw e;
      }
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  static Future<AngkutShipmentModel> finishDetailDestinationOrder({
    @required String token,
    @required int tmsshipmentId,
    @required int driverId,
    @required int detailShipmentId,
  }) {
    return NetworkUtil().post(
      System.data.apiEndPointUtil.finishDetailDestinationOrder(
        driverId: driverId,
        tmsshipmentId: tmsshipmentId,
        detailShipmentId: detailShipmentId,
      ),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((onValue) {
      try {
        return AngkutShipmentModel.fromJson(json.decode(onValue));
      } catch (e) {
        throw e;
      }
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  static Future<AngkutShipmentModel> cancleShipment({
    String token,
    int shipmentId,
    double vehicleLat,
    double vehicleLon,
    int vehicleOdometer,
  }) {
    return NetworkUtil().post(
      System.data.apiEndPointUtil.cancelOrder(
        shipmentId: shipmentId,
        vehicleLat: vehicleLat,
        vehilceLon: vehicleLon,
        vehicleOdomener: vehicleOdometer,
      ),
      headers: {
        "lang": System.data.resource.lang,
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((onValue) {
      print(onValue);
      return AngkutShipmentModel.fromJson(json.decode(onValue));
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<AngkutShipmentModel> getByNumber({
    String token,
    String shipmentNumber,
  }) {
    return NetworkUtil().post(
        System.data.apiEndPointUtil.getShipmentByShipmentNumber(
          shipmentNumber: shipmentNumber,
        ),
        headers: {
          "lang": System.data.resource.lang,
          HttpHeaders.authorizationHeader: "bearer $token",
          HttpHeaders.contentTypeHeader: "application/json",
        }).then((onValue) {
      return AngkutShipmentModel.fromJson((json.decode(onValue) as List).first);
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<AngkutShipmentModel> confirmWaiting({
    String token,
    int shipmentNumber,
  }) {
    return NetworkUtil().post(
      System.data.apiEndPointUtil.confirmWaiting(
        shipmentId: shipmentNumber,
      ),
      headers: {
        "lang": System.data.resource.lang,
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((onValue) {
      return AngkutShipmentModel.fromJson((json.decode(onValue)));
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<bool> isShipmentPayed({
    String token,
    int shipmentId,
  }) {
    return NetworkUtil().get(
      System.data.apiEndPointUtil.isShipmentPaid(
        tmsShipmentId: shipmentId,
      ),
      headers: {
        "lang": System.data.resource.lang,
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((value) {
      return value == "true"
          ? true
          : value == "false"
              ? false
              : null;
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<void> setShipmentPayed({
    String token,
    int shipmentId,
  }) {
    return NetworkUtil().post(
        System.data.apiEndPointUtil.setShipmentPaid(
          tmsShipmentId: shipmentId,
        ),
        headers: {
          "lang": System.data.resource.lang,
          HttpHeaders.authorizationHeader: "bearer $token",
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: {
          // "tmsShipmentId": shipmentId,
        }).then((value) {
      return;
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<List<AngkutShipmentModel>> getOurcome({
    @required String token,
    @required DateTime startDate,
    @required DateTime endDate,
    int shipmentId,
    int destinationId,
    int dataLimit,
    bool withRoute,
    bool isLowerThanId,
  }) {
    return NetworkUtil().get(
      System.data.apiEndPointUtil.invoiceGetOutCome(
        startDate: startDate,
        endDate: endDate,
        destinationId: destinationId,
        datalimit: dataLimit ?? 10,
        isLowerThanId: isLowerThanId,
        shipmentId: shipmentId,
        withRoute: withRoute ?? false,
      ),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((value) {
      return ((json.decode(value.toString())) as List)
          .map(
            (f) => AngkutShipmentModel.fromJson(f),
          )
          .toList();
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<List<AngkutShipmentModel>> getIncome({
    @required String token,
    @required DateTime startDate,
    @required DateTime endDate,
    int shipmentId,
    int destinationId,
    int dataLimit,
    bool withRoute,
    bool isLowerThanId,
  }) {
    return NetworkUtil().get(
      System.data.apiEndPointUtil.invoiceGetIncome(
        startDate: startDate,
        endDate: endDate,
        destinationId: destinationId,
        datalimit: dataLimit ?? 10,
        isLowerThanId: isLowerThanId,
        shipmentId: shipmentId,
        withRoute: withRoute ?? false,
      ),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((value) {
      return ((json.decode(value.toString())) as List)
          .map(
            (f) => AngkutShipmentModel.fromJson(f),
          )
          .toList();
    }).catchError((onError) {
      throw onError;
    });
  }
}
