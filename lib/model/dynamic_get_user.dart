import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DynamicUser {
  String action;
  String devId;
  String devToken;
  String isiInternalTest;

  DynamicUser({
    this.action,
    this.devId,
    this.devToken,
    this.isiInternalTest,
  });

  factory DynamicUser.fromJson(Map<String, dynamic> json) {
    return DynamicUser(
      action: json['action'],
      devId: json['devid'],
      devToken: json['devtoken'],
      isiInternalTest: json['isInternalTest'],
    );
  }

  static Future<DynamicUser> getData(String action, String devid,
      String devtoken, String isInternalTest) async {
    String apiUrl({
      String actions,
      String devId,
      String devToken,
      String isiInternalTest,
    }) {
      "http://36.89.110.91/oa_form.php?action=${actions ?? ""}&devid=${devId ?? ""}&devtoken=${devToken ?? ""}&isInternalTest=${isiInternalTest}";

      actions = action;
      devId = "aasdfasdf";
      devToken = "c3813940bc4cfb89ff4af26667e58eb8";
      isiInternalTest = isInternalTest;
      print("${devToken}");
    }

    var apiResult = await http.get(Uri.parse(apiUrl()));

    var jsonObject = json.decode(apiResult.body);

    return DynamicUser.fromJson(jsonObject);
  }
}
