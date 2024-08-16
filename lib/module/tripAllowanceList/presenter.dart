import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/TripAllowanceSummaryModel.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/listDataComponent.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'main.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:flutter/material.dart';
import 'package:enerren/util/StringExtention.dart';
import 'package:http/http.dart' as http;

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<TripAllowanceSummary> onSubmit;
  final ValueChanged<ViewModel> onTapSearchShipment;
  final String shipmentNumber;
  final bool showList;
  final bool showSearchSipment;
  final ValueChanged<TripAllowanceSummary> onSuccessAddbalance;

  const Presenter({
    Key key,
    this.view,
    this.onSubmit,
    this.onTapSearchShipment,
    this.shipmentNumber,
    this.showList = true,
    this.showSearchSipment = true,
    this.onSuccessAddbalance,
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

abstract class PresenterState extends State<Presenter>
    with TickerProviderStateMixin {
  ViewModel model = ViewModel();

  InputComponentTextEditingController budget =
      new InputComponentTextEditingController();

  ListDataComponentController<TripAllowanceSummary> listDataController =
      new ListDataComponentController<TripAllowanceSummary>();
  CircularProgressIndicatorController controller =
      CircularProgressIndicatorController();
  @override
  void initState() {
    super.initState();
    model.controller = new TabController(vsync: this, length: 2)
      ..addListener(() {
        model.indexController = model.controller.index;
        model.commint();
      });
    model.shimenpNumber.text = widget.shipmentNumber ?? "";
    controller.stopLoading();
  }

  @override
  void dispose() {
    model.controller.dispose();
    super.dispose();
  }

  void addBudget() {}

  bool validateShimenpNumberController() {
    if (model.shimenpNumber.text.isNullOrEmpty()) {
      model.shimenpNumber.setStateInput = StateInput.Error;
      return false;
    } else {
      model.shimenpNumber.setStateInput = StateInput.Enable;
    }
    return null;
  }

  bool validateBudgetController() {
    if (budget.text.isNullOrEmpty()) {
      budget.setStateInput = StateInput.Error;
      return false;
    } else {
      budget.setStateInput = StateInput.Enable;
    }
    return null;
  }

  bool valid() {
    bool isValid = true;
    isValid = validateShimenpNumberController() ?? isValid;
    isValid = validateBudgetController() ?? isValid;
    return isValid;
  }

  void saveData() {
    if (valid() == true && controller.onLoading == false) {
      controller.startLoading();
      ModeUtil.debugPrint("token : ${System.data.global.token}");
      TripAllowanceSummary.addUangJalan(
        beginningBalance: double.parse(budget.content),
        shipmentNumber: model.shimenpNumber.text.trim(),
        token: System.data.global.token,
      )
          .then((onValue) {
            ModeUtil.debugPrint(onValue);
            controller.stopLoading(
                messageAlign: Alignment.topCenter,
                isError: false,
                messageWidget: DecorationComponent.topMessageDecoration(
                  backgroundColor: System.data.colorUtil.greenColor,
                  message: System.data.resource.success,
                ),
                onFinishCallback: () {
                  if (widget.onSuccessAddbalance != null) {
                    widget.onSuccessAddbalance(onValue);
                  }
                });
          })
          .whenComplete(() {})
          .catchError((onError) {
            print(onError);
            controller.stopLoading(
              messageAlign: Alignment.topCenter,
              messageWidget: DecorationComponent.topMessageDecoration(
                backgroundColor: System.data.colorUtil.redColor,
                message: ErrorHandlingUtil.handleApiError(onError),
              ),
            );
          });
    }
  }

  void clearData() {
    if (widget.showList) model.shimenpNumber.text = "";
    budget.text = "";
  }

  void onSelectedData(TripAllowanceSummary ao) {
    if (widget.onSubmit != null) {
      widget.onSubmit(ao);
    } else {
      ModeUtil.debugPrint("selected");
    }
  }

  Future getNewUangJalanList(
      TripAllowanceSummary data, ScrollController ctrl) async {
    listDataController.value.loadingController.startLoading(
      coverScreen: false,
    );
    await TripAllowanceSummary.getUangJalanList(
      token: System.data.global.token,
    ).then((onValue) {
      if (onValue.length > 0) {
        listDataController.value.data = onValue
            .where((x) =>
                x.endingBalance != 0 || x.uangJalanDetailExpense.length > 0)
            .toList();
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
    ).then((onValue) {
      if (onValue.length > 0) {
        listDataController.value.data = onValue
            .where((x) =>
                x.endingBalance != 0 || x.uangJalanDetailExpense.length > 0)
            .toList();
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
}
