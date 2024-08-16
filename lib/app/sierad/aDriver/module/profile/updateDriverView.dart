import 'package:enerren/app/sierad/aDriver/module/profile/updateDriverPresenter.dart';
import 'package:enerren/module/profile/main.dart';
import 'package:enerren/app/sierad/module/profile/main.dart';
import 'package:flutter/material.dart';
import 'driverView.dart';

class UpdateDriverView extends DriverView
    with InputProfile, UpdateDriverPresenter {
  @override
  Widget home() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            imageProfile(),
            SizedBox(
              height: 20,
            ),
            inputName(readOnly: true),
            inputEmail(readOnly: true),
            inputAddress(readOnly: true),
          ],
        ),
      ),
    );
  }
}
