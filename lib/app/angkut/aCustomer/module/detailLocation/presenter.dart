import 'package:enerren/app/angkut/aCustomer/module/detailLocation/viewModel.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/AngkutDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:native_contact_picker/native_contact_picker.dart';
import 'view.dart';
import 'package:enerren/util/StringExtention.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<ViewModel> onSelectLocation;
  final ValueChanged<ViewModel> onSubmit;
  final ObjectBuilder<ViewModel> data;
  final ValueChanged<ViewModel> onInitData;
  final String contactNameLabel;
  final String phoneNumberLabel;
  final bool usePhoneNumberField;
  final bool useSenderNameField;
  final bool requiredAdditionalInfo;

  Presenter({
    this.view,
    this.onSelectLocation,
    this.onSubmit,
    this.data,
    this.onInitData,
    this.contactNameLabel,
    this.phoneNumberLabel,
    this.usePhoneNumberField = true,
    this.useSenderNameField = true,
    this.requiredAdditionalInfo = false,
  });

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
  final NativeContactPicker contactPicker = new NativeContactPicker();
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();
  InputComponentTextEditingController addressController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController detailAddressController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController nameController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController phoneNumberController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController noteForDriver =
      new InputComponentTextEditingController();

  ViewModel model;

  @required
  initState() {
    super.initState();
    phoneNumberController.useCustomeText = false;
    loadingController.stopLoading();
    if (widget.data != null) {
      model = widget.data();
      if (model == null) {
        model = new ViewModel();
      }
    } else {
      model = new ViewModel();
      if (widget.onInitData != null) {
        widget.onInitData(model);
        model.commit();
      }
    }
  }

  bool validateLocation() {
    if (model.address.isNullOrEmpty() ||
        model.lat == null ||
        model.lon == null) {
      addressController.setStateInput = StateInput.Error;
      return false;
    } else {
      addressController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validateDetailAdress() {
    if (model.detailAdress.isNullOrEmpty() ||
        detailAddressController.text.isNullOrEmpty()) {
      detailAddressController.setStateInput = StateInput.Error;
      return false;
    } else {
      detailAddressController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validateName() {
    if (model.name.isNullOrEmpty() || nameController.text.isNullOrEmpty()) {
      nameController.setStateInput = StateInput.Error;
      return false;
    } else {
      nameController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validatePhoneNumber() {
    if (model.phoneNumber.isNullOrEmpty() ||
        phoneNumberController.text.isNullOrEmpty()) {
      phoneNumberController.setStateInput = StateInput.Error;
      return false;
    } else {
      if (!RegExp(ConstantUtil.regexPhoneNumberPhatern)
          .hasMatch(phoneNumberController.text)) {
        loadingController.stopLoading(
            messageAlign: Alignment.topCenter,
            messageWidget: DecorationComponent.topMessageDecoration(
              message: System.data.resource.formatPhoneNumberNotValid,
            ));
        phoneNumberController.setStateInput = StateInput.Error;
        return false;
      } else {
        phoneNumberController.setStateInput = StateInput.Enable;
        return null;
      }
    }
  }

  bool validateAdditionalInfo() {
    if (widget.requiredAdditionalInfo == false) return null;
    if (model.detailAdress.isNullOrEmpty() ||
        noteForDriver.text.isNullOrEmpty()) {
      noteForDriver.setStateInput = StateInput.Error;
      return false;
    } else {
      noteForDriver.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validate() {
    bool isValid = true;
    isValid = validateLocation() ?? isValid;
    isValid = validateDetailAdress() ?? isValid;
    if (widget.useSenderNameField) isValid = validateName() ?? isValid;
    if (widget.usePhoneNumberField) isValid = validatePhoneNumber() ?? isValid;
    isValid = validateAdditionalInfo() ?? isValid;
    return isValid;
  }

  Future<void> pickContact() async {
    Contact contact = await contactPicker.selectContact();
    nameController.text = contact.fullName;
    phoneNumberController.text = contact.phoneNumber;
    model.name = contact.fullName;
    model.phoneNumber = contact.phoneNumber;
  }

  void selectLocation() {
    if (widget.onSelectLocation != null) {
      widget.onSelectLocation(model);
    }
  }

  void submit() {
    if (!validate()) return;
    if (widget.onSelectLocation != null) {
      widget.onSubmit(model);
    }
  }

  @override
  void dispose() {
    model.dispose();
    super.dispose();
  }
}
