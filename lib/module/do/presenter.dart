import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/main.dart';
import 'package:enerren/model/tmsShipmentDestinationModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'DoHomeViewer.dart';
import 'view.dart';
import 'package:enerren/model/UomModel.dart';
import 'package:enerren/model/ShipmentItemDescriptionViewModel.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  @required
  final int detailShipmentId;
  final int tmsShipmentId;
  final VoidCallback onSubmitSuccess;
  final String user;
  final List<TmsShipmentDestinationModel> destinations;
  final bool isPod;
  final String iconGoodsAssets;
  final bool showQtyField;
  final bool showUnitField;

  const Presenter({
    Key key,
    this.view,
    this.tmsShipmentId,
    this.onSubmitSuccess,
    this.user,
    this.detailShipmentId,
    this.destinations,
    this.isPod,
    this.iconGoodsAssets,
    this.showQtyField = true,
    this.showUnitField = true,
  }) : super(key: key);

  createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  DoHomeViewer model = new DoHomeViewer();
  DoModelController doModelController = new DoModelController();
  ShipmentItemDescriptionViewModel shipmentItemDescriptionViewModel =
      ShipmentItemDescriptionViewModel();

  List<Map> listItemId = [
    ShipmentItemDescriptionViewModel.toitemId(1),
    ShipmentItemDescriptionViewModel.toitemId(1),
    ShipmentItemDescriptionViewModel.toitemId(1),
    ShipmentItemDescriptionViewModel.toitemId(1),
    ShipmentItemDescriptionViewModel.toitemId(1),
  ];

  @override
  void initState() {
    super.initState();
    model.loadingController.stopLoading();
    model.commit();
    getDo();
    geUom();
    doModelController.destinations = widget.destinations ?? [];
    doModelController.commit();
  }

  void addDo() {
    if (doModelController.checkAll(
      validateQty: widget.showQtyField,
      validateUnit: widget.showUnitField,
    )) {
      var a = doModelController.getAll;
      if (widget.tmsShipmentId != null) {
        shipmentItemDescriptionViewModel = ShipmentItemDescriptionViewModel(
          itemId: 0,
          detailshipmentId: widget.detailShipmentId,
          tmsShipmentId: widget.tmsShipmentId,
          podDetailshipmentId: a.podDetailshipmentId,
          item: a.item,
          itemDescription: a.itemDescription,
          qty: a.qty,
          uomName: a.uomName,
          uomCode: a.uomCode,
          isChecked: false,
          insertedBy: widget.user,
        );

        model.loadingController.startLoading();
        model.commit();

        ShipmentItemDescriptionViewModel.addShipmentItemDescription(
          token: System.data.global.token,
          shipmentItemDescriptionViewModel: shipmentItemDescriptionViewModel,
        ).then((onValue) {
          print("return from add do");
          print("${onValue.toJson()}");
          model.doModelList.add(onValue);
          model.commit();
          doModelController.clear();
          model.loadingController.stopLoading();
        }).whenComplete(() {
          model.commit();
          doModelController.clear();
        }).catchError((onError) {
          model.loadingController.stopLoading(
              messageAlign: Alignment.topCenter,
              messageWidget: DecorationComponent.topMessageDecoration(
                  message: ErrorHandlingUtil.handleApiError(onError)));
          model.commit();
          doModelController.clear();
        });
      }
    }
  }

  void updateDo() {
    if (doModelController.checkAll(
      validateQty: widget.showQtyField,
      validateUnit: widget.showUnitField,
    )) {
      var a = doModelController.getAll;
      shipmentItemDescriptionViewModel = ShipmentItemDescriptionViewModel(
        itemId: a.itemId,
        detailshipmentId: widget.detailShipmentId,
        tmsShipmentId: widget.tmsShipmentId,
        podDetailshipmentId: a.podDetailshipmentId,
        item: a.item,
        itemDescription: a.itemDescription,
        qty: a.qty,
        uomName: a.uomName,
        uomCode: a.uomCode,
        isChecked: false,
        modifiedBy: widget.user,
      );

      model.loadingController.startLoading();
      model.commit();

      ShipmentItemDescriptionViewModel.updateSingleShipmentItemDescription(
        token: System.data.global.token,
        shipmentItemDescriptionViewModel: shipmentItemDescriptionViewModel,
      ).then(
        (onValue) {
          int a =
              model.doModelList.indexWhere((f) => f.itemId == onValue.itemId);
          model.doModelList[a] = onValue;
          model.commit();
        },
      ).whenComplete(() {
        doModelController.clear();
        model.loadingController.stopLoading();
        model.commit();
      }).catchError(
        (onError) {
          model.loadingController.stopLoading(
              messageAlign: Alignment.topCenter,
              messageWidget: DecorationComponent.topMessageDecoration(
                  message: ErrorHandlingUtil.handleApiError(onError)));
          model.commit();
        },
      );
    }
  }

  void deleteDo() {
    if (model.getListIdDeleted.length != 0) {
      model.loadingController.startLoading();
      model.commit();

      ShipmentItemDescriptionViewModel.deleteShipmentItemDescription(
        token: System.data.global.token,
        itemId: model.getListIdDeleted,
        tmsShipmentId: widget.tmsShipmentId,
      ).then(
        (onValue) {
          model.doModelList = onValue;
          model.commit();
        },
      ).whenComplete(() {
        model.loadingController.stopLoading();
        model.commit();
        doModelController.clear();
      }).catchError(
        (onError) {
          model.loadingController.stopLoading(
              messageAlign: Alignment.topCenter,
              messageWidget: DecorationComponent.topMessageDecoration(
                  message: ErrorHandlingUtil.handleApiError(onError)));
          model.commit();
        },
      );
    }
  }

  void getDo() {
    model.loadingController.startLoading();
    ShipmentItemDescriptionViewModel.getShipmentItemDescription(
      tmsShipmentId: widget.tmsShipmentId,
      detailShipmentId: widget.detailShipmentId,
      token: System.data.global.token,
      isPod: widget.isPod,
    ).then((onValue) {
      model.doModelList = onValue;
      model.commit();
    }).whenComplete(() {
      model.loadingController.stopLoading();
      model.commit();
    }).catchError((onError) {
      model.loadingController.stopLoading(message: onError);
      model.commit();
    });
  }

  void geUom() {
    model.loadingController.startLoading();
    model.commit();

    UomModel.getUOMList(token: System.data.global.token).then((onValue) {
      doModelController.units = onValue;
      doModelController.commit();
    }).whenComplete(() {
      model.loadingController.stopLoading();
      model.commit();
    }).catchError((onError) {
      model.loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
              message: ErrorHandlingUtil.handleApiError(onError)));
      model.commit();
    });
  }

  void next() {
    bool isValid = true;
    if (model.doModelList.length > 0) {
      doModelController.destinations.forEach(
        (destination) {
          if (model.doModelList
              .where(
                  (e) => e.podDetailshipmentId == destination.detailshipmentId)
              .toList()
              .isEmpty) {
            isValid = false;
            loadingController.stopLoading(
              messageAlign: Alignment.topCenter,
              messageWidget: DecorationComponent.topMessageDecoration(
                message:
                    "${System.data.resource.pleaseFillInAtLeastOneItemToBeDeliveredAtEachDestination}",
              ),
            );
          }
        },
      );
      if (widget.onSubmitSuccess != null && isValid) {
        widget.onSubmitSuccess();
      } else {
        ModeUtil.debugPrint("Tap Next");
      }
    } else {
      loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message:
              "${System.data.resource.pleaseFillInAtLeastOneItemToBeDeliveredAtEachDestination}",
        ),
      );
    }
  }
}
