import 'dart:convert';

import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/serchShipmentNumberHistory.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/util/StringExtention.dart';
import 'view.dart';
import 'viewModel.dart';

class Presenter<T> extends StatefulWidget {
  final State<Presenter<T>> view;
  final ValueChanged<T> onShipmentFound;

  const Presenter({
    Key key,
    this.view,
    this.onShipmentFound,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    if (view != null) {
      return view;
    } else {
      return View<T>();
    }
  }
}

abstract class PresenterState<T> extends State<Presenter<T>>
    with SingleTickerProviderStateMixin {
  T result;
  ViewModel model = new ViewModel();
  InputComponentTextEditingController receipeController =
      new InputComponentTextEditingController();
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  void initState() {
    super.initState();
    loadingController.stopLoading();
    model.receiptNumbers = System.data.global.historyReceiptSearch;
    model.commit();
  }

  bool validateResiController() {
    if (receipeController.text.isNullOrEmpty()) {
      receipeController.setStateInput = StateInput.Error;
    } else {
      receipeController.setStateInput = StateInput.Enable;
    }
    return null;
  }

  bool validate() {
    bool isValid = true;
    isValid = validateResiController() ?? isValid;
    return isValid;
  }

  void onTapTrack() {
    if (!validate()) return;
    submit(receipeController.text);
  }

  void submit(String receipeNumber) {
    if (widget.onShipmentFound != null) {
      widget.onShipmentFound(result);
    } else {
      safeHistory(receipeNumber);
      ModeUtil.debugPrint("on tap track");
    }
  }

  void safeHistory(String receipeNumber) {
    if (System.data.global.historyReceiptSearch
            .where((f) => f.shipmentNumber.contains(receipeNumber))
            .toList()
            .length >
        0) return;
    System.commit();
    System.data.global.historyReceiptSearch.add(new SerchShipmentNumberHistory(
      shipmentNumber: receipeNumber,
    ));
    System.data.sharedPreferences.setString(
        PrefsKey.searchResiHistory,
        json.encode(System.data.global.historyReceiptSearch
            .map((f) => f.toJson())
            .toList()));
    model.receiptNumbers = System.data.global.historyReceiptSearch;
    model.commit();
  }
}
