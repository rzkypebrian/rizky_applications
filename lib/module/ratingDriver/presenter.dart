import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/ratingComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/tmsRatingModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/util/StringExtention.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'viewModel.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final String driverImageUrl;
  final String driverName;
  final int shipmentId;
  final int memberId;
  final int driverId;
  final String driverNik;
  final String customerNo;
  final VoidCallback onSubmitSuccess;
  final bool coomentIsRequired;

  const Presenter({
    Key key,
    this.view,
    this.driverImageUrl,
    this.driverName,
    this.shipmentId,
    this.memberId,
    this.driverId,
    this.driverNik,
    this.customerNo,
    this.onSubmitSuccess,
    this.coomentIsRequired = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  ViewModel model = new ViewModel();
  InputComponentTextEditingController commentController =
      new InputComponentTextEditingController();
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();
  RatingController ratingController = new RatingController();

  @override
  void initState() {
    super.initState();
    loadingController.stopLoading();
  }

  bool validateComment() {
    if (widget.coomentIsRequired == false) return null;
    if (commentController.text.isNullOrEmpty()) {
      commentController.setStateInput = StateInput.Error;
      return false;
    } else {
      commentController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validate() {
    bool valid = true;
    valid = validateComment() ?? valid;
    print(valid);
    return valid;
  }

  void submit() {
    if (!validate()) return;
    loadingController.startLoading();
    ModeUtil.debugPrint(ratingController.value.score);
    TmsRatingModel.add(
        token: System.data.global.token,
        param: new TmsRatingModel(
          shipmentId: widget.shipmentId,
          memberId: widget.memberId,
          ratingValue: ratingController.value.score,
          comment: commentController.text,
          driverId: widget.driverId,
          driverNik: widget.driverNik,
          customerNo: widget.customerNo,
        )).then((onValue) {
      onSuccess();
    }).catchError(
      (onError) {
        loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError),
          ),
        );
      },
    );
  }

  void onSuccess() {
    loadingController.stopLoading(
      onFinishCallback: onFinishCallback,
      messageAlign: Alignment.topCenter,
      messageWidget: DecorationComponent.topMessageDecoration(
        backgroundColor: System.data.colorUtil.greenColor,
        message: "${System.data.resource.thankYouForYourRating}",
      ),
    );
  }

  void onFinishCallback() {
    if (widget.onSubmitSuccess != null) {
      widget.onSubmitSuccess();
    } else {
      ModeUtil.debugPrint("sent rating success");
    }
  }

  void onError(dynamic onError) {
    loadingController.stopLoading(
      messageAlign: Alignment.topCenter,
      messageWidget: DecorationComponent.topMessageDecoration(
        message: ErrorHandlingUtil.handleApiError(onError),
      ),
    );
  }
}
