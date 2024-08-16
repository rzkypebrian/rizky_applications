import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/listDataComponent.dart';
import 'package:enerren/app/sierad/model/SieradShipmentDetailHatcheryModel.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';
import 'package:http/http.dart' as http;

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final int tabActive;
  final ValueChanged<TmsShipmentModel<SieradShipmentDetailHatcheryModel>>
      onSelected;
  final String loadingAnimation;
  final String loadingAnimationAsset;

  const Presenter({
    Key key,
    this.view,
    this.onSelected,
    this.tabActive = 0,
    this.loadingAnimation,
    this.loadingAnimationAsset,
  }) : super(key: key);

  createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter>
    with TickerProviderStateMixin {
  InputComponentTextEditingController searchController =
      new InputComponentTextEditingController();

  ListDataComponentController<
          TmsShipmentModel<SieradShipmentDetailHatcheryModel>>
      listDataProcessController = new ListDataComponentController<
          TmsShipmentModel<SieradShipmentDetailHatcheryModel>>();

  ListDataComponentController<
          TmsShipmentModel<SieradShipmentDetailHatcheryModel>>
      listDataShippedController = new ListDataComponentController<
          TmsShipmentModel<SieradShipmentDetailHatcheryModel>>();

  ListDataComponentController<
          TmsShipmentModel<SieradShipmentDetailHatcheryModel>>
      listDataFinishController = new ListDataComponentController<
          TmsShipmentModel<SieradShipmentDetailHatcheryModel>>();

  ListDataComponentController<
          TmsShipmentModel<SieradShipmentDetailHatcheryModel>>
      listDataCancleController = new ListDataComponentController<
          TmsShipmentModel<SieradShipmentDetailHatcheryModel>>();

  TabController controller;
  final int currentProcess = 1;
  final int doneProcess = 2;
  final int rejectProcess = 3;
  int id = 0;
  @override
  void initState() {
    controller = new TabController(vsync: this, length: 3)
      ..addListener(() {
        setState(() {});
      });
    controller.animateTo(widget.tabActive);
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

  void onSelected(TmsShipmentModel<SieradShipmentDetailHatcheryModel> data) {
    if (widget.onSelected != null) {
      widget.onSelected(data);
    } else {
      ModeUtil.debugPrint("selected");
    }
  }

  Future getNewProcessShipment(
      TmsShipmentModel<SieradShipmentDetailHatcheryModel> data,
      ScrollController ctrl) async {
    listDataProcessController.value.loadingController.startLoading(
      coverScreen: false,
    );
    await SieradShipmentDetailHatcheryModel.getProcessed(
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
      // listDataProcessController.value.data.remove(data);
      listDataCancleController.value.data = [];
      // }
      listDataProcessController.value.data = (onValue);
      listDataProcessController.commit();
      ctrl.animateTo(1.0,
          curve: Curves.easeIn, duration: Duration(milliseconds: 500));
      // }
      listDataProcessController.value.loadingController.stopLoading();
    }).catchError((onError) {
      try {
        http.Response error = onError;
        listDataProcessController.value.loadingController.stopLoading(
          message: error.body,
        );
      } catch (e) {
        listDataProcessController.value.loadingController.stopLoading(
          message: "$onError",
        );
      }
    });
  }

  Future getOldProcessShipment(
      TmsShipmentModel<SieradShipmentDetailHatcheryModel> data,
      ScrollController ctrl) async {
    listDataProcessController.value.loadingController.startLoading(
      coverScreen: false,
    );

    await SieradShipmentDetailHatcheryModel.getProcessed(
      token: System.data.global.token,
      limit: 10,
      withRoute: false,
      shipmentId: data != null ? data.tmsShipmentId : 0,
      isLowerThanId: true,
      searchKey: searchController.text,
    ).then((onValue) {
      if (onValue.length > 0) {
        if (data != null) {
          listDataProcessController.value.data.remove(data);
          listDataProcessController.commit();
        }
        listDataProcessController.add(onValue);
        try {
          ctrl.animateTo(ctrl.position.maxScrollExtent,
              curve: Curves.easeIn, duration: Duration(milliseconds: 500));
        } catch (e) {}
      }
      listDataProcessController.value.loadingController.stopLoading();
    }).catchError((onError) {
      listDataProcessController.value.loadingController.stopLoading(
        message: onError,
      );
    });
  }

  Future getNewShippedShipment(
      TmsShipmentModel<SieradShipmentDetailHatcheryModel> data,
      ScrollController ctrl) async {
    listDataShippedController.value.loadingController.startLoading(
      coverScreen: false,
    );
    await SieradShipmentDetailHatcheryModel.getShipped(
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
      // listDataShippedController.value.data.remove(data);
      listDataCancleController.value.data = [];
      // }
      listDataShippedController.value.data = (onValue);
      listDataShippedController.commit();
      try {
        ctrl.animateTo(1.0,
            curve: Curves.easeIn, duration: Duration(milliseconds: 500));
      } catch (e) {}
      // }
      listDataShippedController.value.loadingController.stopLoading();
    }).catchError((onError) {
      try {
        http.Response error = onError;
        listDataShippedController.value.loadingController.stopLoading(
          message: error.body,
        );
      } catch (e) {
        listDataShippedController.value.loadingController.stopLoading(
          message: "$onError",
        );
      }
    });
  }

  Future getOldShippedShipment(
      TmsShipmentModel<SieradShipmentDetailHatcheryModel> data,
      ScrollController ctrl) async {
    listDataShippedController.value.loadingController.startLoading(
      coverScreen: false,
    );

    await SieradShipmentDetailHatcheryModel.getShipped(
      token: System.data.global.token,
      limit: 10,
      withRoute: false,
      shipmentId: data != null ? data.tmsShipmentId : 0,
      isLowerThanId: true,
      searchKey: searchController.text,
    ).then((onValue) {
      if (onValue.length > 0) {
        if (data != null) {
          listDataShippedController.value.data.remove(data);
          listDataShippedController.commit();
        }
        listDataShippedController.add(onValue);
        try {
          ctrl.animateTo(ctrl.position.maxScrollExtent,
              curve: Curves.easeIn, duration: Duration(milliseconds: 500));
        } catch (e) {}
      }
      listDataShippedController.value.loadingController.stopLoading();
    }).catchError((onError) {
      ModeUtil.debugPrint(onError);
      listDataShippedController.value.loadingController.stopLoading(
        message: onError,
      );
    });
  }

  Future getNewFinishShipment(
      TmsShipmentModel<SieradShipmentDetailHatcheryModel> data,
      ScrollController ctrl) async {
    listDataFinishController.value.loadingController.startLoading(
      coverScreen: false,
    );
    await SieradShipmentDetailHatcheryModel.getFinish(
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
      // listDataFinishController.value.data.remove(data);
      listDataFinishController.value.data = [];
      listDataFinishController.commit();
      // }
      listDataFinishController.value.data = (onValue);
      try {
        ctrl.animateTo(1.0,
            curve: Curves.easeIn, duration: Duration(milliseconds: 500));
      } catch (e) {}
      // }
      listDataFinishController.value.loadingController.stopLoading();
    }).catchError((onError) {
      try {
        http.Response error = onError;
        listDataFinishController.value.loadingController.stopLoading(
          message: error.body,
        );
      } catch (e) {
        listDataFinishController.value.loadingController.stopLoading(
          message: "$onError",
        );
      }
    });
  }

  Future getOldFinishShipment(
      TmsShipmentModel<SieradShipmentDetailHatcheryModel> data,
      ScrollController ctrl) async {
    listDataFinishController.value.loadingController.startLoading(
      coverScreen: false,
    );

    await SieradShipmentDetailHatcheryModel.getFinish(
      token: System.data.global.token,
      limit: 10,
      withRoute: false,
      shipmentId: data != null ? data.tmsShipmentId : 0,
      isLowerThanId: true,
      searchKey: searchController.text,
    ).then((onValue) {
      if (onValue.length > 0) {
        if (data != null) {
          listDataFinishController.value.data.remove(data);
          listDataFinishController.commit();
        }
        listDataFinishController.add(onValue);
        try {
          ctrl.animateTo(ctrl.position.maxScrollExtent,
              curve: Curves.easeIn, duration: Duration(milliseconds: 500));
        } catch (e) {}
      }
      listDataFinishController.value.loadingController.stopLoading();
    }).catchError((onError) {
      listDataFinishController.value.loadingController.stopLoading(
        message: onError,
      );
    });
  }

  Future getNewCancelShipment(
      TmsShipmentModel<SieradShipmentDetailHatcheryModel> data,
      ScrollController ctrl) async {
    listDataFinishController.value.loadingController.startLoading(
      coverScreen: false,
    );
    await SieradShipmentDetailHatcheryModel.getCancel(
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
      // listDataFinishController.value.data.remove(data);
      listDataCancleController.value..data = [];
      // }
      listDataFinishController.value.data = (onValue);
      listDataFinishController.commit();
      try {
        ctrl.animateTo(1.0,
            curve: Curves.easeIn, duration: Duration(milliseconds: 500));
      } catch (e) {}
      // }
      listDataFinishController.value.loadingController.stopLoading();
    }).catchError((onError) {
      try {
        http.Response error = onError;
        listDataFinishController.value.loadingController.stopLoading(
          message: error.body,
        );
      } catch (e) {
        listDataFinishController.value.loadingController.stopLoading(
          message: "$onError",
        );
      }
    });
  }

  Future getOldCancelShipment(
      TmsShipmentModel<SieradShipmentDetailHatcheryModel> data,
      ScrollController ctrl) async {
    listDataFinishController.value.loadingController.startLoading(
      coverScreen: false,
    );

    await SieradShipmentDetailHatcheryModel.getCancel(
      token: System.data.global.token,
      limit: 10,
      withRoute: false,
      shipmentId: data != null ? data.tmsShipmentId : 0,
      isLowerThanId: true,
      searchKey: searchController.text,
    ).then((onValue) {
      if (onValue.length > 0) {
        if (data != null) {
          listDataFinishController.value.data.remove(data);
          listDataFinishController.commit();
        }
        listDataFinishController.add(onValue);
        try {
          ctrl.animateTo(ctrl.position.maxScrollExtent,
              curve: Curves.easeIn, duration: Duration(milliseconds: 500));
        } catch (e) {}
      }
      listDataFinishController.value.loadingController.stopLoading();
    }).catchError((onError) {
      listDataFinishController.value.loadingController.stopLoading(
        message: onError,
      );
    });
  }

  void onSearchChange(String value) {
    getNewProcessShipment(
      null,
      listDataProcessController.value.scrollController,
    );
    // getNewShippedShipment(
    //   null,
    //   listDataShippedController.value.scrollController,
    // );
    getNewFinishShipment(
      null,
      listDataFinishController.value.scrollController,
    );
    getNewCancelShipment(
      null,
      listDataCancleController.value.scrollController,
    );
  }
}
