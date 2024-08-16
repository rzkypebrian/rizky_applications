import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/react/dashedReact.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'viewModel.dart';
import 'presenter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:enerren/util/StringExtention.dart';

class View extends PresenterState {
  final bool showChagePaymentMethode;
  final bool showPaymentMethode;

  View({
    this.showChagePaymentMethode = true,
    this.showPaymentMethode = true,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => super.model,
      child: Consumer<ViewModel>(
        builder: (ctx, dt, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
              appBar: appBar(),
              body: Stack(
                children: [
                  body(dt, ctx),
                  circularProgressIndicatorDecoration()
                ],
              ),
              bottomNavigationBar: bottomNavBar(),
            ),
          );
        },
      ),
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularLOadingIndicator(
      controller: model.loadingController,
    );
  }

  Widget appBar() {
    return BottonComponent.customAppBar1(
      context: context,
      actionText: "",
      title: "${System.data.resource.confirmation}",
      titleStyle: System.data.textStyleUtil.mainTitle(),
      backButtonColor: System.data.colorUtil.lightTextColor,
      backgroundColor: System.data.colorUtil.primaryColor,
    );
  }

  Widget body(ViewModel dt, BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            wizardBar(),
            Container(
              padding: EdgeInsets.only(top: 20, left: 15, bottom: 15),
              child: Text(
                "${System.data.resource.deliveryDetail}",
                style: System.data.textStyleUtil.mainLabel(
                  color: System.data.colorUtil.blueColor,
                ),
              ),
            ),
            pickUpLocationList(dt, context),
            Container(
              padding: EdgeInsets.only(top: 20, left: 15),
              child: Text(
                "${System.data.resource.vehicleDetail}",
                style: System.data.textStyleUtil.mainLabel(
                  color: System.data.colorUtil.blueColor,
                ),
              ),
            ),
            vehicleType(),
            Container(
              padding: EdgeInsets.only(top: 20, left: 15),
              child: Text(
                "${System.data.resource.goodsDetail}",
                style: System.data.textStyleUtil.mainLabel(
                  color: System.data.colorUtil.blueColor,
                ),
              ),
            ),
            itemDetail(),
            widget.showdetailPayment
                ? Container(
                    padding: EdgeInsets.only(top: 20, left: 15),
                    child: Text(
                      "${System.data.resource.paymentDetail}",
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.blueColor,
                      ),
                    ),
                  )
                : SizedBox(),
            widget.showdetailPayment ? voucher() : SizedBox(),
            widget.showdetailPayment ? paymentDetail() : SizedBox(),
            widget.showInchargePersoneSelector
                ? Container(
                    padding: EdgeInsets.only(top: 20, left: 15),
                    child: Text(
                      "${System.data.resource.personInChargeOfPayment}",
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.blueColor,
                      ),
                    ),
                  )
                : SizedBox(),
            widget.showInchargePersoneSelector ? personIncharges() : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget personIncharges() {
    return Container(
      margin: EdgeInsets.only(bottom: 20, top: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            model.shipment.tmsShipmentDestinationList.length, (i) {
          return Column(
            children: [
              i == 0
                  ? Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              "${toBeginningOfSentenceCase(model.shipment.tmsShipmentDestinationList.first.originContactPerson)}"),
                          Radio(
                              value: 0,
                              groupValue: model.currentIndex,
                              onChanged: (index) => model.personInCharge(index))
                        ],
                      ),
                    )
                  : SizedBox(),
              Divider(
                thickness: 1,
                color: System.data.colorUtil.disableColor,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        "${toBeginningOfSentenceCase(model.shipment.tmsShipmentDestinationList[i].destinationContactPerson)}"),
                    Radio(
                        value: (i + 1),
                        groupValue: model.currentIndex,
                        onChanged: (index) => model.personInCharge(index))
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget pickUpLocationList(ViewModel dt, BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: System.data.colorUtil.secondaryColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: System.data.colorUtil.shadowColor.withOpacity(.20),
                  offset: Offset(.0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                    dt.shipment.tmsShipmentDestinationList.length, (i) {
                  return Column(
                    children: [
                      i == 0
                          ? DecorationComponent.detailShipment(
                              context: context,
                              showContactPerson: widget.showContactPerson,
                              showStatusInCharge: widget.showInchageStatus,
                              onTapNoteForDriver: () {
                                DecorationComponent.detailNote(context,
                                    noteForDriver: model
                                        .shipment
                                        .tmsShipmentDestinationList[i]
                                        .originNoteForDriver);
                              },
                              poinName:
                                  "${System.data.resource.pickUpLocation}",
                              rightWidget: dt.shipment.shipmentStatusId >= 3
                                  ? GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "${System.data.resource.liveMap}",
                                            style: System.data.textStyleUtil
                                                .linkLabel(),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            FontAwesomeRegular(
                                                FontAwesomeId.fa_chevron_right),
                                            size: 15,
                                            color: System
                                                .data.colorUtil.primaryColor,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: 0,
                                      height: 0,
                                    ),
                              name:
                                  "${dt.shipment.tmsShipmentDestinationList.first.originContactPerson}",
                              phone:
                                  "${dt.shipment.tmsShipmentDestinationList.first.originContactNumber}",
                              next: true,
                              icon: SvgPicture.asset(
                                  "assets/angkut/box_angkut.svg"),
                              address:
                                  "${dt.shipment.tmsShipmentDestinationList.first.originAddress}",
                              detailAddress:
                                  "${dt.shipment.tmsShipmentDestinationList.first.originAdditionalInfo}",
                              guarent: dt.shipment.payerName ==
                                          dt
                                              .shipment
                                              .tmsShipmentDestinationList[i]
                                              .originContactPerson &&
                                      dt.shipment.payerPhoneNo ==
                                          dt
                                              .shipment
                                              .tmsShipmentDestinationList[i]
                                              .originContactNumber
                                  ? true
                                  : false,
                            )
                          : SizedBox(),
                      DecorationComponent.detailShipment(
                        context: context,
                        showContactPerson: widget.showContactPerson,
                        showStatusInCharge: widget.showInchageStatus,
                        onTapNoteForDriver: () {
                          DecorationComponent.detailNote(context,
                              noteForDriver: model
                                  .shipment
                                  .tmsShipmentDestinationList[i]
                                  .destinationNoteForDriver);
                        },
                        poinName:
                            "${System.data.resource.destination} ${dt.shipment.tmsShipmentDestinationList.length > 1 ? i + 1 : ""}",
                        name:
                            "${dt.shipment.tmsShipmentDestinationList[i].destinationContactPerson}",
                        phone:
                            "${dt.shipment.tmsShipmentDestinationList[i].destinationContactNumber}",
                        icon: dt.shipment.tmsShipmentDestinationList.length == 1
                            ? Icon(
                                FontAwesomeSolid(
                                    FontAwesomeId.fa_map_marker_alt),
                                color: System.data.colorUtil.redColor,
                              )
                            : Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: System.data.colorUtil.orangeColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                  ),
                                  child: Text(
                                    "${i + 1}",
                                    style: System.data.textStyleUtil.mainLabel(
                                      color:
                                          System.data.colorUtil.lightTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                        address:
                            "${dt.shipment.tmsShipmentDestinationList[i].destinationAddress}",
                        detailAddress:
                            "${dt.shipment.tmsShipmentDestinationList[i].destinationAdditionalInfo}",
                        guarent: dt.shipment.payerName ==
                                    dt.shipment.tmsShipmentDestinationList[i]
                                        .destinationContactPerson &&
                                dt.shipment.payerPhoneNo ==
                                    dt.shipment.tmsShipmentDestinationList[i]
                                        .destinationContactNumber
                            ? true
                            : false,
                        next: (i + 1) !=
                                model.shipment.tmsShipmentDestinationList.length
                            ? true
                            : false,
                      ),
                    ],
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget vehicleType() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(left: 25, bottom: 20, top: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  "${System.data.resource.vehicleType}",
                  style: System.data.textStyleUtil.mainLabel(
                    color: System.data.colorUtil.blueColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  "${model.shipment.vehicleTypeName}",
                  style: System.data.textStyleUtil.mainLabel(),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 10, right: 20),
            child: Text(
              "${System.data.resource.warningVehicleType}",
              style: System.data.textStyleUtil.mainLabel(
                fontStyle: FontStyle.italic,
                color: System.data.colorUtil.redColor,
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "${System.data.resource.deliverySchedule}",
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.blueColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    "${model.shipment.isInstant == true ? System.data.resource.instantCourier : System.data.resource.scheduled}",
                    style: System.data.textStyleUtil.mainLabel(),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget itemDetail() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(left: 25, bottom: 20, top: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  "${System.data.resource.itemType}",
                  style: System.data.textStyleUtil.mainLabel(
                    color: System.data.colorUtil.blueColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  "${model.shipment.deliveryDescription}",
                  style: System.data.textStyleUtil.mainLabel(),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget voucher() {
    return GestureDetector(
      onTap: onTapVoucher,
      child: Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
        ),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey.shade400, offset: Offset(0, 2), blurRadius: 5)
        ]),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              child: SvgPicture.asset("assets/angkut/voucher_icon.svg"),
            ),
            Container(
              height: 50,
              width: 7,
              color: Color(0xff749FFF),
              child: DashedRect(
                color: Colors.white,
                strokeWidth: 2.0,
                gap: 4.5,
                left: false,
                top: false,
                right: true,
                bottom: false,
              ),
            ),
            Expanded(
              child: Container(
                color: Color(0xff749FFF),
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    model.shipment.voucherCode.isNullOrEmpty() == false
                        ? model.shipment.voucherErrorString ??
                            model.shipment.voucherCode
                        : "${System.data.resource.useVoucher}",
                    style: System.data.textStyleUtil.mainTitle(
                      color: System.data.colorUtil.lightTextColor,
                      fontSize: System.data.fontUtil.xl,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    "assets/angkut/voucher_end_icon.svg",
                  ),
                  Center(
                    child: Icon(
                      FontAwesomeSolid(
                        FontAwesomeId.fa_chevron_right,
                      ),
                      color: System.data.colorUtil.lightTextColor,
                      size: System.data.fontUtil.xl,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentDetail() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 10, bottom: 0),
      padding: EdgeInsets.only(left: 25, bottom: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "${System.data.resource.rate} ( ${System.data.resource.distance} ${model.shipment.distancePickupToDestination?.ceil() ?? "-"} Km )",
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.blueColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          model.shipment.basicPriceAfterDiscount != null &&
                                  model.shipment.basicPriceAfterDiscount > 0 &&
                                  model.shipment.basicPriceAfterDiscount !=
                                      model.shipment.basicPrice
                              ? Container(
                                  color: System.data.colorUtil.primaryColor,
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 3, bottom: 3),
                                  margin: EdgeInsets.only(right: 5),
                                  child: Text(
                                    System.data.resource.discount,
                                    style: System.data.textStyleUtil.mainLabel(
                                      color:
                                          System.data.colorUtil.lightTextColor,
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          Text(
                              "Rp. ${NumberFormat("#,###.#", System.data.resource.locale).format(model.shipment.basicPriceAfterDiscount)}"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      model.shipment.basicPriceAfterDiscount != null &&
                              model.shipment.basicPriceAfterDiscount > 0 &&
                              model.shipment.basicPriceAfterDiscount !=
                                  model.shipment.basicPrice
                          ? Text(
                              "Rp. ${NumberFormat("#,###.#", System.data.resource.locale).format(model.shipment.basicPrice)}",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          model.shipment.totalShipCost != null &&
                  model.shipment.totalShipCost > 0
              ? shipCost()
              : SizedBox(),
          shipCostDetail(),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              "${System.data.resource.extraServices}",
              style: System.data.textStyleUtil
                  .mainLabel(color: System.data.colorUtil.blueColor),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    "${System.data.resource.extraPeople} ${model.shipment.extraHelperCount != null ? "(" + model.shipment.extraHelperCount.toString() + ")" : ""}",
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.blueColor,
                    ),
                  ),
                ),
                model.shipment.extraHelper
                    ? Container(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                            "Rp. ${NumberFormat("#,###.#", System.data.resource.locale).format(model.shipment.extraHelperAmount)}"),
                      )
                    : Container(
                        height: 0,
                        width: 0,
                      ),
              ],
            ),
          ),
          insurance(),
          insuranceDetail(),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    "${System.data.resource.voucher}",
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.blueColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                      "Rp. ${NumberFormat("#,###.#", System.data.resource.locale).format(model.shipment.voucherAmount)}"),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 150,
              child: Divider(
                color: System.data.colorUtil.blackColor,
                height: 30,
                thickness: 1,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    "${System.data.resource.totalPayment}",
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.blueColor,
                      fontSize: System.data.fontUtil.xxl,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    "Rp.  ${NumberFormat("#,###.#", System.data.resource.locale).format(model.shipment.totalPrice)}",
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.redColor,
                        fontSize: System.data.fontUtil.xxl,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          showPaymentMethode
              ? GestureDetector(
                  onTap: selectPaymentMethode,
                  child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "${model.shipment.shipmentInvoice.methodDetailName}",
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.blueColor,
                            ),
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.only(right: 20),
                          child: SvgPicture.network(
                            "${model..shipment.shipmentInvoice.bankIconUrl}",
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(),
          showChagePaymentMethode
              ? Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: selectPaymentMethode,
                    child: Container(
                      padding: EdgeInsets.only(right: 20),
                      height: 30,
                      child: BottonComponent.roundedButton(
                          text: "${System.data.resource.changePaymentMethod}",
                          colorBackground: Colors.transparent,
                          textColor: System.data.colorUtil.blueColor,
                          border: Border.all(
                              color: System.data.colorUtil.blueColor)),
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }

  Widget bottomNavBar() {
    return Container(
      padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
      child: BottonComponent.roundedButton(
        radius: 10,
        onPressed: () {
          if (model.loadingController.onLoading == false) {
            submit();
          }
        },
        child: Text(
          "${System.data.resource.continues}",
          style: System.data.textStyleUtil.mainLabel(
            color: System.data.colorUtil.lightTextColor,
            fontSize: System.data.fontUtil.xxl,
          ),
        ),
      ),
    );
  }

  Widget wizardBar() {
    return DecorationComponent.wizardBar(
      confirmationColor: System.data.colorUtil.primaryColor,
      routeColor: System.data.colorUtil.primaryColor,
      serviceColor: System.data.colorUtil.primaryColor,
    );
  }

  Widget detail({
    String title,
    Widget titleWidget,
    String title1,
    TextStyle sTiltle,
    TextStyle sValue,
    String value,
    bool sub = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          titleWidget == null
              ? Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: sub ? 10 : 0),
                    child: Text(
                      "$title",
                      style: sTiltle ??
                          System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.primaryColor,
                          ),
                    ),
                  ),
                )
              : titleWidget,
          title1 == null
              ? Container()
              : Container(
                  width: 40,
                  child: Text("$title1",
                      style: sTiltle ??
                          System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.primaryColor,
                          ))),
          Container(
            width: 150,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            child: Text(
              "$value",
              style: sValue ?? System.data.textStyleUtil.mainLabel(),
              textAlign: TextAlign.end,
            ),
          )
        ],
      ),
    );
  }

  Widget subDetail({
    String title,
    TextStyle styleTitle,
    String value,
    TextStyle styleValue,
  }) {
    return Container(
      child: Row(
        children: [
          Container(
            child: Text(
              "$title",
              style: styleTitle ??
                  System.data.textStyleUtil.mainLabel(
                    color: System.data.colorUtil.primaryColor,
                  ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            child: Text(
              "$value",
              style: styleValue ??
                  System.data.textStyleUtil.mainLabel(
                    color: System.data.colorUtil.darkTextColor,
                  ),
            ),
          )
        ],
      ),
    );
  }

  Widget insurance() {
    return detail(
      titleWidget: Expanded(
        child: Container(
          margin: EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Text(
                "${System.data.resource.insuranceFee}",
                style: System.data.textStyleUtil.mainLabel(
                  color: System.data.colorUtil.primaryColor,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  model.showDetailInsurance = !model.showDetailInsurance;
                  model.commit();
                },
                child: Icon(
                  !model.showDetailInsurance
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: System.data.colorUtil.primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
      value:
          "Rp. ${NumberFormat("#,###.#", System.data.resource.locale).format(model.shipment.insuranceAmount)}",
      sub: true,
    );
  }

  Widget insuranceDetail() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: model.showDetailInsurance ? 100 : 0,
      curve: Curves.easeIn,
      margin: EdgeInsets.only(
        left: 40,
      ),
      child: Column(
        children: [
          subDetail(
            title: System.data.resource.provider,
            value: model.shipment.insuranceName ?? "-",
          ),
          SizedBox(
            height: 10,
          ),
          subDetail(
            title: System.data.resource.insuranceType,
            value: model.shipment.insuranceTypeName ?? "-",
          ),
          SizedBox(
            height: 10,
          ),
          subDetail(
            title: System.data.resource.coverageInsurance,
            value: model.shipment.premiName ?? "-",
          ),
          SizedBox(
            height: 10,
          ),
          subDetail(
            title: System.data.resource.estimateGoodsPrice,
            value:
                "Rp. ${model.shipment.estimateGoodsPrice == null ? "-" : NumberFormat("#,###", System.data.resource.locale).format(model.shipment.estimateGoodsPrice ?? 0)}",
          ),
        ],
      ),
    );
  }

  Widget shipCost() {
    return detail(
      titleWidget: Expanded(
        child: Container(
            child: Row(
          children: [
            Text(
              "${System.data.resource.shipCost}",
              style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.primaryColor,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                model.showShipCost = !model.showShipCost;
                model.commit();
              },
              child: Icon(
                !model.showShipCost
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: System.data.colorUtil.primaryColor,
              ),
            )
          ],
        )),
      ),
      value:
          "Rp. ${NumberFormat("#,###.#", System.data.resource.locale).format(model.shipment.totalShipCost ?? 0)}",
      sub: true,
    );
  }

  Widget shipCostDetail() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: model.showShipCost
          ? model.shipment.shipmentInvoiceItem
                  .where((e) => e.itemCode == "SHIPCOST")
                  .toList()
                  .length *
              30.0
          : 0,
      curve: Curves.easeIn,
      margin: EdgeInsets.only(
        left: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          model.shipment.shipmentInvoiceItem
              .where((e) => e.itemCode == "SHIPCOST")
              .toList()
              .length,
          (index) {
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              child: subDetail(
                title: model.shipment.shipmentInvoiceItem
                    .where((e) => e.itemCode == "SHIPCOST")
                    .toList()[index]
                    .remarks,
                value:
                    "Rp. ${NumberFormat("#,###.#", System.data.resource.locale).format(model.shipment.shipmentInvoiceItem.where((e) => e.itemCode == "SHIPCOST").toList()[index].totalPricing ?? 0)}",
              ),
            );
          },
        ),
      ),
    );
  }
}
