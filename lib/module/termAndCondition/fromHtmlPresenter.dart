import 'presenter.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

mixin FromHtmlPresenter on PresenterState {
  Future<String> loadAsset(String path) async {
    return await rootBundle.loadString("$path");
  }
}
