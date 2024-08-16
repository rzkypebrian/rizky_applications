//import 'package:enerren/model/AttendanceItemModel.dart';
import 'dart:convert';

import 'package:enerren/component/imagePickerComponent.dart';
import 'package:enerren/component/multipleImagePickerComponent.dart';
import 'package:enerren/model/AttendanceItemModel.dart';
import 'package:enerren/model/AttendanceModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'viewModel.dart';
import 'view.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final AttendanceModel attendanceModel;
  final ValueChanged<AttendanceModel> onSubmited;

  const Presenter({
    Key key,
    this.view,
    this.onSubmited,
    this.attendanceModel,
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

  @override
  void initState() {
    super.initState();
    model.attendanceModel = widget.attendanceModel ?? model.attendanceModel;
    model.loadingController.stopLoading();
    getAtttendanceList();
  }

  void submit() {
    model.loadingController.startLoading();
    AttendanceModel.add(
      token: System.data.global.token,
      attendanceModel: model.attendanceModel,
    ).then((value) {
      model.loadingController.stopLoading();
      model.attendanceModel = value;
      if (widget.onSubmited != null) {
        widget.onSubmited(model.attendanceModel);
      }
    }).catchError(
      (onError) {
        model.loadingController.stopLoading(
          isError: true,
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError,
                prefix: "Add Attendance Failed \n"),
          ),
        );
      },
    );
  }

  void getAtttendanceList() {
    model.loadingController.startLoading();
    AttendanceItemModel.getVehicleAttendance(
      token: System.data.global.token,
    ).then((onValue) {
      model.attendanceModel.listItemAttendance = onValue.toList();
      model.loadingController.stopLoading();
      model.commit();
    }).catchError(
      (onError) {
        model.loadingController.stopLoading(
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError),
          ),
        );
      },
    );
  }

  void addValueToImmagePicker({
    String typeCode,
    MultipleImagePickerController controller,
  }) {
    try {
      (json.decode(model.attendanceModel.listItemAttendance
              .where((e) => e.typeCode == typeCode)
              .first
              .value) as List)
          .forEach(
        (e) {
          controller.value.imagePickerControllers.add(new ImagePickerController(
              value: ImagePickerValue(
            base64: !e.toString().startsWith(new RegExp(r'http')) ? e : null,
            base64Compress:
                !e.toString().startsWith(new RegExp(r'http')) ? e : null,
            uploadedUrl:
                e.toString().startsWith(new RegExp(r'http')) ? e : null,
            valueUri: !e.toString().startsWith(new RegExp(r'http'))
                ? Uri.parse(e).data
                : null,
            loadData: true,
            state: ImagePickerComponentState.Enable,
          )));
        },
      );
    } catch (e) {}
  }

  void updateValueFromMultiplePicker({
    String typeCode,
    MultipleImagePickerController controller,
  }) {
    model.attendanceModel.listItemAttendance
        .where((e) => e.typeCode == typeCode)
        .first
        .value = json.encode(controller.getBase64Compress());
  }
}
