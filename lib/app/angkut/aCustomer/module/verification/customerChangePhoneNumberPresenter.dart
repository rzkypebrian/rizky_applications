import 'dart:convert';

import 'package:enerren/app/angkut/aCustomer/LocalData.dart';
import 'package:enerren/app/angkut/module/verification/changePhoneNumberPresenter.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/model/CustomerModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

mixin CustomerChangePhoneNumberPresenter on ChangePhoneNumberPresenter {
  bool isFirst = true;

  void initState() {
    super.initState();
  }

  @override
  void onValid() {
    changeProfile();
  }

  @override
  void resend() {
    print("masuk sini $isFirst");
    if (isFirst == true) {
      isFirst = false;
    } else {
      model.pin = null;
      changeProfile();
    }
  }

  void changeProfile() {
    CustomerModel _customer = new CustomerModel();
    _customer.customerId = System.data.getLocal<LocalData>().user.customerId;
    _customer.memberId = 0;
    _customer.customerEmail =
        System.data.getLocal<LocalData>().user.customerEmail;
    _customer.customerName =
        System.data.getLocal<LocalData>().user.customerName;
    _customer.customerStatus =
        System.data.getLocal<LocalData>().user.customerStatus;
    _customer.customerType =
        System.data.getLocal<LocalData>().user.customerType;
    _customer.customerMobile = widget.phoneNumber.replaceFirst("+62", "0");
    _customer.imageUrl = null;
    CustomerModel.updateProfile(
        token: System.data.global.token,
        customerModel: _customer,
        otp: model.pin,
        on403: (onValue) {
          model.verificationCode =
              json.decode(onValue.body.toString())["otpCode"];
          reset();
          model.timerCountDownController.reset();
          model.timerCountDownController.start(onTick: readInbox);
          model.loadingController.stopLoading();
          throw "";
        }).then((onValue) {
      model.loadingController.stopLoading();
      if (widget.onVerificationValid != null) {
        widget.onVerificationValid(json.encode(onValue.toJson()));
      }
    }).catchError(
      (onError) {
        if (onError.toString().isNotEmpty) {
          model.loadingController.stopLoading(
            messageAlign: Alignment.topCenter,
            messageWidget: DecorationComponent.topMessageDecoration(
              message: ErrorHandlingUtil.handleApiError(onError),
            ),
          );
        }
      },
    );
  }
}
