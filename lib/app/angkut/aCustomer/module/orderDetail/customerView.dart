import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/app/angkut/module/orderDetail/main.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/bottomDockComponent.dart';
import 'package:enerren/util/DateTimeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'customerPresenter.dart';

class CustomerView extends View with CustomerPresenter {
  ValueChanged<AngkutShipmentModel> onTapPaynow;
  ValueChanged<AngkutShipmentModel> onTapRatintDriver;
  String confirmCamcelIlustrationAssets;

  CustomerView({
    this.onTapPaynow,
    this.onTapRatintDriver,
    this.confirmCamcelIlustrationAssets,
  }) {
    super.onTapPaynow = this.onTapPaynow;
  }

  Widget body(ViewModel viewModel) {
    return Stack(
      children: <Widget>[
        viewModel.shipment.shipmentStatusId >= 3 &&
                viewModel.shipment.shipmentStatusId <= 6
            ? Container(
                margin: EdgeInsets.only(
                  bottom: finishTimer ? 0 : 170,
                  top: viewModel.shipment.shipmentStatusId == 3 ? 30 : 0,
                ),
                child: home())
            : home(),
        viewModel.shipment.shipmentStatusId >= 3 &&
                viewModel.shipment.shipmentStatusId <= 6
            ? bottomDock(viewModel)
            : Container(
                width: 0,
                height: 0,
              ),
        DecorationComponent.circularLOadingIndicator(
          lightMode: false,
          controller: loadingController,
        ),
        viewModel.shipment.shipmentStatusId == 3
            ? Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 30,
                  alignment: Alignment.center,
                  color: Color(0xff1ae4ff),
                  width: double.infinity,
                  child: Text(
                    "${System.data.resource.arrivalEtaToPickup}, ${DateFormat(System.data.resource.longDateFormat, System.data.resource.dateLocalFormat).format(viewModel.shipment.arrivalEtaToPickUp)}",
                    style: System.data.textStyleUtil.mainLabel(
                      fontSize: System.data.fontUtil.xsPlus,
                    ),
                  ),
                ),
              )
            : Container(
                height: 0,
                width: 0,
              )
      ],
    );
  }

  @override
  Widget customer() {
    return Container(
      height: 0,
      width: 0,
    );
  }

  @override
  Widget buttom() {
    return model.shipment.shipmentStatusId == 1 ||
            model.shipment.shipmentStatusId == 2
        ? Container(
            child: Column(
              children: <Widget>[
                model.shipment.shipmentInvoice.methodDetailIpay88Id != null &&
                        model.shipment.shipmentInvoice.paidStatus != 2
                    ? Container(
                        height: 40,
                        margin: EdgeInsets.only(
                            left: 15, top: 15, right: 15, bottom: 15),
                        decoration: BoxDecoration(boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: System.data.colorUtil.shadowColor
                                .withOpacity(0.2),
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ]),
                        child: BottonComponent.roundedButton(
                            onPressed: () {
                              super.onTapPaynow(model.shipment);
                            },
                            text: "${System.data.resource.payNow}"),
                      )
                    : Container(
                        height: 0,
                        width: 0,
                      ),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 15, bottom: 20, right: 15),
                  decoration: BoxDecoration(boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: System.data.colorUtil.shadowColor.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ]),
                  child: BottonComponent.roundedButton(
                    onPressed: popUpCancelShipment,
                    colorBackground: Colors.white,
                    text: "${System.data.resource.cancel}",
                    textstyle: System.data.textStyleUtil.mainLabel(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 50, right: 50, bottom: 50),
                  child: Text(
                    "*Silahkan lakukan pembayaran sebelum barang anda di Angkut",
                    textAlign: TextAlign.center,
                    style: System.data.textStyleUtil.mainLabel(
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          )
        : model.shipment.shipmentStatusId == 10 &&
                (model.shipment.driverRating == null ||
                    model.shipment.driverRating?.rating == null ||
                    model.shipment.driverRating?.rating == 0)
            ? Container(
                height: 40,
                margin:
                    EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 15),
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 3,
                      offset: Offset(0, 3))
                ]),
                child: BottonComponent.roundedButton(
                    onPressed: () {
                      this.onTapRatintDriver(model.shipment);
                    },
                    text: "${System.data.resource.ratingDriver}"),
              )
            : Container(
                width: 0,
                height: 0,
              );
  }

  Widget bottomDock(ViewModel viewModel) {
    return !finishTimer
        ? Align(
            alignment: Alignment.bottomCenter,
            child: BottomDockComponent(
              controller: bottomSheetController,
              gripBackground: Colors.white,
              gripColorOnFree: Colors.grey,
              gripColorOnDrag: Colors.grey,
              handleBar: (value) => Container(
                margin: EdgeInsets.only(top: 2),
                height: 20,
                color: Colors.white.withOpacity(0),
                width: double.infinity,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 5,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
              minHeight: 10,
              maxHeight: bottomSheetHeight,
              isExpand: true,
              extraArea: 0,
              onUpdateStatusExpand: (isExpand) {
                viewModel.commit();
              },
              bottonSheetDecoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: System.data.colorUtil.shadowColor.withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft:
                      Radius.lerp(Radius.circular(10), Radius.circular(0), 1),
                  topRight:
                      Radius.lerp(Radius.circular(10), Radius.circular(0), 1),
                ),
              ),
              contentPadding: bottomSheetContentPadding,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 22, right: 22),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              top: 14,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "${System.data.resource.distanceToPickupLocation}",
                                  style: System.data.textStyleUtil.mainLabel(
                                      color: System.data.colorUtil.primaryColor,
                                      fontFamily: System.data.fontUtil.primary),
                                ),
                                Text(
                                  "${viewModel.shipment.distanceToPickUp.ceil()} km",
                                  style: System.data.textStyleUtil.mainLabel(
                                      color:
                                          System.data.colorUtil.darkTextColor,
                                      fontFamily: System.data.fontUtil.primary),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  // "${viewModel.shipment.arrivalEtaToPickUp.toIso8601String()}",
                                  "${System.data.resource.estimatedToPickupLocation}",
                                  style: System.data.textStyleUtil.mainLabel(
                                      color: System.data.colorUtil.primaryColor,
                                      fontFamily: System.data.fontUtil.primary),
                                ),
                                Text(
                                  "${viewModel.shipment.arrivalEtaToPickUp != null ? DateTimeUtil.getDiffDateString(DateTime.now(), startDate: viewModel.shipment.arrivalEtaToPickUp, titleAgo: "") : ""}",
                                  style: System.data.textStyleUtil.mainLabel(
                                      color:
                                          System.data.colorUtil.darkTextColor,
                                      fontFamily: System.data.fontUtil.primary),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "${System.data.resource.doYouWantToWait}",
                                  style: System.data.textStyleUtil.mainLabel(
                                      color: System.data.colorUtil.primaryColor,
                                      fontFamily: System.data.fontUtil.primary),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 14),
                      height: 47,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("finish cancell");
                                finishTimer = true;
                                model.commit();
                                confirmWaiting();
                              },
                              child: Container(
                                height: 47,
                                color: System.data.colorUtil.primaryColor,
                                child: Center(
                                  child: Text(
                                    "${System.data.resource.yes}",
                                    style: System.data.textStyleUtil.mainLabel(
                                        color: System
                                            .data.colorUtil.lightTextColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                super.cancleOrder();
                              },
                              child: Container(
                                height: 47,
                                child: Center(
                                  child: Text(
                                    "${System.data.resource.no}",
                                    style: System.data.textStyleUtil.mainLabel(
                                        color:
                                            System.data.colorUtil.primaryColor),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }

  popUpCancelShipment() {
    return ModalComponent.bottomModalWithCorner(
      context,
      height: 216,
      child: Container(
        height: 200,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: double.infinity,
                    child: SvgPicture.asset(confirmCamcelIlustrationAssets ??
                        "assets/angkut/angkut_helper.svg"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${System.data.resource.areYouSureCancelThisOrder}",
                    textAlign: TextAlign.center,
                    style: System.data.textStyleUtil.mainLabel(),
                  )
                ],
              ),
            ),
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: System.data.colorUtil.primaryColor, width: 1)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: BottonComponent.roundedButton(
                      onPressed: cancleOrder,
                      radius: 0,
                      colorBackground: System.data.colorUtil.primaryColor,
                      child: Text(
                        System.data.resource.yes,
                        style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.lightTextColor),
                      ),
                    ),
                  ),
                  Expanded(
                    child: BottonComponent.roundedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      radius: 0,
                      colorBackground: Colors.white,
                      child: Text(
                        System.data.resource.no,
                        style: System.data.textStyleUtil.mainLabel(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget chargeFee() {
    return SizedBox();
  }
}
