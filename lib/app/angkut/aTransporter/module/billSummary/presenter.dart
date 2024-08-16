// import 'package:enerren/component/InputComponent.dart';
// import 'package:enerren/component/dateTImePicker.dart';
// import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'main.dart';
// import 'package:enerren/component/dateTImePicker.dart' as dateTimePicker;

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged3Param<List<AngkutShipmentModel>, DateTime, DateTime>
      onTapGotoList;
  const Presenter({
    Key key,
    this.view,
    this.onTapGotoList,
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
  ViewModel model = ViewModel();

  @override
  void initState() {
    model.loadingController.stopLoading();
    model.year = DateTime.now().year;
    model.month = DateTime.now().month;
    model.calcDate();
    getOutComeSummary();
    super.initState();
  }

  void getOutComeSummary() {
    model.loadingController.startLoading();
    AngkutShipmentModel.getIncome(
      token: System.data.global.token,
      startDate: model.firstDate,
      endDate: model.lastDate,
    ).then((value) {
      model.invoiceModels = value;
      model.commit();
      model.loadingController.stopLoading();
    }).catchError((onError) {
      model.loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: ErrorHandlingUtil.handleApiError(onError),
        ),
      );
    });
  }

  void gotoList() {
    if (widget.onTapGotoList != null) {
      print("masuk sini ${model.invoiceModels.length}");
      widget.onTapGotoList(
          model.invoiceModels, model.firstDate, model.lastDate);
    } else {
      ModeUtil.debugPrint("goto list tapped");
    }
  }
}
