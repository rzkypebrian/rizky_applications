import 'package:enerren/model/TripAllowanceSummaryModel.dart';
import 'view.dart';
import 'main.dart';
import 'viewModel.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/component/imagePickerComponent.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/util/StringExtention.dart';
//import 'package:enerren/app/angkut/aDriver/module/uangJalan/viewModel.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final TripAllowanceSummary tripAllowanceSummary;
  const Presenter({
    Key key,
    this.view,
    this.tripAllowanceSummary,
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
  ViewModel data = ViewModel();

  InputComponentTextEditingController typeExpanseController =
      new InputComponentTextEditingController();

  InputComponentTextEditingController priceController =
      new InputComponentTextEditingController();

  InputComponentTextEditingController imageController =
      new InputComponentTextEditingController();

  InputComponentTextEditingController amountController =
      new InputComponentTextEditingController();

  ImagePickerController imagePickerController = ImagePickerController();

  @override
  void initState() {
    super.initState();
    data.exspensesListView = widget.tripAllowanceSummary;
    data.loadingController.stopLoading();
    data.commit();
  }

  bool validateTypeExpanseController() {
    if (typeExpanseController.text.isNullOrEmpty()) {
      typeExpanseController.setStateInput = StateInput.Error;
      return false;
    } else {
      typeExpanseController.setStateInput = StateInput.Enable;
    }
    return null;
  }

  bool validatePriceController() {
    if (priceController.text.isNullOrEmpty()) {
      priceController.setStateInput = StateInput.Error;
      return false;
    } else {
      priceController.setStateInput = StateInput.Enable;
    }
    return null;
  }

  bool validate() {
    bool isValid = true;
    isValid = validateTypeExpanseController() ?? isValid;
    isValid = validatePriceController() ?? isValid;
    isValid = imagePickerController.getBase64() != null ? true : false;
    return isValid;
  }

  void submit() {
    if (validate() && !data.loadingController.onLoading) {
      Map<String, dynamic> _param = {
        'summaryId': widget.tripAllowanceSummary.summaryId,
        'expenseDescription': typeExpanseController.text.trim(),
        'expenseValue': double.parse(priceController.content),
        'expensePhoto': imagePickerController.getBase64(),
      };
      data.loadingController.startLoading();
      data.commit();
      TripAllowanceSummary.addUangJalanDriver(
              token: System.data.global.token, param: _param)
          .then((onValue) {
        data.exspensesListView = onValue;
        data.loadingController.stopLoading();
        clearData();
        data.commit();
      }).catchError(
        (onError) {
          data.loadingController.stopLoading(
            messageAlign: Alignment.topCenter,
            messageWidget: DecorationComponent.topMessageDecoration(
              backgroundColor: System.data.colorUtil.redColor,
              message: ErrorHandlingUtil.handleApiError(onError),
            ),
          );
        },
      );
      data.commit();
    }
  }

  void deleteItem(int walltetId) {
    List _listWalltetId = [walltetId];
    data.loadingController.startLoading();
    data.commit();

    TripAllowanceSummary.deleteUangJalanExpense(
            token: System.data.global.token, walletId: _listWalltetId)
        .then((onValue) {
      data.exspensesListView = onValue;
      data.commit();
    }).whenComplete(() {
      data.loadingController.stopLoading();
      clearData();
      data.commit();
    }).catchError((onError) {
      data.loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          backgroundColor: System.data.colorUtil.redColor,
          message: ErrorHandlingUtil.handleApiError(onError),
        ),
      );
      data.commit();
    });
  }

  void finishItem() {
    data.loadingController.startLoading();
    data.commit();

    TripAllowanceSummary.setFinishUangJalan(
            token: System.data.global.token,
            summaryId: data.exspensesListView.summaryId)
        .then((onValue) {
      data.exspensesListView = onValue;
      data.commit();
    }).whenComplete(() {
      data.loadingController.stopLoading();
      data.commit();
    }).catchError((onError) {
      data.loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          backgroundColor: System.data.colorUtil.redColor,
          message: ErrorHandlingUtil.handleApiError(onError),
        ),
      );
      data.commit();
    });
  }

  void clearData() {
    imagePickerController.value.fileImage = null;
    imageController.text = "";
    priceController.text = "";
    typeExpanseController.text = "";
  }
}
