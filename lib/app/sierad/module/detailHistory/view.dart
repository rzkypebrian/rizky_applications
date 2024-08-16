import 'package:enerren/app/sierad/util/WordingUtil.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/ratingComponent.dart';
import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/model/tmsDeliveryEmergencyModel.dart';
import 'package:enerren/util/GeolocatorUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:component_icons/font_awesome.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'presenter.dart';
import 'package:enerren/util/StringExtention.dart';
import 'viewModel.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => super.model,
      child: Consumer<ViewModel>(
        builder: (ctx, dt, child) {
          return Scaffold(
              backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
              appBar: appBar(),
              body: Stack(
                children: <Widget>[
                  home(),
                  cirularProgressIndicator(),
                ],
              ),
              bottomNavigationBar: bottomNavigationBar());
        },
      ),
    );
  }

  Widget bottomNavigationBar() {
    return (super
                        .model
                        .shipment
                        .tmsShipmentDestinationList
                        .first
                        .detailStatusOrder ??
                    0) >=
                300 &&
            (super
                        .model
                        .shipment
                        .tmsShipmentDestinationList
                        .first
                        .detailStatusOrder ??
                    0) <
                400
        ? bottomNavigationBarFinish()
        : (super
                        .model
                        .shipment
                        .tmsShipmentDestinationList
                        .first
                        .detailStatusOrder ??
                    0) >=
                400
            ? bottomNavigationBarViewPod()
            : Container(
                height: 0,
                width: 0,
              );
    // return bottomNavigationBarFinish();
  }

  Widget cirularProgressIndicator() {
    return DecorationComponent.circularProgressDecoration(
      controller: loadingController,
    );
  }

  Widget order() {
    return Container(
      margin: EdgeInsets.only(
        top: 16,
        left: 27,
        right: 27,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "No Order ${super.model.shipment.shipmentNumber}",
            style: System.data.textStyleUtil.mainLabel(
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            "${DateFormat('EEEE, ${System.data.resource.dateFormat}', '${System.data.resource.locale}').format(super.model.shipment.shipmentDate)}",
            style: System.data.textStyleUtil.mainLabel(
              fontWeight: FontWeight.w500,
              fontSize: System.data.fontUtil.m,
            ),
          )
        ],
      ),
    );
  }

  Widget user() {
    return Container(
      height: 74,
      margin: EdgeInsets.only(
        top: 8,
      ),
      padding: EdgeInsets.only(left: 28, right: 28),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: System.data.colorUtil.shadowColor.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              System.data.colorUtil.primaryColor,
              System.data.colorUtil.greenColor,
            ],
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.only(
                right: 16,
              ),
              width: 53,
              height: 53,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                ),
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new NetworkImage(super
                          .model
                          .shipment
                          .customerImageUrl
                          .isNullOrEmpty()
                      ? "https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
                      : super.model.shipment.customerImageUrl),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "${System.data.resource.customer}",
                              style: System.data.textStyleUtil.linkLabel(
                                color: System.data.colorUtil.yellowColor,
                              ),
                            ),
                            Text(
                              "${super.model.shipment.customerName}",
                              style: System.data.textStyleUtil.linkLabel(
                                color: System.data.colorUtil.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "${System.data.resource.receiver}",
                              style: System.data.textStyleUtil.linkLabel(
                                color: System.data.colorUtil.yellowColor,
                              ),
                            ),
                            Text(
                              "${super.model.shipment.tmsShipmentDestinationList.first.receiverName}",
                              textAlign: TextAlign.end,
                              style: System.data.textStyleUtil.linkLabel(
                                color: System.data.colorUtil.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomNavigationBarFinish() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.only(
        left: 14,
        right: 14,
        bottom: 17,
      ),
      child: FutureBuilder<bool>(
        future: super.checkPandingPod(),
        builder: (ctx, snapshoot) {
          if (snapshoot.data == true) {
            return BottonComponent.roundedButton(
              onPressed: () => pendingPod(),
              text: widget.finisButtonLabel ?? System.data.resource.pendingPod,
              textColor: System.data.colorUtil.secondaryColor,
              colorBackground: System.data.colorUtil.primaryColor,
            );
          } else {
            return BottonComponent.roundedButton(
              onPressed: () => finishShipment(),
              text: widget.finisButtonLabel ?? System.data.resource.finish,
              textColor: System.data.colorUtil.secondaryColor,
              colorBackground: System.data.colorUtil.primaryColor,
            );
          }
        },
      ),
    ));
  }

  Widget bottomNavigationBarViewPod() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
          left: 14,
          right: 14,
          bottom: 17,
        ),
        child: BottonComponent.roundedButton(
          onPressed: () => viewPod(),
          text: widget.finisButtonLabel ?? System.data.resource.viewPOD,
          textColor: System.data.colorUtil.secondaryColor,
          colorBackground: System.data.colorUtil.primaryColor,
        ),
      ),
    );
  }

  Widget home() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            order(),
            user(),
            historyDriver(),
            location(),
            truck(),
            products(),
            detailProduct(),
            statusOrder(),
          ],
        ),
      ),
    );
  }

  Widget products() {
    return Container(
      margin: EdgeInsets.only(
        top: 12,
      ),
      padding: EdgeInsets.only(
        left: 27,
        right: 27,
        top: 12,
      ),
      decoration: BoxDecoration(
        color: System.data.colorUtil.secondaryColor,
        boxShadow: [
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: productItemDeail(),
      ),
    );
  }

  List<Widget> productItemDeail() {
    return <Widget>[
      noHatchery(),
      shipmentType(),
      poultryType(),
      grade(),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: <Widget>[
      //     Padding(
      //       padding: const EdgeInsets.only(left: 15),
      //       child: Text(
      //         "${System.data.resource.information}",
      //         style: System.data.textStyleUtil.mainLabel(),
      //       ),
      //     ),
      //     Text(
      //       "-",
      //       style: System.data.textStyleUtil.mainLabel(),
      //     ),
      //   ],
      // ),
      // SizedBox(
      //   height: 15,
      // ),
      vaksin(),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: <Widget>[
      //     Padding(
      //       padding: const EdgeInsets.only(left: 15),
      //       child: Text(
      //         "${System.data.resource.information}",
      //         style: System.data.textStyleUtil.mainLabel(),
      //       ),
      //     ),
      //     Text(
      //       "-",
      //       style: System.data.textStyleUtil.mainLabel(),
      //     ),
      //   ],
      // ),
      // SizedBox(
      //   height: 15,
      // ),
      stain(),

      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: <Widget>[
      //     Padding(
      //       padding: const EdgeInsets.only(left: 15),
      //       child: Text(
      //         "${System.data.resource.information}",
      //         style: System.data.textStyleUtil.mainLabel(),
      //       ),
      //     ),
      //     Text(
      //       "-",
      //       style: System.data.textStyleUtil.mainLabel(),
      //     ),
      //   ],
      // ),
      // SizedBox(
      //   height: 15,
      // ),
      Divider(
        color: System.data.colorUtil.darkTextColor,
        height: 10,
      ),
      detailDelivery(),
    ];
  }

  Widget noHatchery() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.only(top: 5, bottom: 15),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.black,
        style: BorderStyle.solid,
      ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${System.data.resource.noHatchery}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
          Text(
            "${super.model.shipment.tmsShipmentDestinationList.first.shipmentDetailDataObject?.hatcheryCodeDestination}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
        ],
      ),
    );
  }

  Widget shipmentType() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${System.data.resource.shipmentType}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
          Text(
            "${super.model.shipment.shipmentTypeName}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
        ],
      ),
    );
  }

  Widget poultryType() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${System.data.resource.poultryType}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
          Text(
            "${super.model.shipment.tmsShipmentDestinationList.first.shipmentDetailDataObject?.poultryTypeName}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
        ],
      ),
    );
  }

  Widget grade() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${System.data.resource.grade}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
          Text(
            "${super.model.shipment.tmsShipmentDestinationList.first.shipmentDetailDataObject?.docGradeName}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
        ],
      ),
    );
  }

  Widget vaksin() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${System.data.resource.vaksin}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
          Text(
            "${super.model.shipment.tmsShipmentDestinationList.first.shipmentDetailDataObject?.docVaccineName}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
        ],
      ),
    );
  }

  Widget stain() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${System.data.resource.strain}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
          Text(
            "-",
            // "${super.model.shipment.tmsShipmentDestinationList.first.shipmentDetailDataObject?.poultryStrainName}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
        ],
      ),
    );
  }

  Widget detailDelivery() {
    return Column(
      children: <Widget>[
        numberOfBoxDelivery(),
        numberOfShipmentDelivery(),
        numberOfBonusDelivery()
      ],
    );
  }

  Widget numberOfBoxDelivery() {
    return Container(
      margin: EdgeInsets.only(bottom: 12, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${System.data.resource.numberOfBox}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
          Text(
            "${super.model.shipment.tmsShipmentDestinationList.first.shipmentDetailDataObject?.basketQty}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
        ],
      ),
    );
  }

  Widget basketCode() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${System.data.resource.basketCode}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
          Text(
            "${super.model.shipment.tmsShipmentDestinationList.first.shipmentDetailDataObject?.basketCode}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
        ],
      ),
    );
  }

  Widget trayCode() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${System.data.resource.trayCode}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
          Text(
            "${super.model.shipment.tmsShipmentDestinationList.first.shipmentDetailDataObject?.trayCode}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
        ],
      ),
    );
  }

  Widget numberOfShipmentDelivery() {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${System.data.resource.numberOf} ${super.model.shipment.shipmentTypeName} ",
            style: System.data.textStyleUtil.mainLabel(),
          ),
          Text(
            "${super.model.shipment.tmsShipmentDestinationList.first.shipmentDetailDataObject?.orderQty}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
        ],
      ),
    );
  }

  Widget numberOfBonusDelivery() {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${System.data.resource.numberOf} ${super.model.shipment.shipmentTypeName} ${System.data.resource.bonus} ",
            style: System.data.textStyleUtil.mainLabel(),
          ),
          Text(
            "${super.model.shipment.tmsShipmentDestinationList.first.shipmentDetailDataObject?.bonusQty}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
        ],
      ),
    );
  }

  Widget statusOrder() {
    return Container(
      margin: EdgeInsets.only(top: 17, bottom: 100),
      padding: EdgeInsets.only(left: 27, right: 27, top: 17, bottom: 17),
      decoration: BoxDecoration(
        color: System.data.colorUtil.secondaryColor,
        boxShadow: [
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "${System.data.resource.orderStatus}",
                  style: System.data.textStyleUtil.mainLabel(),
                ),
                Text(
                  "${super.model.shipment.tmsShipmentDestinationList.first.detailStatusName.toUpperCase()}",
                  style: System.data.textStyleUtil
                      .linkLabel(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          status == 3
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "${System.data.resource.reason}",
                      style: System.data.textStyleUtil.linkLabel(),
                    ),
                    Text(
                      "Ban Bocor",
                      style: System.data.textStyleUtil.linkLabel(
                          color: System.data.colorUtil.darkTextColor),
                    )
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget detailProducts({
    String titleStart,
    String titleEnd,
    String valueStart,
    String valueEnd,
  }) {
    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Text(
                "$titleStart",
                style: System.data.textStyleUtil.linkLabel(),
              ),
            ),
            Text(
              "$valueStart",
              style: System.data.textStyleUtil.linkLabel(
                color: System.data.colorUtil.darkTextColor,
              ),
            ),
          ],
        ),
        trailing: valueEnd.length != 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "$titleEnd",
                      style: System.data.textStyleUtil.linkLabel(),
                    ),
                  ),
                  Text(
                    "$valueEnd",
                    style: System.data.textStyleUtil.linkLabel(
                      color: System.data.colorUtil.darkTextColor,
                    ),
                  ),
                ],
              )
            : null,
      ),
    );
  }

  Widget truck() {
    return Container(
      margin: EdgeInsets.only(top: 11),
      padding: EdgeInsets.only(left: 27, right: 27),
      decoration: BoxDecoration(
        color: System.data.colorUtil.secondaryColor,
        boxShadow: [
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 12, top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "${System.data.resource.vehicleType}",
                  style: System.data.textStyleUtil.mainLabel(),
                ),
                Text(
                  "${super.model.shipment.tmsShipmentDestinationList.first.vehicleType}",
                  style: System.data.textStyleUtil.mainLabel(),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "${System.data.resource.vehicleNo}",
                  style: System.data.textStyleUtil.mainLabel(),
                ),
                Text(
                  "${super.model.shipment.tmsShipmentDestinationList.first.vehicleNo}",
                  style: System.data.textStyleUtil.mainLabel(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget location() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(right: 24, bottom: 10, top: 10),
      decoration: BoxDecoration(
        color: System.data.colorUtil.secondaryColor,
        boxShadow: [
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          FutureBuilder(
            future: GeolocatorUtil.getAddress(
              super.model.shipment.tmsShipmentDestinationList.first.originLat,
              super.model.shipment.tmsShipmentDestinationList.first.originLong,
              alt: super
                  .model
                  .shipment
                  .tmsShipmentDestinationList
                  .first
                  .originAddress,
            ),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return locationDetais(
                iconMarker: FontAwesomeSolid(
                  FontAwesomeId.fa_egg,
                ),
                activity: System.data.resource.pickUpLocation,
                description:
                    "${super.model.shipment.tmsShipmentDestinationList.first.originAddress.isNullOrEmpty() ? snapshot.data : super.model.shipment.tmsShipmentDestinationList.first.originAddress}",
                tracks: trackss,
                iconMarkerColor: System.data.colorUtil.primaryColor,
              );
            },
            initialData: "${System.data.resource.loading}...",
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
            future: GeolocatorUtil.getAddress(
              super
                  .model
                  .shipment
                  .tmsShipmentDestinationList
                  .first
                  .destinationLat,
              super
                  .model
                  .shipment
                  .tmsShipmentDestinationList
                  .first
                  .destinationLong,
              alt: super
                  .model
                  .shipment
                  .tmsShipmentDestinationList
                  .first
                  .destinationAddress,
            ),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return locationDetais(
                  track: false,
                  iconMarker: FontAwesomeSolid(
                    FontAwesomeId.fa_map_marker_alt,
                  ),
                  activity: System.data.resource.destination,
                  description:
                      "${super.model.shipment.tmsShipmentDestinationList.first.destinationAddress.isNullOrEmpty() ? snapshot.data : super.model.shipment.tmsShipmentDestinationList.first.destinationAddress}",
                  ellipsis: false,
                  iconMarkerColor: System.data.colorUtil.redColor);
            },
            initialData: "${System.data.resource.loading}...",
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: EdgeInsets.only(left: 70),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Text(
              "${super.model.shipment.tmsShipmentDestinationList.first.destinationAddressNote ?? "-"}",
              style: System.data.textStyleUtil.mainLabel(),
            ),
          )
        ],
      ),
    );
  }

  Widget locationDetais({
    bool ellipsis = true,
    IconData iconMarker,
    Color iconMarkerColor,
    bool track = true,
    VoidCallback tracks,
    String activity,
    String description,
  }) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: EdgeInsets.only(left: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Icon(
                    iconMarker,
                    color: iconMarkerColor,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${activity ?? "-"}",
                            style: System.data.textStyleUtil.linkLabel(),
                          ),
                          track
                              ? GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "${System.data.resource.track}",
                                        style: System.data.textStyleUtil
                                            .linkLabel(),
                                      ),
                                      Icon(
                                        FontAwesomeLight(
                                            FontAwesomeId.fa_chevron_right),
                                        color:
                                            System.data.colorUtil.primaryColor,
                                      ),
                                    ],
                                  ),
                                  onTap: () => tracks(),
                                )
                              : Container(),
                        ],
                      ),
                      Text(
                        "${description ?? "-"}",
                        style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                            fontSize: System.data.fontUtil.m,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ellipsis
            ? Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.only(top: 20, left: 12),
                  padding: EdgeInsets.all(0),
                  child: Icon(
                    FontAwesomeLight(FontAwesomeId.fa_ellipsis_v),
                    color: System.data.colorUtil.primaryColor,
                    size: 50,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
        title: System.data.resource.detailHistory,
        context: context,
        actionText: "",
        titleColor: System.data.colorUtil.secondaryColor,
        backButtonColor: System.data.colorUtil.lightTextColor,
        actionTextStyle: System.data.textStyleUtil.mainLabel(),
        actionTextColor: System.data.colorUtil.lightTextColor,
        titleStyle: System.data.textStyleUtil.mainTitle(),
        backgroundColor: System.data.colorUtil.primaryColor,
        rightWidget: GestureDetector(
          onTap: () {
            refresh();
          },
          child: Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.refresh,
              color: System.data.colorUtil.lightTextColor,
            ),
          ),
        ));
  }

  Widget detailProduct() {
    return Container(
      margin: EdgeInsets.only(top: 11),
      padding: EdgeInsets.only(left: 27, right: 27),
      decoration: BoxDecoration(
        color: System.data.colorUtil.secondaryColor,
        boxShadow: [
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: receivedDetail(),
    );
  }

  Widget receivedDetail() {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 20, bottom: 5),
          child: Text(
            "${System.data.resource.productDetailAllRecaipted}",
            textAlign: TextAlign.start,
            style: System.data.textStyleUtil.mainLabel(
              fontWeight: FontWeight.w600,
              fontSize: System.data.fontUtil.m,
            ),
          ),
        ),
        Container(
          child: Column(
            children: receivedDetailComponents(),
          ),
        )
      ],
    );
  }

  List<Widget> receivedDetailComponents() {
    return [
      numberOfReceived(),
      brokenOrDeadReceived(),
      bonusReceived(),
      boxReceived(),
    ];
  }

  Widget numberOfReceived() {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${System.data.resource.numberOf} ${model.shipment.shipmentTypeName} ${System.data.resource.received} ",
            style: System.data.textStyleUtil.mainLabel(),
          ),
          Text(
            "${super.model.shipment.tmsShipmentDestinationList.first.shipmentDetailDataObject?.deliveryQty}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
        ],
      ),
    );
  }

  Widget brokenOrDeadReceived() {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${System.data.resource.numberOf} ${model.shipment.shipmentTypeName} ${WordingUtil.brokenWordingByShipmentType(model.shipment.shipmentTypeName)} ",
            style: System.data.textStyleUtil.mainLabel(),
          ),
          Text(
            "${super.model.shipment.tmsShipmentDestinationList.first.shipmentDetailDataObject?.deliveryTrayQty}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
        ],
      ),
    );
  }

  Widget bonusReceived() {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${System.data.resource.numberOf} ${super.model.shipment.shipmentTypeName} ${System.data.resource.bonus} ${System.data.resource.received} ",
            style: System.data.textStyleUtil.mainLabel(),
          ),
          Text(
            "${super.model.shipment.tmsShipmentDestinationList.first.shipmentDetailDataObject?.deliveryBonusQty}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
        ],
      ),
    );
  }

  Widget boxReceived() {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${System.data.resource.numberOfBoxReceived}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
          Text(
            "${super.model.shipment.tmsShipmentDestinationList.first.shipmentDetailDataObject?.deliveryBasketQty}",
            style: System.data.textStyleUtil.mainLabel(),
          ),
        ],
      ),
    );
  }

  Widget historyDriver() {
    if (model.shipment.tmsShipmentDestinationList.first.emergencyData != null &&
        model.shipment.tmsShipmentDestinationList.first.emergencyData.length >
            0) {
      return Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 15, left: 13),
              child: Text(
                "${System.data.resource.emergencyReport}",
                style: System.data.textStyleUtil.mainLabel(
                    color: System.data.colorUtil.primaryColor,
                    fontFamily: System.data.fontUtil.primary),
              ),
            ),
            Column(
              children: List.generate(
                  model.shipment.tmsShipmentDestinationList.first.emergencyData
                      .length, (i) {
                if (model.shipment.tmsShipmentDestinationList.first
                            .emergencyData[i].driverId !=
                        model.shipment.tmsShipmentDestinationList.first
                            .driverId ||
                    model.shipment.tmsShipmentDestinationList.first
                            .emergencyData[i].emergencyStatus !=
                        1) {
                  return driver(
                      name: model.shipment.tmsShipmentDestinationList.first
                          .emergencyData[i].driverName,
                      photo: model.shipment.tmsShipmentDestinationList.first
                          .emergencyData[i].driverImageUrl,
                      rating: model.shipment.tmsShipmentDestinationList.first
                          .emergencyData[i].driverRating,
                      emergencyLampColor: model
                                  .shipment
                                  .tmsShipmentDestinationList
                                  .first
                                  .emergencyData[i]
                                  .emergencyStatus ==
                              1
                          ? System.data.colorUtil.redColor
                          : System.data.colorUtil.primaryColor,
                      emergencyModel: model.shipment.tmsShipmentDestinationList
                          .first.emergencyData[i]);
                } else {
                  return Container(
                    height: 0,
                    width: 0,
                  );
                }
              }),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 15, left: 13),
              child: Text(
                "${System.data.resource.shipment}",
                style: System.data.textStyleUtil.mainLabel(
                    color: System.data.colorUtil.primaryColor,
                    fontFamily: System.data.fontUtil.primary),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 0,
        width: 0,
      );
    }
  }

  Widget driver({
    @required String photo,
    @required String name,
    @required Color emergencyLampColor,
    @required double rating,
    @required TmsDeliveryEmergencyModel emergencyModel,
  }) {
    return GestureDetector(
      onTap: () => widget.onTapDriver(model.shipment, emergencyModel),
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 9, right: 12, left: 12),
        margin: EdgeInsets.only(bottom: 0, top: 10),
        decoration: BoxDecoration(
          color: System.data.colorUtil.secondaryColor,
          boxShadow: [
            BoxShadow(
              color: System.data.colorUtil.shadowColor.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage("$photo"),
            ),
            Container(
              margin: EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${System.data.resource.driver}",
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.primaryColor,
                        fontFamily: System.data.fontUtil.primary),
                  ),
                  Text("$name"),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    model.shipment.driverRating != null
                        ? Align(
                            alignment: Alignment.bottomRight,
                            child: RatingComponent(
                              controller: RatingController(),
                              height: 15,
                              readOnly: true,
                              // score: model.shipment.tmsShipmentDestinationList
                              //     .first.driverRating,
                              score: model.shipment.driverRating?.rating
                                  ?.toDouble(),
                              width: 30,
                              space: 0,
                              alignment: MainAxisAlignment.end,
                            ),
                          )
                        : SizedBox(),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(
                        left: 10,
                        top: 0,
                      ),
                      height: 25,
                      width: 25,
                      child: Center(
                        child: SvgPicture.asset(
                            "assets/angkut/icon_emergency.svg",
                            color: emergencyLampColor),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
