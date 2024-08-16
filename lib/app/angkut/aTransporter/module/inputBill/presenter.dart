import 'package:enerren/app/angkut/model/AngkutBill.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/multipleImagePickerComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:enerren/component/dateTImePicker.dart' as dateTimePicker;
import 'package:enerren/util/StringExtention.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;

  const Presenter({Key key, this.view}) : super(key: key);

  createState() {
    if (view != null) {
      return view;
    } else {
      // return View();
      return DetailInpunBill();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  ViewModel viewModel = ViewModel();

  bool isValidImagePicker;
  DateTime selectedDate;

  InputComponentTextEditingController accountNumber =
      new InputComponentTextEditingController();
  InputComponentTextEditingController accounHolderName =
      new InputComponentTextEditingController();
  InputComponentTextEditingController datePay =
      new InputComponentTextEditingController();
  InputComponentTextEditingController totalPay =
      new InputComponentTextEditingController();
  MultipleImagePickerController imagePickerControllers =
      MultipleImagePickerController();

  Future<Null> selectDate(BuildContext context) async {
    dateTimePicker
        .showDateTimePicker(context,
            datePickerSetting: System.data.themeUtil.datePickerTheme(
              initialDate: DateTime.now().add(Duration(days: (365 * 30) * -1)),
            ),
            mode: dateTimePicker.PickerMode.Date)
        .then((date) {
      if (date != null) selectedDate = date;
      // viewModel.birthdate = date;
      datePay.text = "${date.day}/${date.month}/${date.year}";
    });
  }

  void saveData() {
    if (validate()) {
      viewModel.angkutBill = AngkutBill(
        accounHolderName: accounHolderName.text,
        accountNumber: accountNumber.text,
        bankName: viewModel.bank,
        datePay: selectedDate,
        debtTotal: double.parse(totalPay.text),
      );
    }
  }

  bool validate() {
    bool isValid = true;
    isValid = validateAccountNumber() ?? isValid;
    isValid = validateAccounHolderName() ?? isValid;
    isValid = validatDatePay() ?? isValid;
    isValid = validateTotalPay() ?? isValid;
    isValid = validateImagePicker() ?? isValid;
    return isValid;
  }

  bool validateImagePicker() {
    imagePickerControllers.setState(() {
      if (imagePickerControllers.length() <= 0) {
        isValidImagePicker = false;
      } else {
        isValidImagePicker = imagePickerControllers.validate();
      }
    });
    return isValidImagePicker == true ? null : isValidImagePicker;
  }

  bool validateAccountNumber() {
    if (accountNumber.text.isNullOrEmpty()) {
      accountNumber.setStateInput = StateInput.Error;
      return false;
    } else {
      accountNumber.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validateBankName() {
    if (viewModel.bank.isNullOrEmpty()) {
      return false;
    } else {
      return null;
    }
  }

  bool validateAccounHolderName() {
    if (accountNumber.text.isNullOrEmpty()) {
      accounHolderName.setStateInput = StateInput.Error;
      return false;
    } else {
      accounHolderName.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validatDatePay() {
    if (accountNumber.text.isNullOrEmpty()) {
      datePay.setStateInput = StateInput.Error;
      return false;
    } else {
      datePay.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validateTotalPay() {
    if (accountNumber.text.isNullOrEmpty()) {
      totalPay.setStateInput = StateInput.Error;
      return false;
    } else {
      totalPay.setStateInput = StateInput.Enable;
      return null;
    }
  }
}
