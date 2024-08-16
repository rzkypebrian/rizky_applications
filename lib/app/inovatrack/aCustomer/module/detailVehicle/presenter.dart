import 'dart:async';

import 'package:enerren/app/inovatrack/aCustomer/module/detailVehicle/viewModel.dart';
import 'package:enerren/app/inovatrack/aCustomer/module/detailVehicle/view.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final VtsPositionModel vtsPositionModel;
  final bool autoRefresh;
  final ValueChanged<VtsPositionModel> onTapMap;

  const Presenter({
    Key key,
    this.view,
    this.vtsPositionModel,
    this.autoRefresh,
    this.onTapMap,
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

abstract class PresenterState extends State<Presenter> {
  ViewModel model = new ViewModel();
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  @override
  void initState() {
    super.initState();
    model.vtsPositionModel = widget.vtsPositionModel;
    model.autoRefresh = widget.autoRefresh ?? model.autoRefresh;
    model.commit();
    loadingController.stopLoading();
    if (model.autoRefresh) {
      Timer.periodic(Duration(seconds: System.data.global.intervalUpdateData),
          (t) {
        t.cancel();
        update();
      });
    }
  }

  void getDetailVehicle() {
    VtsPositionModel.getVehiclePosition(
            vehicleId: model.vtsPositionModel.vehicleId)
        .then((onValue) {
      model.vtsPositionModel = onValue;
      model.commit();
      loadingController.stopLoading();
    }).catchError((onError) {
      loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: ErrorHandlingUtil.handleApiError(onError),
        ),
      );
    });
  }

  void update() {
    VtsPositionModel.getVehiclePosition(
      vehicleId: model.vtsPositionModel.vehicleId,
    ).then((value) {
      model.vtsPositionModel = value;
      model.commit();
      if (model.autoRefresh) {
        Timer.periodic(Duration(seconds: System.data.global.intervalUpdateData),
            (t) {
          t.cancel();
          update();
        });
      }
    }).catchError((onError) {
      loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: ErrorHandlingUtil.handleApiError(onError),
        ),
      );
      if (model.autoRefresh) {
        Timer.periodic(Duration(seconds: System.data.global.intervalUpdateData),
            (t) {
          t.cancel();
          update();
        });
      }
    });
  }

  void onTapMap(){
    if(widget.onTapMap != null){
      widget.onTapMap(widget.vtsPositionModel);
    }else{
      ModeUtil.debugPrint("On tap map");
    }
  }
}
