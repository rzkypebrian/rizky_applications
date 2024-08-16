import 'dart:convert';

import 'package:enerren/model/chatModel.dart';

import 'SystemUtil.dart';

class ChatHandleUtil {
  static handleTextChat(String data) {
    ChatModel chat = ChatModel.fromJson(json.decode(data));
    System.data.global.chatsViewModel[chat.tmsShipmentId] =
        System.data.global.chatsViewModel[chat.tmsShipmentId] ??
            new ChatModel();
    System.data.global.chatsViewModel[chat.tmsShipmentId].chats.add(chat);
    if (!System
        .data.global.chatsViewModel[chat.tmsShipmentId].autoScrollToButton) {
      System.data.global.chatsViewModel[chat.tmsShipmentId].unread++;
    }
    System.data.global.chatsViewModel[chat.tmsShipmentId].scrollToDown();
    System.data.global.chatsViewModel[chat.tmsShipmentId].commit();
  }
}
