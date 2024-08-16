import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/listDataComponent.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';

import 'viewModel.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged2Param<ViewModel, AngkutShipmentModel> onSelected;
  final int activeTab;
  final bool showPrice;
  final bool showExtraPeople;

  const Presenter({
    Key key,
    this.view,
    this.onSelected,
    this.activeTab,
    this.showPrice = true,
    this.showExtraPeople = false,
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
  ViewModel model = new ViewModel();

  ListDataComponentController<AngkutShipmentModel>
      listDataCurrentProcessController =
      new ListDataComponentController<AngkutShipmentModel>();

  ListDataComponentController<AngkutShipmentModel>
      listDataCurrentNewController =
      new ListDataComponentController<AngkutShipmentModel>();

  ListDataComponentController<AngkutShipmentModel> listDataDoneController =
      new ListDataComponentController<AngkutShipmentModel>();

  ListDataComponentController<AngkutShipmentModel> listDataShippedController =
      new ListDataComponentController<AngkutShipmentModel>();

  ListDataComponentController<AngkutShipmentModel> listDataRejectController =
      new ListDataComponentController<AngkutShipmentModel>();

  int id = 0;
  @override
  void initState() {
    model.controller = new TabController(
        vsync: this, length: 5, initialIndex: widget.activeTab ?? 0)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  String imageSvg({int status = 1}) {
    var string;
    if (status == model.currentProcess) {
      string = "assets/icon_shipment_process.svg";
    } else if (status == model.doneProcess) {
      string = "assets/icon_shipment_success.svg";
    } else if (status == model.rejectProcess) {
      string = "assets/icon_shipment_failed.svg";
    }
    return string;
  }

  void onSelected(AngkutShipmentModel data) {
    if (widget.onSelected != null) {
      widget.onSelected(model, data);
    } else {
      ModeUtil.debugPrint("selected");
    }
  }

  Future getNewProcessShipment(
      AngkutShipmentModel data, ScrollController ctrl) async {
    listDataCurrentProcessController.value.loadingController.startLoading(
      coverScreen: false,
    );
    await AngkutShipmentModel.getProcessed(
      token: System.data.global.token,
      limit: 10,
      withRoute: false,
      // shipmentId: data != null ? data.tmsShipmentId : 0,
      shipmentId: 0,
      isLowerThanId: false,
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
      if (!("$onError").contains("scroll_controller.dart")) {
        listDataCurrentProcessController.value.loadingController.stopLoading(
          message: ErrorHandlingUtil.handleApiError(onError),
        );
      } else {
        listDataCurrentProcessController.value.loadingController.stopLoading();
      }
    });
  }

  Future getOldProcessShipment(
      AngkutShipmentModel data, ScrollController ctrl) async {
    listDataCurrentProcessController.value.loadingController.startLoading(
      coverScreen: false,
    );

    await AngkutShipmentModel.getProcessed(
      token: System.data.global.token,
      limit: 10,
      withRoute: false,
      shipmentId: data != null ? data.tmsShipmentId : 0,
      isLowerThanId: true,
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
      if (!("$onError").contains("scroll_controller.dart")) {
        listDataCurrentProcessController.value.loadingController.stopLoading(
          message: ErrorHandlingUtil.handleApiError(onError),
        );
      } else {
        listDataCurrentProcessController.value.loadingController.stopLoading();
      }
    });
  }

  Future getOpenShipment(
      AngkutShipmentModel data, ScrollController ctrl) async {
    listDataCurrentNewController.value.loadingController.startLoading(
      coverScreen: false,
    );
    await AngkutShipmentModel.getOpened(
      token: System.data.global.token,
      limit: 10,
      withRoute: false,
      shipmentId: 0,
      isLowerThanId: false,
    ).then((onValue) {
      ModeUtil.debugPrint("total open ${onValue.length}");
      // if (onValue.length > 0) {
      listDataCurrentNewController.value.data = onValue;
      listDataCurrentNewController.commit();
      ctrl.animateTo(1.0,
          curve: Curves.easeIn, duration: Duration(milliseconds: 500));
      // }
      listDataCurrentNewController.value.loadingController.stopLoading();
    }).catchError((onError) {
      if (!("$onError").contains("scroll_controller.dart")) {
        listDataCurrentNewController.value.loadingController.stopLoading(
          message: ErrorHandlingUtil.handleApiError(onError),
        );
      } else {
        listDataCurrentNewController.value.loadingController.stopLoading();
      }
    });
  }

  Future getOldOpenShipment(
      AngkutShipmentModel data, ScrollController ctrl) async {
    listDataCurrentNewController.value.loadingController.startLoading(
      coverScreen: false,
    );

    await AngkutShipmentModel.getOpened(
      token: System.data.global.token,
      limit: 10,
      withRoute: false,
      shipmentId: data != null ? data.tmsShipmentId : 0,
      isLowerThanId: true,
    ).then((onValue) {
      if (onValue.length > 0) {
        if (data != null) {
          listDataCurrentNewController.value.data.remove(data);
          listDataCurrentNewController.commit();
        }
        listDataCurrentNewController.add(onValue);
        try {
          ctrl.animateTo(ctrl.position.maxScrollExtent,
              curve: Curves.easeIn, duration: Duration(milliseconds: 500));
        } catch (e) {}
      }
      listDataCurrentNewController.value.loadingController.stopLoading();
    }).catchError((onError) {
      if (!("$onError").contains("scroll_controller.dart")) {
        listDataCurrentNewController.value.loadingController.stopLoading(
          message: ErrorHandlingUtil.handleApiError(onError),
        );
      } else {
        listDataCurrentNewController.value.loadingController.stopLoading();
      }
    });
  }

  Future getNewShippedShipment(
      AngkutShipmentModel data, ScrollController ctrl) async {
    listDataDoneController.value.loadingController.startLoading(
      coverScreen: false,
    );
    await AngkutShipmentModel.getShippedShipment(
      token: System.data.global.token,
      limit: 10,
      withRoute: false,
      // shipmentId: data != null ? data.tmsShipmentId : 0,
      shipmentId: 0,
      isLowerThanId: false,
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
      if (!("$onError").contains("scroll_controller.dart")) {
        listDataDoneController.value.loadingController.stopLoading(
          message: ErrorHandlingUtil.handleApiError(onError),
        );
      } else {
        listDataDoneController.value.loadingController.stopLoading();
      }
    });
  }

  Future getOldShippedShipment(
      AngkutShipmentModel data, ScrollController ctrl) async {
    listDataDoneController.value.loadingController.startLoading(
      coverScreen: false,
    );

    await AngkutShipmentModel.getShippedShipment(
      token: System.data.global.token,
      limit: 10,
      withRoute: false,
      shipmentId: data != null ? data.tmsShipmentId : 0,
      isLowerThanId: true,
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
      if (!("$onError").contains("scroll_controller.dart")) {
        listDataDoneController.value.loadingController.stopLoading(
          message: ErrorHandlingUtil.handleApiError(onError),
        );
      } else {
        listDataDoneController.value.loadingController.stopLoading();
      }
    });
  }

  Future getNewFinishShipment(
      AngkutShipmentModel data, ScrollController ctrl) async {
    listDataShippedController.value.loadingController.startLoading(
      coverScreen: false,
    );
    await AngkutShipmentModel.getFinish(
      token: System.data.global.token,
      limit: 10,
      withRoute: false,
      // shipmentId: data != null ? data.tmsShipmentId : 0,
      shipmentId: 0,
      isLowerThanId: false,
    ).then((onValue) {
      // if (onValue.length > 0) {
      // if (data != null) {
      // listDataRejectController.value.data.remove(data);
      // listDataCurrentProcessController.value.data = [];
      // listDataRejectController.commit();
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
      if (!("$onError").contains("scroll_controller.dart")) {
        listDataShippedController.value.loadingController.stopLoading(
          message: ErrorHandlingUtil.handleApiError(onError),
        );
      } else {
        listDataShippedController.value.loadingController.stopLoading();
      }
    });
  }

  Future getOldFinishShipment(
      AngkutShipmentModel data, ScrollController ctrl) async {
    listDataShippedController.value.loadingController.startLoading(
      coverScreen: false,
    );

    await AngkutShipmentModel.getFinish(
      token: System.data.global.token,
      limit: 10,
      withRoute: false,
      shipmentId: data != null ? data.tmsShipmentId : 0,
      isLowerThanId: true,
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
      if (!("$onError").contains("scroll_controller.dart")) {
        listDataShippedController.value.loadingController.stopLoading(
          message: ErrorHandlingUtil.handleApiError(onError),
        );
      } else {
        listDataShippedController.value.loadingController.stopLoading();
      }
    });
  }

  Future getNewCancelShipment(
      AngkutShipmentModel data, ScrollController ctrl) async {
    listDataRejectController.value.loadingController.startLoading(
      coverScreen: false,
    );
    await AngkutShipmentModel.getCanceled(
      token: System.data.global.token,
      limit: 10,
      withRoute: false,
      // shipmentId: data != null ? data.tmsShipmentId : 0,
      shipmentId: 0,
      isLowerThanId: false,
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
      if (!("$onError").contains("scroll_controller.dart")) {
        listDataRejectController.value.loadingController.stopLoading(
          message: ErrorHandlingUtil.handleApiError(onError),
        );
      } else {
        listDataRejectController.value.loadingController.stopLoading();
      }
    });
  }

  Future getOldCancelShipment(
      AngkutShipmentModel data, ScrollController ctrl) async {
    listDataRejectController.value.loadingController.startLoading(
      coverScreen: false,
    );

    await AngkutShipmentModel.getCanceled(
      token: System.data.global.token,
      limit: 10,
      withRoute: false,
      shipmentId: data != null ? data.tmsShipmentId : 0,
      isLowerThanId: true,
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
      if (!("$onError").contains("scroll_controller.dart")) {
        listDataRejectController.value.loadingController.stopLoading(
          message: ErrorHandlingUtil.handleApiError(onError),
        );
      } else {
        listDataRejectController.value.loadingController.stopLoading();
      }
    });
  }
}
