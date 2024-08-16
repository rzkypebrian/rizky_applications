import 'dart:convert';

import 'package:enerren/app/angkut/aCustomer/LocalData.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/model/InsuranceModel.dart';
import 'package:enerren/model/InsurancePremiModel.dart';
import 'package:enerren/model/insuranceCategoryModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
// import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'viewModel.dart';
import 'package:enerren/util/StringExtention.dart';
import 'view.dart';
import 'package:enerren/component/dateTImePicker.dart' as dateTimePicker;
import 'package:http/http.dart' as http;

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<ViewModel> onSubmit;
  final ValueChanged<AngkutShipmentModel> onSubmitSuccess;
  final bool useInsuranceField;
  final double extraPeopleMinValue;

  const Presenter({
    Key key,
    this.view,
    this.onSubmit,
    this.onSubmitSuccess,
    this.useInsuranceField = true,
    this.extraPeopleMinValue = 0,
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
  ViewModel data = new ViewModel();
  AngkutShipmentModel shipment = AngkutShipmentModel();
  InputComponentTextEditingController itemTypeController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController dateController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController nameController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController phoneController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController selectedController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController priceEstimationController =
      new InputComponentTextEditingController();

  StateInput dateState;
  final FocusNode dateFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    data.loadingController.stopLoading();
    data.extraHelperCount = widget.extraPeopleMinValue.toInt();
    getAllInsurancePremi();
    getAllInsuranceCategory();
  }

  bool validateItemTypeController() {
    if (itemTypeController.text.isNullOrEmpty()) {
      itemTypeController.setStateInput = StateInput.Error;
      return false;
    } else {
      itemTypeController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validateDateController() {
    if (dateController.text.isNullOrEmpty() && data.type == 1) {
      dateController.setStateInput = StateInput.Error;
      return false;
    } else {
      dateController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validateNameController() {
    if (nameController.text.isNullOrEmpty()) {
      nameController.setStateInput = StateInput.Error;
      return false;
    } else {
      nameController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validatePhoneController() {
    if (phoneController.text.isNullOrEmpty()) {
      phoneController.setStateInput = StateInput.Error;
      return false;
    } else {
      phoneController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validatePriceEstimationController() {
    if (priceEstimationController.text.isNullOrEmpty() &&
        data.useInsurance == true) {
      priceEstimationController.setStateInput = StateInput.Error;
      return false;
    } else {
      priceEstimationController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validate() {
    bool isValid = true;
    isValid = validateItemTypeController() ?? isValid;
    isValid = validateDateController() ?? isValid;
    // isValid = validateNameController() ?? isValid;
    // isValid = validatePhoneController() ?? isValid;
    isValid = validatePriceEstimationController() ?? isValid;
    data.commit();
    return isValid;
  }

  void submit() {
    if (!validate()) return;
    calculatePrice();
  }

  Future<Null> selectDate(BuildContext context) async {
    dateTimePicker
        .showDateTimePicker(context,
            datePickerSetting: System.data.themeUtil.datePickerTheme(
              firstDate: DateTime.now(),
              initialDate: DateTime.now(),
            ),
            mode: dateTimePicker.PickerMode.DateTime)
        .then((date) {
      if (date != null) data.scheduleDate = date;
      dateController.text =
          "${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
    });
  }

  void calculatePrice() {
    ///use customer id for special price
    System.data.getLocal<LocalData>().newOrder.customerId =
        System.data.getLocal<LocalData>().user?.customerId ?? 0;
    System.data.getLocal<LocalData>().newOrder.shipmentFee = 0;
    System.data.getLocal<LocalData>().newOrder.isInstant =
        data.type == 0 ? true : false;
    System.data.getLocal<LocalData>().newOrder.scheduledDate =
        data.scheduleDate;
    System.data.getLocal<LocalData>().newOrder.extraHelper = data.extraPeople;
    System.data.getLocal<LocalData>().newOrder.itemDescription =
        data.itemDescription;
    System.data.getLocal<LocalData>().newOrder.extraHelperCount =
        data.extraHelperCount;
    System.data.getLocal<LocalData>().newOrder.insuranceId =
        data.useInsurance ? data.selectedInsurance.insuranceId : null;
    System.data.getLocal<LocalData>().newOrder.premiId =
        data.useInsurance ? data.selectedInsurance.premiId : null;
    System.data.getLocal<LocalData>().newOrder.estimateGoodsPrice =
        data.useInsurance ? data.estimateGoodsPrice : null;
    System.data.getLocal<LocalData>().newOrder.voucherCode = null;
    data.loadingController.startLoading();
    ModeUtil.debugPrint(
        json.encode(System.data.getLocal<LocalData>().newOrder.toJson()));
    AngkutShipmentModel.calculate(
            token: System.data.global.token,
            createOrderModel: System.data.getLocal<LocalData>().newOrder)
        .then((onValue) {
      data.loadingController.stopLoading();
      if (widget.onSubmitSuccess != null) {
        widget.onSubmitSuccess(onValue);
      }
    }).catchError((onError) {
      String _message;
      try {
        http.Response response = onError;
        _message =
            "${response.body.isNotEmpty ? response.body : response.statusCode}";
      } catch (e) {
        _message = "$onError";
      }
      data.loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          backgroundColor: System.data.colorUtil.redColor,
          message: "$_message",
        ),
      );
    });
  }

  void getAllInsurancePremi() {
    data.loadingController.startLoading();
    InsuranceModel.get(
      token: System.data.global.token,
      insuranceTypeId: data.selectedInsuranceCategory?.insuranceTypeId,
      insuranceId: data.selectedInsuranceCategory?.insuranceId,
    ).then((value) {
      data.loadingController.stopLoading();
      data.insurances = value;
      data.selectedInsurance = value.first.insurancePremiList.first;
      print("total insurance ${data.insurances.length}");
      data.commit();
    }).catchError(
      (onError) {
        data.loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError),
          ),
        );
      },
    );
  }

  List<DropdownMenuItem<InsurancePremiModel>> getDropDownInsuranceItem() {
    print("update premi list");
    List<DropdownMenuItem<InsurancePremiModel>> _items = [];

    data.insurances.forEach((insurance) {
      insurance.insurancePremiList.forEach((premi) {
        if (data.selectedInsurance == null) {
          data.selectedInsurance = premi;
        }
        _items.add(DropdownMenuItem<InsurancePremiModel>(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${premi.premiName ?? "-"}",
              ),
              Text(
                "Rp. ${NumberFormat("#,###", System.data.resource.locale).format(premi.insuranceAmount)}",
              ),
            ],
          ),
          value: premi,
        ));
      });
    });
    return _items;
  }

  void getAllInsuranceCategory() {
    data.loadingController.startLoading();
    InsuraceCategoryModel.get(
      token: System.data.global.token,
    ).then((value) {
      data.loadingController.stopLoading();
      data.insurancesCategory = value;
      data.selectedInsuranceCategory = value.first;
      print("total insurance Category ${data.insurancesCategory.length}");
      print("value insurance category");
      print("${data.insurancesCategory.map((e) => e.toJson())}");
      data.commit();
    }).catchError(
      (onError) {
        data.loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError),
          ),
        );
      },
    );
  }

  List<DropdownMenuItem<InsuraceCategoryModel>>
      getDropDownInsuranceCategoryItem() {
    List<DropdownMenuItem<InsuraceCategoryModel>> _items = [];

    data.insurancesCategory.forEach((insurance) {
      _items.add(
        DropdownMenuItem<InsuraceCategoryModel>(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${insurance.insuranceTypeName ?? "-"}",
              ),
            ],
          ),
          value: insurance,
        ),
      );
    });
    return _items;
  }
}
