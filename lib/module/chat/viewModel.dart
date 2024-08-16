import 'package:enerren/model/chatModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  List<ChatModel> chats = [];
  ScrollController listChatsScrollController = new ScrollController();
  String statusChat = "";
  bool autoScrollToButton = true;
  int unread = 0;
  List<DateTime> dates = [];

  ViewModel() {
    listChatsScrollController.addListener(scrollListener);
  }

  void scrollToDown({bool force = false}) {
    if (autoScrollToButton || force) {
      listChatsScrollController.animateTo(
        listChatsScrollController.position.maxScrollExtent + 50,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
      autoScrollToButton = true;
    }
  }

  void scrollListener() {
    if (listChatsScrollController.offset ==
            listChatsScrollController.position.maxScrollExtent &&
        !listChatsScrollController.position.outOfRange) {
      autoScrollToButton = true;
      commit();
    } else {
      autoScrollToButton = false;
      unread = 0;
      commit();
    }
  }

  void commit() {
    notifyListeners();
  }
}
