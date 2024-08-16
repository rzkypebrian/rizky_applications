import 'package:enerren/component/InputComponent.dart';
import 'package:flutter/material.dart';
import 'view.dart';
import 'ViewModel.dart';
import 'package:enerren/util/StringExtention.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final String receiverNameLabel;

  const Presenter({
    this.receiverNameLabel,
    Key key,
    this.view,
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
  ViewModel model = new ViewModel();

  @override
  void initState() {
    super.initState();
    model.loadingController.stopLoading();
  }

  void onSign() {
    model.liveCameraComponentController.takePicture();
  }

  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  bool validateReceiver() {
    if (model.receiverController.text.isEmpty) {
      model.receiverController.setStateInput = StateInput.Error;
      return false;
    } else {
      model.receiverController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validateImagePicker() {
    model.imagePickerControllers.setState(() {
      if (model.imagePickerControllers.length() <= 0) {
        model.isValidImagePicker = false;
      } else {
        model.isValidImagePicker = model.imagePickerControllers.validate();
      }
    });
    return model.isValidImagePicker == true ? null : model.isValidImagePicker;
  }

  bool validatePod() {
    model.signatureComponentController.setState(() {
      model.isSignatureValid =
          model.signatureComponentController.getBase64.isNullOrEmpty()
              ? false
              : true;
    });
    return model.isSignatureValid == true ? null : false;
  }

  bool validateBarcode() {
    if (model.barcodeController.text.isEmpty) {
      model.barcodeController.setStateInput = StateInput.Error;
      return false;
    } else {
      model.barcodeController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validatePhoto() {
    if (model.liveCameraComponentController.value.base64Image.isNullOrEmpty()) {
      model.liveCameraComponentController.setState(() {
        model.isValidPhoto = false;
      });
      return false;
    } else {
      model.liveCameraComponentController.setState(() {
        model.isValidPhoto = true;
      });
      return null;
    }
  }

  bool validate() {
    bool isValid = true;
    isValid = validateReceiver() ?? isValid;
    isValid = validateImagePicker() ?? isValid;
    // isValid = validateBarcode() ?? isValid;
    isValid = validatePod() ?? isValid;
    isValid = validatePhoto() ?? isValid;
    return isValid;
  }

  void submit() {
    validate();
  }

  void setBarcode(String result) {
    setState(() {
      model.barcodeController.text = result;
    });
  }
}
