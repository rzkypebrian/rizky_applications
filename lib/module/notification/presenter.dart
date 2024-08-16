import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/listDataComponent.dart';
import 'package:enerren/model/tmsNotificationModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';
import 'package:enerren/util/TypeUtil.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final WidgetFromDataBuilder<CircularProgressIndicatorController>
      loadingIndicatorDecoration;
  final ValueChanged<TmsNotificationModel> onTapNotification;
  final String loadingAnimationAssets;
  final String loadingAnimation;

  const Presenter({
    Key key,
    this.view,
    this.loadingIndicatorDecoration,
    this.onTapNotification,
    this.loadingAnimationAssets,
    this.loadingAnimation,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenerState extends State<Presenter> {
  ListDataComponentController<TmsNotificationModel> listDataController =
      new ListDataComponentController();

  void getNewNotification(
      TmsNotificationModel data, ScrollController controller) async {
    listDataController.value.loadingController.startLoading();
    await TmsNotificationModel.get(
      token: System.data.global.token,
      datalimit: 10,
      // shipmentId: data != null ? data.tmsShipmentId : 0,
      notificationId: 0,
      isLowerThanId: false,
    ).then((onValue) {
      if (onValue.length > 0) {
        listDataController.value.data = onValue;
        listDataController.commit();
        controller.animateTo(1.0,
            curve: Curves.easeIn, duration: Duration(milliseconds: 500));
      }
      listDataController.value.loadingController.stopLoading();
    }).catchError((onError) {
      listDataController.value.loadingController
          .stopLoading(message: ErrorHandlingUtil.handleApiError(onError));
    });
  }

  void getOldNotification(
      TmsNotificationModel data, ScrollController controller) async {
    listDataController.value.loadingController.startLoading();
    await TmsNotificationModel.get(
      token: System.data.global.token,
      datalimit: 10,
      notificationId: data != null ? data.notificationId : 0,
      isLowerThanId: true,
    ).then((onValue) {
      if (onValue.length > 0) {
        if (data != null) {
          listDataController.value.data.remove(data);
          listDataController.commit();
        }
        listDataController.add(onValue);
        try {
          controller.animateTo(controller.position.maxScrollExtent,
              curve: Curves.easeIn, duration: Duration(milliseconds: 500));
        } catch (e) {}
      }
      listDataController.value.loadingController.stopLoading();
    }).catchError((onError) {
      listDataController.value.loadingController
          .stopLoading(message: ErrorHandlingUtil.handleApiError(onError));
    });
  }

  void onTapNotification(TmsNotificationModel notif) {
    if (widget.onTapNotification != null) {
      widget.onTapNotification(notif);
    } else {
      ModeUtil.debugPrint(notif.toJson());
    }
  }
}
