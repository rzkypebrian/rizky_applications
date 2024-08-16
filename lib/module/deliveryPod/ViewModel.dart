import 'dart:io';

import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/barcodeReaderComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/imagePickerComponent.dart';
import 'package:enerren/component/liveCameraComponent.dart';
import 'package:enerren/component/multipleImagePickerComponent.dart';
import 'package:enerren/component/signatureComponent.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  bool takeLiveCamera = false;
  UriData byteLiveCamera;
  bool onTakePicture = false;
  bool isSignatureValid = true;
  bool takeCamera = false;
  File imageCamera;
  String scanBarcode = 'Unknown';
  bool isValidImagePicker = true;
  bool isValidPhoto;

  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();
  InputComponentTextEditingController receiverController =
      new InputComponentTextEditingController();
  StateInput receiverStateInput = StateInput.Enable;
  InputComponentTextEditingController barcodeController =
      new InputComponentTextEditingController();
  StateInput barcodeStateInput = StateInput.Enable;
  MultipleImagePickerController imagePickerControllers =
      MultipleImagePickerController();
  SignatureComponentController signatureComponentController =
      SignatureComponentController();
  BarcodeReaderComponentController barcodeReaderComponentController =
      new BarcodeReaderComponentController();
  LiveCameraComponentController liveCameraComponentController =
      new LiveCameraComponentController();
  ImagePickerController receiverImagePickerControllers =
      ImagePickerController();

  void copyFrom(ViewModel viewModel) {
    receiverImagePickerControllers = viewModel.receiverImagePickerControllers;
    receiverController = viewModel.receiverController;
    imagePickerControllers = viewModel.imagePickerControllers;
    signatureComponentController = viewModel.signatureComponentController;
    barcodeController = viewModel.barcodeController;
  }

  void commit() {
    notifyListeners();
  }
}
