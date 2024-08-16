import 'package:enerren/model/TripAllowanceSummaryModel.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/listDataComponent.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<TripAllowanceSummary> onTap;

  Presenter({
    Key key,
    this.view,
    this.onTap,
  }) : super(key: key);

  createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  Viewer model = new Viewer();

  ListDataComponentController<TripAllowanceSummary> listDataController =
      new ListDataComponentController<TripAllowanceSummary>();

  InputComponentTextEditingController searchController =
      new InputComponentTextEditingController();

  @override
  void initState() {
    super.initState();
    model.loadingController.stopLoading();
    model.commit();
  }

  Future getNewUangJalanList(
      TripAllowanceSummary data, ScrollController ctrl) async {
    listDataController.value.loadingController.startLoading(
      coverScreen: false,
    );
    await TripAllowanceSummary.getUangJalanList(
      token: System.data.global.token,
      shipmentNumber: searchController.text.trim(),
    ).then((onValue) {
      if (onValue.length > 0) {
        listDataController.value.data = onValue;
        listDataController.commit();
        try {
          ctrl.animateTo(1.0,
              curve: Curves.easeIn, duration: Duration(milliseconds: 500));
        } catch (e) {}
      }
      listDataController.value.loadingController.stopLoading();
    }).catchError((onError) {
      try {
        http.Response error = onError;
        listDataController.value.loadingController.stopLoading(
          message: error.body,
        );
      } catch (e) {
        listDataController.value.loadingController.stopLoading(
          message: "$onError",
        );
      }
    });
  }

  Future getOldUangJalanList(
      TripAllowanceSummary data, ScrollController ctrl) async {
    listDataController.value.loadingController.startLoading(
      coverScreen: false,
    );
    await TripAllowanceSummary.getUangJalanList(
      token: System.data.global.token,
      shipmentNumber: searchController.text.trim(),
    ).then((onValue) {
      if (onValue.length > 0) {
        listDataController.value.data = onValue;
        listDataController.commit();
        try {
          ctrl.animateTo(1.0,
              curve: Curves.easeIn, duration: Duration(milliseconds: 500));
        } catch (e) {}
      }
      listDataController.value.loadingController.stopLoading();
    }).catchError((onError) {
      try {
        http.Response error = onError;
        listDataController.value.loadingController.stopLoading(
          message: error.body,
        );
      } catch (e) {
        listDataController.value.loadingController.stopLoading(
          message: "$onError",
        );
      }
    });
  }

  void onSearchChange(String value) {
    getNewUangJalanList(
      null,
      listDataController.value?.scrollController,
    );
  }

  void onSelected(TripAllowanceSummary ao) {
    if (widget.onTap != null) {
      widget.onTap(ao);
    } else {
      ModeUtil.debugPrint("message");
    }
  }
}
