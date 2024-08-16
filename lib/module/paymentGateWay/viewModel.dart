import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewModel extends ChangeNotifier {
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();
  WebViewController webViewController;
  bool showButtonNavigationBar = false;

  void commit() {
    notifyListeners();
  }
}
