import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/module/ratingDriver/presenter.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

mixin TmsPresenter on PresenterState {
  @override
  void onError(dynamic onError) {
    loadingController.stopLoading(
      messageAlign: Alignment.topCenter,
      messageWidget: DecorationComponent.topMessageDecoration(
        message: ErrorHandlingUtil.handleApiError(onError),
      ),
    );
  }

  @override
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
}
