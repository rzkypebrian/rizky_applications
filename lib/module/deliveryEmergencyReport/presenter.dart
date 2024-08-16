import 'dart:async';

import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/imagePickerComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final int shipmentId;
  final String shipmentNumber;
  final String customerName;
  final String fotoLabel;
  final String titleLabel;

  const Presenter({
    Key key,
    this.shipmentId,
    this.shipmentNumber,
    this.customerName,
    this.view,
    this.fotoLabel,
    this.titleLabel,
  }) : super(key: key);

  createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  ImagePickerController photoController = new ImagePickerController();

  InputComponentTextEditingController notedController =
      new InputComponentTextEditingController();
  StateInput noteState;
  FocusNode noteFocus = FocusNode();

  bool isCannotContinue = false;

  void report() {}

  List<int> imageBytes;
  static const baseImageEncoder = "data:image/jpeg;base64,";
  String base64Image = baseImageEncoder;

  bool validatePhoto() {
    if (photoController.value.fileImage == null) {
      photoController.state = ImagePickerComponentState.Error;
      return false;
    } else {
      photoController.state = ImagePickerComponentState.Enable;
      return null;
    }
  }

  bool validateNote() {
    if (notedController.text.isEmpty) {
      notedController.setStateInput = StateInput.Error;
      return false;
    } else {
      notedController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validate() {
    bool isValid = true;
    isValid = validatePhoto() ?? isValid;
    isValid = validateNote() ?? isValid;
    return isValid;
  }

  void submitEmergency() {
    if (validate()) {
      loadingController.startLoading();
      Timer.periodic(Duration(seconds: 3), (t) {
        t.cancel();
        notedController.text = "";
        photoController.clear();
        base64Image = baseImageEncoder;
        loadingController.stopLoading(
          message: System.data.resource.yourReportHasBeenSend,
        );
      });
    }
  }

  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  @override
  void initState() {
    super.initState();
    loadingController.stopLoading();
  }
}
