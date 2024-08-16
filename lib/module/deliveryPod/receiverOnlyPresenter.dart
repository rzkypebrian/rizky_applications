import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/tmsDeliveryPodModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'receiverOnlyView.dart';
import 'ViewModel.dart';
import 'package:enerren/util/StringExtention.dart';

class ReceiverOnlyPresenter extends StatefulWidget {
  final String title;
  final ValueChanged<ViewModel> onSubmit;
  final int imageQuality;
  final int minimumMemoryRequirement;
  final String senderLabel;
  final String senderNameLabel;
  final int destinationId;
  final bool isPod;
  final bool loadUploadedImage;
  final ViewModel viewModel;

  const ReceiverOnlyPresenter({
    Key key,
    this.title,
    this.onSubmit,
    this.imageQuality,
    this.senderLabel,
    this.senderNameLabel,
    this.destinationId,
    this.isPod,
    this.loadUploadedImage = true,
    this.viewModel,
    this.minimumMemoryRequirement,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ReceiverOnlyView();
  }
}

abstract class ReceiverOnlyPresenterState extends State<ReceiverOnlyPresenter> {
  ViewModel model = new ViewModel();

  @override
  void initState() {
    if (widget.viewModel != null) {
      model.copyFrom(widget.viewModel);
    }
    super.initState();
    model.loadingController.stopLoading();
    if (widget.loadUploadedImage) getReceiverImage();
  }

  bool validateReceiverImage() {
    if (model.receiverImagePickerControllers.validate()) {
      return null;
    } else {
      return false;
    }
  }

  bool validateReceiverName() {
    if (model.receiverController.text.isEmpty) {
      model.receiverController.setStateInput = StateInput.Error;
      model.commit();
      return false;
    } else {
      model.receiverController.setStateInput = StateInput.Enable;
      model.commit();
      return null;
    }
  }

  bool validate() {
    bool isValid = true;
    isValid = validateReceiverImage() ?? isValid;
    isValid = validateReceiverName() ?? isValid;
    return isValid;
  }

  void submit() {
    if (!validate()) return;
    if (widget.onSubmit != null) {
      widget.onSubmit(model);
    }
  }

  void getReceiverImage() {
    print("get uploaded image");
    model.loadingController.startLoading();
    TmsDeliveryPodModel.get(
      token: System.data.global.token,
      destinationId: widget.destinationId,
    ).then(
      (value) {
        model.loadingController.stopLoading();
        if (!value.receiverPhoto.isNullOrEmpty()) {
          print("get uploaded image is ${value.receiverPhoto}");
          model.receiverImagePickerControllers.value.isUploaded = true;
          model.receiverImagePickerControllers.value.loadData = true;
          model.receiverImagePickerControllers.value.uploadedUrl =
              value.receiverPhoto;
          model.receiverController.text = value.receiverName;
          model.receiverImagePickerControllers.commit();
          model.commit();
        }
      },
    ).catchError(
      (onError) {
        model.loadingController.stopLoading(
            isError: true,
            message: "${ErrorHandlingUtil.handleApiError(onError)}",
            messageWidget: DecorationComponent.topMessageDecoration(
              message: "${ErrorHandlingUtil.handleApiError(onError)}",
            ));
      },
    );
  }
}
