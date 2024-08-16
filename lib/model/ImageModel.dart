import 'dart:convert';
import 'dart:io';

import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class ImageModel {
  int imageId;
  int destinationId;
  String imageUrl;

  ImageModel({
    this.imageId,
    this.destinationId,
    this.imageUrl,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ImageModel(
      imageId: json['imageId'] as int,
      destinationId: json['destinationId'] as int,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'imageId': this.imageId,
      'destinationId': this.destinationId,
      'imageUrl': this.imageUrl,
    };
  }

  static Future<AccountModel> uploadImage({
    String token,
    String path,
    TypeMultipartFile typeMultipartFile,
    String username,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.multipartRequest(
      System.data.apiEndPointUtil.uploadImage(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
      },
    ).then((onValue) {
      if (onValue.toString().isNotEmpty) {
        return AccountModel.fromJson(json.decode(onValue));
      } else {
        return AccountModel();
      }
    }).catchError((onError) {
      throw onError;
    });
  }
}
