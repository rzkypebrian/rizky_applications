import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/model/AttendanceModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

import 'presenter.dart';

mixin ConfirmAttendacePresenter on PresenterState {
  @override
  void getAtttendanceList() {
    return;
  }

  @override
  void submit() {
    model.loadingController.startLoading();
    AttendanceModel.confirm(
      token: System.data.global.token,
      attendanceModel: model.attendanceModel,
    ).then((value) {
      model.loadingController.stopLoading(
          isError: true,
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: System.data.resource.yourReportHasBeenSend,
          ),
          onFinishCallback: () {
            if (widget.onSubmited != null) {
              widget.onSubmited(model.attendanceModel);
            }
          });
    }).catchError(
      (onError) {
        model.loadingController.stopLoading(
          isError: true,
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError,
                prefix: "Confirm Attendance Failed \n"),
          ),
        );
      },
    );
  }
}
