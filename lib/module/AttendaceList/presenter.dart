import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/AttendanceModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';
import 'viewModel.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<AttendanceModel> onTapAttendance;

  const Presenter({Key key, this.view, this.onTapAttendance}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter>
    with SingleTickerProviderStateMixin {
  ViewModel model = new ViewModel();
  InputComponentTextEditingController searchController =
      new InputComponentTextEditingController();

  @override
  void initState() {
    super.initState();
    model.loadingController.stopLoading();
    model.tabController =
        TabController(vsync: this, length: 2, initialIndex: 0);
    getAttendaceDaily();
    //..addListener(() => model.setCurrentIndexTab = model.tabController.index);
  }

  void onTapAttendance(AttendanceModel am) {
    if (widget.onTapAttendance != null) {
      widget.onTapAttendance(am);
    }
  }

  void getAttendaceDaily() {
    model.loadingController.startLoading();
    AttendanceModel.dailyAttendance(
      token: System.data.global.token,
    ).then((value) {
      model.attendances = value;
      model.loadingController.stopLoading();
      model.commit();
    }).catchError(
      (onError) {
        model.loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError),
          ),
        );
      },
    );
  }
}
