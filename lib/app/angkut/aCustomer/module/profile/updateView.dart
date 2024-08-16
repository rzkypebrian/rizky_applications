import 'package:enerren/app/angkut/aCustomer/module/profile/updatePresenter.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/CustomerModel.dart';
import 'package:enerren/module/profile/main.dart';
import 'package:enerren/app/sierad/module/profile/main.dart';
import 'package:flutter/material.dart';
import 'customerView.dart';

class UpdateView extends CustomerView with InputProfile, UpdatePresenter {
  final Function(String, CustomerModel, VoidCallback) onValidatePhone;

  UpdateView({this.onValidatePhone}) {
    super.onValidatePhone = this.onValidatePhone;
  }

  @override
  Widget home() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            imageProfile(
              readOnly: false,
            ),
            SizedBox(
              height: 20,
            ),
            inputName(readOnly: false),
            inputEmail(readOnly: false),
            inputPhone(readOnly: false),
            inputAddress(readOnly: false),
          ],
        ),
      ),
    );
  }

  Widget circularProgressIndicator(
      CircularProgressIndicatorController controller) {
    return DecorationComponent.circularLOadingIndicator(controller: controller);
  }
}
