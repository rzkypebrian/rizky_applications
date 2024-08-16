import 'dart:ui';

import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/module/register/view.dart';
import 'package:enerren/module/register/viewModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/component/dateTImePicker.dart' as dateTimePicker;

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged2Param<ViewModel, Map<String, dynamic>> onSubmitSuccess;
  final bool validatePhoneNumber;
  final VoidCallback onTapTermAndCondition;
  final VoidCallback onTapPrivacyPolicy;

  const Presenter({
    Key key,
    this.view,
    this.onSubmitSuccess,
    this.validatePhoneNumber = true,
    this.onTapTermAndCondition,
    this.onTapPrivacyPolicy,
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
  //Object id;
  ViewModel viewModel = new ViewModel();

  InputComponentTextEditingController phoneController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController emailController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController nameController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController birthdateController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController addressController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController selectedController =
      new InputComponentTextEditingController();
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  FocusNode phoneFocus = new FocusNode();
  FocusNode emailFocus = new FocusNode();
  FocusNode nameFocus = new FocusNode();
  FocusNode birthdateFocus = new FocusNode();
  FocusNode addressFocus = new FocusNode();

  DateTime selectedDate;
  StateInput dateState;
  final FocusNode dateFocus = FocusNode();
  List<DropdownMenuItem<int>> dropdownMenuInterval;
  int currentInterval = 30;

  Future<Null> selectDate(BuildContext context) async {
    dateTimePicker
        .showDateTimePicker(context,
            datePickerSetting: System.data.themeUtil.datePickerTheme(
                initialDate: DateTime.now().add(
                  Duration(days: (365 * 30) * -1),
                ),
                firstDate:
                    DateTime.now().add(Duration(days: (365 * 150)) * -1)),
            mode: dateTimePicker.PickerMode.Date)
        .then((date) {
      if (date != null) selectedDate = date;
      viewModel.birthdate = date;
      birthdateController.text = "${date.day}/${date.month}/${date.year}";
    });
  }

  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  @override
  void initState() {
    super.initState();
    //id = widget.id;
    emailController.text = System.data.global.registerModel?.email;
    nameController.text = System.data.global.registerModel?.fullName;
    viewModel.loadingController.stopLoading();
    loadingController.stopLoading();
    initMainPage();
  }

  void initMainPage() {
    nameController.text = viewModel.name;
    emailController.text = viewModel.email;
    phoneController.text = viewModel.phone;
    addressController.text = viewModel.address;
  }

  void submit() {
    if (!validate()) return;
    viewModel.loadingController.startLoading();
    if (widget.validatePhoneNumber == true) {
      AccountModel.validatePhoneNumber(
        token: System.data.global.token,
        phoneNumber: viewModel.phone,
      ).then((onValue) {
        ModeUtil.debugPrint(onValue);
        if (widget.onSubmitSuccess != null) {
          widget.onSubmitSuccess(viewModel, onValue);
        }
        viewModel.loadingController.stopLoading();
      }).catchError((onError) {
        viewModel.loadingController.stopLoading();
        loadingController.stopLoading(
            messageAlign: Alignment.topCenter,
            messageWidget: DecorationComponent.topMessageDecoration(
              message: ErrorHandlingUtil.handleApiError(onError),
            ));
      });
    } else {
      if (widget.onSubmitSuccess != null) {
        widget.onSubmitSuccess(viewModel, {});
      }
      viewModel.loadingController.stopLoading();
    }
  }

  bool validate() {
    bool valid = true;
    valid = validateName() ?? valid;
    valid = validateEmail() ?? valid;
    // valid = validateBirtdate() ?? valid;
    valid = validatePhone() ?? valid;
    valid = validateAddress() ?? valid;
    if (valid) valid = validateAgreement() ?? valid;

    return valid;
  }

  bool validateEmail() {
    if (emailController.text.isEmpty) {
      emailFocus.requestFocus();
      emailController.setStateInput = StateInput.Error;
      return false;
    } else {
      if (!RegExp(ConstantUtil.regexEmailPhatern)
          .hasMatch(emailController.text)) {
        loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: System.data.resource.emailAddressNotValid,
          ),
        );
        emailController.setStateInput = StateInput.Error;
        return false;
      } else {
        emailController.setStateInput = StateInput.Enable;
        return null;
      }
    }
  }

  bool validateName() {
    if (nameController.text.isEmpty) {
      nameFocus.requestFocus();
      nameController.setStateInput = StateInput.Error;
      return false;
    } else {
      nameController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validatePhone() {
    if (phoneController.text.isEmpty ||
        phoneController.stateInput == StateInput.Error) {
      phoneFocus.requestFocus();
      phoneController.setStateInput = StateInput.Error;
      return false;
    } else {
      viewModel.phone = phoneController.text.replaceFirst("+62", "0");
      return null;
      // if (!RegExp(ConstantUtil.regexPhoneNumberPhatern)
      //     .hasMatch(phoneController.text)) {
      //   loadingController.stopLoading(
      //     messageAlign: Alignment.topCenter,
      //     messageWidget: DecorationComponent.topMessageDecoration(
      //       message: System.data.resource.formatPhoneNumberNotValid,
      //     ),
      //   );
      //   phoneController.setStateInput = StateInput.Error;
      //   return false;
      // } else {
      //   phoneController.setStateInput = StateInput.Enable;
      //   return null;
      // }
    }
  }

  bool validateAddress() {
    if (addressController.text.isEmpty) {
      addressFocus.requestFocus();
      addressController.setStateInput = StateInput.Error;
      return false;
    } else {
      addressController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validateBirtdate() {
    if (birthdateController.text.isEmpty) {
      birthdateFocus.requestFocus();
      birthdateController.setStateInput = StateInput.Error;
      return false;
    } else {
      birthdateController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validateAgreement() {
    if (viewModel.isAgree) {
      return null;
    } else {
      loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            backgroundColor: System.data.colorUtil.redColor,
            message:
                System.data.resource.pleaseCheckTermConditionAndPrivacyPolicy,
          ));
      return false;
    }
  }

  void onTapTermAndCondition() {
    if (widget.onTapTermAndCondition != null) {
      widget.onTapTermAndCondition();
    }
  }

  void onTapPrivacyPolicy() {
    if (widget.onTapPrivacyPolicy != null) {
      widget.onTapPrivacyPolicy();
    }
  }
}
