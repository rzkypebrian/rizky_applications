import 'package:enerren/component/listDataComponent.dart';
import 'package:enerren/model/tmsVehicleCheckDocument.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<TmsVehicleCheckDocument> onTapAbsentItem;

  const Presenter({
    Key key,
    this.view,
    this.onTapAbsentItem,
  }) : super(key: key);

  @override
  createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  ListDataComponentController<TmsVehicleCheckDocument> absentListController =
      new ListDataComponentController<TmsVehicleCheckDocument>();

  Future getNew(TmsVehicleCheckDocument data, ScrollController ctrl) async {
    absentListController.value.loadingController.startLoading(
      coverScreen: false,
    );
    await TmsVehicleCheckDocument.getAll(
            token: System.data.global.token,
            checkTime: null,
            isLowerThanId: false,
            searchKey: null)
        .then((onValue) {
      absentListController.value.data = onValue;
      absentListController.commit();
      ctrl.animateTo(1.0,
          curve: Curves.easeIn, duration: Duration(milliseconds: 500));
      absentListController.value.loadingController.stopLoading();
    }).catchError((onError) {
      absentListController.value.loadingController.stopLoading(
        message: ErrorHandlingUtil.handleApiError(onError),
      );
    });
  }

  Future getOld(TmsVehicleCheckDocument data, ScrollController ctrl) async {
    absentListController.value.loadingController.startLoading(
      coverScreen: false,
    );

    await TmsVehicleCheckDocument.getAll(
            token: System.data.global.token,
            checkTime:
                data != null ? data.checkTime.add(Duration(days: -1)) : null,
            isLowerThanId: true,
            searchKey: null)
        .then((onValue) {
      if (onValue.length > 0) {
        if (data != null) {
          absentListController.value.data.remove(data);
          absentListController.commit();
        }
        absentListController.add(onValue);
        try {
          ctrl.animateTo(ctrl.position.maxScrollExtent,
              curve: Curves.easeIn, duration: Duration(milliseconds: 500));
        } catch (e) {}
      }
      absentListController.value.loadingController.stopLoading();
    }).catchError((onError) {
      absentListController.value.loadingController.stopLoading(
        message: ErrorHandlingUtil.handleApiError(onError),
      );
    });
  }

  void onTapAbsent(TmsVehicleCheckDocument data) {
    if (widget.onTapAbsentItem != null) {
      widget.onTapAbsentItem(data);
    }
  }
}
