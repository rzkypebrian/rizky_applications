import 'package:enerren/app/angkut/aCustomer/LocalData.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/model/CustomerModel.dart';
import 'package:enerren/module/inputPhoneNumber/presenter.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

mixin CustomerPresenter on PresenterState {
  void submit() {
    if (!validate()) return;
    super.model.loadingController.startLoading();
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
    _customer.customerMobile =
        model.phoneController.text.replaceFirst("+62", "0");
    _customer.imageUrl = null;
    CustomerModel.updateProfile(
        token: System.data.global.token,
        customerModel: _customer,
        otp: "",
        on403: (onValue) {
          if (widget.onSubmitSuccess != null) {
            widget.onSubmitSuccess((onValue.body.toString()));
            model.loadingController.stopLoading();
          } else {
            print("phone number is ${model.phoneController.text}");
          }
        }).then((onValue) {}).catchError(
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
