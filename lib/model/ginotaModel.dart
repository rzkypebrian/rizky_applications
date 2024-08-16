import 'dart:convert';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:flutter/cupertino.dart';

class GinotaModel {
  String apiKey;
  String apiSecret;
  GinotaMessage message;
  GinotaResponse response;

  GinotaModel({
    @required this.apiKey,
    @required this.apiSecret,
    this.message,
    this.response,
  });

  static GinotaModel dummy() => GinotaModel(
        apiKey: "apikeybalablabal",
        apiSecret: "secreetkeyblablabala",
        message: GinotaMessage.dummy(),
        response: GinotaResponse.dummy(),
      );

  Map<String, dynamic> toJson() => {
        "apiKey": "$apiKey",
        "apiSecret": "$apiSecret",
        "message": message.toJson(),
        "response": response.toJson(),
      };

  Future<GinotaModel> send(GinotaMessage message) {
    final url =
        "https://www.ginota.com/gemp/sms/json?apiKey=${this.apiKey}&apiSecret=${this.apiSecret}&srcAddr=${message.srcAddr}&dstAddr=${message.dstAddr}&flash=${message.flash ? "1" : 0}&content=${message.content}";
    this.message = message;
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.get("$url").then((dynamic res) {
      if (res.toString().length > 0) {
        this.response = GinotaResponse.fromJson(json.decode(res.toString()));
      } else {
        this.response = GinotaResponse();
      }
      return this;
    }).catchError((error) {
      throw error;
    });
  }
}

class GinotaMessage {
  String srcAddr;
  String dstAddr;
  String content;
  bool flash;

  GinotaMessage({
    this.srcAddr,
    this.dstAddr,
    this.content,
    this.flash = false,
  });

  Map<String, dynamic> toJson() => {
        "srcAddr": "$srcAddr",
        "dstAddr": "$dstAddr",
        "content": "$content",
        "flash": "$flash",
      };

  static GinotaMessage dummy() => GinotaMessage(
        srcAddr: "Inovatrack",
        dstAddr: "6285814706814",
        content: "hallo_ginota",
        flash: false,
      );
}

class GinotaResponse {
  String status;
  String desc;
  String parts;
  String messageId;
  String message;

  GinotaResponse({
    this.status,
    this.desc,
    this.parts,
    this.messageId,
  });

  factory GinotaResponse.fromJson(Map<String, dynamic> json) {
    GinotaResponse data = GinotaResponse();

    try {
      data.status = json['status'];
    } catch (e) {
      data.message = "error get status from return json";
    }

    try {
      data.desc = json['desc'];
    } catch (e) {
      data.message = "error get desc from return json";
    }

    try {
      data.parts = json['parts'];
    } catch (e) {
      data.message = "error get parts from return json";
    }

    try {
      data.messageId = json['messageId'];
    } catch (e) {
      data.message = "error get messageId from return json";
    }

    return data;
  }

  Map<String, dynamic> toJson() => {
        "status": "$status",
        "desc": "$desc",
        "parts": "$parts",
        "messageId": "$messageId",
      };

  static GinotaResponse dummy() {
    return GinotaResponse(
      status: "0",
      desc: "Ok",
      parts: "1",
      messageId: "18D64EC1EADD",
    );
  }
}
