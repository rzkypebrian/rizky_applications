import 'dart:convert';

import 'package:enerren/app/angkut/aCustomer/LocalData.dart';
import 'package:enerren/model/CustomerModel.dart';
import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/module/profile/main.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

mixin UpdatePresenter on PresenterState {
  Function(String, CustomerModel, VoidCallback) onValidatePhone;

  bool validate() {
    bool valid = true;
    valid = validateName() ?? valid;
    valid = validateEmail() ?? valid;
    valid = validatePhone() ?? valid;
    valid = validateAddress() ?? valid;
    return valid;
  }

  @override
  void submit() {
    ModeUtil.debugPrint("masuk sini");
    CustomerModel customer = System.data.getLocal<LocalData>().user;
    if (validate()) {
      customer.imageUrl = imagePickerController.getBase64();
      customer.customerName = nameController.text;
      customer.customerEmail = emailController.text;
      customer.customerAddress = addressController.text;
      customer.customerMobile = phoneController.text;
      updateProfileCustomer(customer);
    }
  }

  void updateProfileCustomer(CustomerModel customer, {String otp}) {
    loadingController.startLoading();
    CustomerModel.updateProfile(
        token: System.data.global.token,
        customerModel: customer,
        otp: otp,
        on403: (response) {
          loadingController.stopLoading();
          onValidatePhone(
              json.decode(response.body)["otpCode"],
              customer,
              () => updateProfileCustomer(
                    customer,
                    otp: json.decode(response.body)["otpCode"],
                  ));
        }).then((value) {
      loadingController.stopLoading();
      if (value.customerId == null) return;
      ModeUtil.debugPrint("update profile tetap dilakukan $value");
      System.data.getLocal<LocalData>().user = value;
      System.commit();
      widget.onUpdateSuccess(profileModel);
      ModeUtil.debugPrint(System.data.getLocal<LocalData>().user.imageUrl);
    }).catchError((onError) {
      loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: ErrorHandlingUtil.handleApiError(onError),
        ),
      );
    });
  }
}
