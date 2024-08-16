import 'package:enerren/module/setting/presenter.dart';
import 'package:flutter/material.dart';

mixin InovatrackPresenter on PresenterState {
  void signOut(VoidCallback callback) {
    loadingController.startLoading();
    callback();
  }
}
