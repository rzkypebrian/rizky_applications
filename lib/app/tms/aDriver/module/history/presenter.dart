import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/listDataComponent.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';
import 'package:http/http.dart' as http;

class Presenter<T> extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<TmsShipmentModel<T>> onSelected;
  final String title;
  final List<TabName> tabs;

  const Presenter({
    Key key,
    this.view,
    this.onSelected,
    this.title,
    this.tabs = const [
      TabName.Process,
      TabName.Finish,
      TabName.Cancel,
    ],
  }) : super(key: key);

  createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState<T> extends State<Presenter>
    with TickerProviderStateMixin {
  InputComponentTextEditingController searchController =
      new InputComponentTextEditingController();

  ListDataComponentController<TmsShipmentModel<T>>
      listDataCurrentProcessController =
      new ListDataComponentController<TmsShipmentModel<T>>();

  ListDataComponentController<TmsShipmentModel<T>> listDataDoneController =
      new ListDataComponentController<TmsShipmentModel<T>>();

  ListDataComponentController<TmsShipmentModel<T>> listDataRejectController =
      new ListDataComponentController<TmsShipmentModel<T>>();

  TabController controller;
  final int currentProcess = 1;
  final int doneProcess = 2;
  final int rejectProcess = 3;
  int id = 0;
  @override
  void initState() {
    controller = new TabController(
      vsync: this,
      length: widget.tabs.length,
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  String imageSvg({int status = 1}) {
    var string;
    if (status == currentProcess) {
      string = "assets/icon_shipment_process.svg";
    } else if (status == doneProcess) {
      string = "assets/icon_shipment_success.svg";
    } else if (status == rejectProcess) {
      string = "assets/icon_shipment_failed.svg";
    }
    return string;
  }

  void onSelected(TmsShipmentModel<T> data) {
    if (widget.onSelected != null) {
      widget.onSelected(data);
    } else {
      ModeUtil.debugPrint("selected");
    }
  }

  Future getNewProcessShipment(
      TmsShipmentModel<T> data, ScrollController ctrl) async {
    listDataCurrentProcessController.value.loadingController.startLoading(
      coverScreen: false,
    );
    await TmsShipmentModel.getProcessed(
      token: System.data.global.token,
      limit: 10,
      withRoute: false,
      // shipmentId: data != null ? data.tmsShipmentId : 0,
      shipmentId: 0,
      isLowerThanId: false,
      searchKey: searchController.text,
    ).then((onValue) {
      // if (onValue.length > 0) {
      // if (data != null) {
      // listDataCurrentProcessController.value.data.remove(data);
      // listDataCurrentProcessController.value.data = [];
      // listDataCurrentProcessController.commit();
      // }
      listDataCurrentProcessController.value.data = onValue;
      listDataCurrentProcessController.commit();
      ctrl.animateTo(1.0,
          curve: Curves.easeIn, duration: Duration(milliseconds: 500));
      // }
      listDataCurrentProcessController.value.loadingController.stopLoading();
    }).catchError((onError) {
      try {
        http.Response error = onError;
        listDataCurrentProcessController.value.loadingController.stopLoading(
          message: error.body,
        );
      } catch (e) {
        listDataCurrentProcessController.value.loadingController.stopLoading(
          message: "$onError",
        );
      }
    });
  }

  Future getOldProcessShipment(
      TmsShipmentModel<T> data, ScrollController ctrl) async {
    listDataCurrentProcessController.value.loadingController.startLoading(
      coverScreen: false,
    );

    await TmsShipmentModel.getProcessed(
      token: System.data.global.token,
      limit: 10,
      withRoute: false,
      shipmentId: data != null ? data.tmsShipmentId : 0,
      isLowerThanId: true,
      searchKey: searchController.text,
    ).then((onValue) {
      if (onValue.length > 0) {
        if (data != null) {
          listDataCurrentProcessController.value.data.remove(data);
          listDataCurrentProcessController.commit();
        }
        listDataCurrentProcessController.add(onValue);
        try {
          ctrl.animateTo(ctrl.position.maxScrollExtent,
              curve: Curves.easeIn, duration: Duration(milliseconds: 500));
        } catch (e) {}
      }
      listDataCurrentProcessController.value.loadingController.stopLoading();
    }).catchError((onError) {
      listDataCurrentProcessController.value.loadingController.stopLoading(
        message: onError,
      );
    });
  }

  Future getNewDoneShipment(
      TmsShipmentModel<T> data, ScrollController ctrl) async {
    listDataDoneController.value.loadingController.startLoading(
      coverScreen: false,
    );
    await TmsShipmentModel.getFinish(
      token: System.data.global.token,
      limit: 10,
      withRoute: false,
      // shipmentId: data != null ? data.tmsShipmentId : 0,
      shipmentId: 0,
      isLowerThanId: false,
      searchKey: searchController.text,
    ).then((onValue) {
      // if (onValue.length > 0) {
      // if (data != null) {
      // listDataDoneController.value.data.remove(data);
      // listDataCurrentProcessController.value.data = [];
      // }
      listDataDoneController.value.data = onValue;
      listDataDoneController.commit();
      try {
        ctrl.animateTo(1.0,
            curve: Curves.easeIn, duration: Duration(milliseconds: 500));
      } catch (e) {}
      // }
      listDataDoneController.value.loadingController.stopLoading();
    }).catchError((onError) {
      try {
        http.Response error = onError;
        listDataDoneController.value.loadingController.stopLoading(
          message: error.body,
        );
      } catch (e) {
        listDataDoneController.value.loadingController.stopLoading(
          message: "$onError",
        );
      }
    });
  }

  Future getOldDoneShipment(
      TmsShipmentModel<T> data, ScrollController ctrl) async {
    listDataDoneController.value.loadingController.startLoading(
      coverScreen: false,
    );

    await TmsShipmentModel.getFinish(
      token: System.data.global.token,
      limit: 10,
      withRoute: false,
      shipmentId: data != null ? data.tmsShipmentId : 0,
      isLowerThanId: true,
      searchKey: searchController.text,
    ).then((onValue) {
      if (onValue.length > 0) {
        if (data != null) {
          listDataDoneController.value.data.remove(data);
          listDataDoneController.commit();
        }
        listDataDoneController.add(onValue);
        try {
          ctrl.animateTo(ctrl.position.maxScrollExtent,
              curve: Curves.easeIn, duration: Duration(milliseconds: 500));
        } catch (e) {}
      }
      listDataDoneController.value.loadingController.stopLoading();
    }).catchError((onError) {
      ModeUtil.debugPrint(onError);
      listDataDoneController.value.loadingController.stopLoading(
        message: onError,
      );
    });
  }

  Future getNewRejectShipment(
      TmsShipmentModel<T> data, ScrollController ctrl) async {
    listDataRejectController.value.loadingController.startLoading(
      coverScreen: false,
    );
    await TmsShipmentModel.getCancel(
      token: System.data.global.token,
      limit: 10,
      withRoute: false,
      // shipmentId: data != null ? data.tmsShipmentId : 0,
      shipmentId: 0,
      isLowerThanId: false,
      searchKey: searchController.text,
    ).then((onValue) {
      // if (onValue.length > 0) {
      // if (data != null) {
      // listDataRejectController.value.data.remove(data);
      // listDataCurrentProcessController.value.data = [];
      // listDataRejectController.commit();
      // }
      listDataRejectController.value.data = (onValue);
      listDataRejectController.commit();
      try {
        ctrl.animateTo(1.0,
            curve: Curves.easeIn, duration: Duration(milliseconds: 500));
      } catch (e) {}
      // }
      listDataRejectController.value.loadingController.stopLoading();
    }).catchError((onError) {
      try {
        http.Response error = onError;
        listDataRejectController.value.loadingController.stopLoading(
          message: error.body,
        );
      } catch (e) {
        listDataRejectController.value.loadingController.stopLoading(
          message: "$onError",
        );
      }
    });
  }

  Future getOldRejectShipment(
      TmsShipmentModel<T> data, ScrollController ctrl) async {
    listDataRejectController.value.loadingController.startLoading(
      coverScreen: false,
    );

    await TmsShipmentModel.getCancel(
      token: System.data.global.token,
      limit: 10,
      withRoute: false,
      shipmentId: data != null ? data.tmsShipmentId : 0,
      isLowerThanId: true,
      searchKey: searchController.text,
    ).then((onValue) {
      if (onValue.length > 0) {
        if (data != null) {
          listDataRejectController.value.data.remove(data);
          listDataRejectController.commit();
        }
        listDataRejectController.add(onValue);
        try {
          ctrl.animateTo(ctrl.position.maxScrollExtent,
              curve: Curves.easeIn, duration: Duration(milliseconds: 500));
        } catch (e) {}
      }
      listDataRejectController.value.loadingController.stopLoading();
    }).catchError((onError) {
      listDataRejectController.value.loadingController.stopLoading(
        message: onError,
      );
    });
  }

  void onSearchChange(String value) {
    getNewProcessShipment(
      null,
      listDataCurrentProcessController.value?.scrollController,
    );
    getNewDoneShipment(
      null,
      listDataDoneController.value.scrollController,
    );
    getNewRejectShipment(
      null,
      listDataRejectController.value.scrollController,
    );
  }
}
