import 'package:flutter/material.dart';

class ChatModel {
  bool sender;
  String value;
  DateTime dateTime;
  Icon senderIcon;
  Icon receiverIcon;
  bool images;

  ChatModel({
    this.sender = true,
    this.value,
    this.dateTime,
    this.receiverIcon,
    this.senderIcon,
    this.images = false,
  });
}
