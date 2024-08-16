import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:enerren/component/InputComponent.dart';
part 'ShipmentItemDescriptionViewModel.g.dart';

@JsonSerializable(explicitToJson: true)
class ShipmentItemDescriptionViewModel {
  int tmsShipmentId;
  int itemId;
  int detailshipmentId;
  String item;
  String itemDescription;
  int qty;
  String remarks;
  String uomCode;
  String uomName;
  bool isChecked;
  String insertedBy;
  String modifiedBy;

  InputComponentTextEditingController itemNameContoller =
      InputComponentTextEditingController();
  InputComponentTextEditingController itemDescController =
      InputComponentTextEditingController();
  InputComponentTextEditingController qtyItemCOntroller =
      InputComponentTextEditingController();
  InputComponentTextEditingController uomCodeItemController =
      InputComponentTextEditingController();

  ShipmentItemDescriptionViewModel({
    this.tmsShipmentId,
    this.itemId,
    this.detailshipmentId,
    this.item = "",
    this.itemDescription = "",
    this.qty = 0,
    this.remarks,
    this.uomCode,
    this.uomName,
    this.isChecked = false,
    this.insertedBy,
    this.modifiedBy,
  });

  factory ShipmentItemDescriptionViewModel.fromJson(
          Map<String, dynamic> json) =>
      _$ShipmentItemDescriptionViewModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$ShipmentItemDescriptionViewModelToJson(this);

  static Map<String, dynamic> toitemId(int itemId) {
    return {'itemId': itemId};
  }

  static Future<List<ShipmentItemDescriptionViewModel>>
      getShipmentItemDescription({
    @required String token,
    @required int tmsShipmentId,
    @required int detailShipmentId,
    @required bool isPod,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.get(
      System.data.apiEndPointUtil.getShipmentItemDescription(
        tmsShipmentId: tmsShipmentId,
        detailShipmentId: detailShipmentId,
        isPod: isPod,
      ),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((onValue) {
      if (onValue.toString().isNotEmpty) {
        return (json.decode(onValue) as List)
            .map((f) => ShipmentItemDescriptionViewModel.fromJson(f))
            .toList();
      } else {
        return null;
      }
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<ShipmentItemDescriptionViewModel> addShipmentItemDescription({
    @required String token,
    @required ShipmentItemDescriptionViewModel shipmentItemDescriptionViewModel,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.post(
      System.data.apiEndPointUtil.addShipmentItemDescription(),
      body: shipmentItemDescriptionViewModel.toJson(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((onValue) {
      if (onValue.toString().isNotEmpty) {
        return ShipmentItemDescriptionViewModel.fromJson(json.decode(onValue));
      } else {
        return null;
      }
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<ShipmentItemDescriptionViewModel>
      updateSingleShipmentItemDescription({
    @required String token,
    @required ShipmentItemDescriptionViewModel shipmentItemDescriptionViewModel,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.post(
      System.data.apiEndPointUtil.updateSingleShipmentItemDescription(),
      body: shipmentItemDescriptionViewModel.toJson(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((onValue) {
      if (onValue.toString().isNotEmpty) {
        return ShipmentItemDescriptionViewModel.fromJson(json.decode(onValue));
      } else {
        return null;
      }
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<List<ShipmentItemDescriptionViewModel>>
      updateShipmentItemDescription({
    @required String token,
    @required
        List<ShipmentItemDescriptionViewModel> shipmentItemDescriptionViewModel,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.post(
      System.data.apiEndPointUtil.updateShipmentItemDescription(),
      boolListBodies: true,
      bodies: shipmentItemDescriptionViewModel.map((f) => f.toJson()).toList(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((onValue) {
      if (onValue.toString().isNotEmpty) {
        return (json.decode(onValue) as List)
            .map((f) => ShipmentItemDescriptionViewModel.fromJson(f))
            .toList();
      } else {
        return null;
      }
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<List<ShipmentItemDescriptionViewModel>>
      deleteShipmentItemDescription({
    @required String token,
    @required List itemId,
    @required int tmsShipmentId,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.post(
      System.data.apiEndPointUtil
          .deleteShipmentItemDescription(tmsShipmentId: tmsShipmentId),
      boolListBodies: true,
      bodies: itemId,
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((onValue) {
      if (onValue.toString().isNotEmpty) {
        return (json.decode(onValue) as List)
            .map((f) => ShipmentItemDescriptionViewModel.fromJson(f))
            .toList();
      } else {
        return null;
      }
    }).catchError((onError) {
      throw onError;
    });
  }
}
