import 'package:enerren/component/imagePickerComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/tmsDeliveryPodModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'productOnlyView.dart';
import 'ViewModel.dart';

class ProductOnlyPresenter extends StatefulWidget {
  final String title;
  final ValueChanged<ViewModel> onSubmit;
  final ViewModel viewModel;
  final int imageQuality;
  final int destinationId;
  final bool isPod;
  final bool loadUploadedImage;

  ProductOnlyPresenter({
    Key key,
    this.title,
    this.onSubmit,
    this.viewModel,
    this.imageQuality,
    this.destinationId,
    this.isPod,
    this.loadUploadedImage = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductOnlyView();
  }
}

abstract class ProductOnlyPresenterState extends State<ProductOnlyPresenter> {
  ViewModel model = new ViewModel();

  @override
  void initState() {
    if (widget.viewModel != null) {
      model.copyFrom(widget.viewModel);
    }
    model.loadingController.stopLoading();
    if (widget.loadUploadedImage) getPodProductImage();
    super.initState();
    model.loadingController.stopLoading();
  }

  bool validateProductImage() {
    if (model.imagePickerControllers.validate() &&
        model.imagePickerControllers.value.imagePickerControllers.length > 0) {
      model.isValidImagePicker = true;
      model.commit();
      return null;
    } else {
      model.isValidImagePicker = false;
      model.commit();
      return false;
    }
  }

  bool validate() {
    bool isValid = true;
    isValid = validateProductImage() ?? isValid;
    return isValid;
  }

  void submit() {
    if (!validate()) return;
    if (widget.onSubmit != null) {
      widget.onSubmit(model);
    }
  }

  Future<bool> onDeleteImage(
      ImagePickerController imagePickerController) async {
    if (imagePickerController.value.state != ImagePickerComponentState.Error) {
      return TmsDeliveryPodModel.deletePodProductImage(
        destinationId: widget.destinationId,
        imageId: imagePickerController.value.uploadedId,
        token: System.data.global.token,
      ).then((value) {
        return true;
      }).catchError(
        (onError) {
          model.loadingController.stopLoading(
              messageAlign: Alignment.topCenter,
              messageWidget: DecorationComponent.topMessageDecoration(
                message: ErrorHandlingUtil.handleApiError(onError),
              ));
          return false;
        },
      );
    } else {
      return true;
    }
  }

  void getPodProductImage() {
    print("get uploaded image");
    model.loadingController.startLoading();
    TmsDeliveryPodModel.get(
      token: System.data.global.token,
      destinationId: widget.destinationId,
    ).then((value) {
      print(
          "get uploaded image ${model.imagePickerControllers.value.imagePickerControllers.length}");
      model.loadingController.stopLoading();
      if (value.productPhoto.isNotEmpty) {
        model.imagePickerControllers.value.imagePickerControllers = [];
        value.productPhotoDetail.forEach((e) {
          model.imagePickerControllers.value.imagePickerControllers.add(
            new ImagePickerController(
              value: new ImagePickerValue(
                uploadedId: e.imageId,
                uploadedUrl: e.imageUrl,
                loadData: true,
              ),
            ),
          );
          model.commit();
        });
      }
    }).catchError(
      (onError) {
        model.loadingController.stopLoading(
          isError: true,
          message: "${ErrorHandlingUtil.handleApiError(onError)}",
          messageWidget: DecorationComponent.topMessageDecoration(
            message: "${ErrorHandlingUtil.handleApiError(onError)}",
          ),
        );
      },
    );
  }
}
