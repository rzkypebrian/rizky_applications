import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import '../../../../../util/SystemUtil.dart';
import '../../localData.dart';
import 'HomeViewer.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final VoidCallback onTapDO;
  final VoidCallback onTapPhoto;
  final ValueChanged<AngkutShipmentModel> onTapNext;
  final String podLabel;
  @required
  final AngkutShipmentModel angkutShipmentModel;

  const Presenter({
    Key key,
    this.view,
    this.onTapDO,
    this.onTapPhoto,
    this.onTapNext,
    this.angkutShipmentModel,
    this.podLabel,
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
  HomeViewer model = new HomeViewer();

  @override
  void initState() {
    super.initState();
    model.angkutShipmentModel = widget.angkutShipmentModel;
    model.commit();
    model.loadingController.stopLoading();
  }

  void nextToMaps() {
    model.loadingController.startLoading();
    ModeUtil.debugPrint("${System.data.getLocal<LocalData>().user.driverId}");
    ModeUtil.debugPrint("${model.angkutShipmentModel.tmsShipmentId}");
    AngkutShipmentModel.submitDetailPickupOrder(
      token: System.data.global.token,
      driverId: System.data.getLocal<LocalData>().user.driverId,
      tmsshipmentId: model.angkutShipmentModel.tmsShipmentId,
    ).then((onValue) {
      widget.onTapNext(onValue);
    }).whenComplete(() {
      model.loadingController.stopLoading();
      model.commit();
    }).catchError((onError) {
      model.loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
              message: ErrorHandlingUtil.handleApiError(onError)));

      model.commit();
    });
  }
}
