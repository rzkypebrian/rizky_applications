import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/ratingComponent.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart'
    as sampleDecoration;
import 'package:enerren/model/tmsDeliveryEmergencyModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:component_icons/font_awesome.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'presenter.dart';
import 'package:enerren/util/StringExtention.dart';
import 'viewModel.dart';

class View<T> extends PresenterState {
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
            // bottomNavigationBar: bottomNavigationBar(),
          );
        },
      ),
    );
  }

  Widget bottomNavigationBar() {
    return Column(
      children: [
        (super
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
            : SizedBox(),
        widget.showButtonViewTripAllowanceBalance
            ? bottomAddTripReport()
            : SizedBox(),
        widget.showButtonAddTripAllowanceBalance
            ? bottomAddTripAllowance()
            : SizedBox(),
      ],
    );
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
          Expanded(
            child: Container(
              child: Text(
                "${super.model.shipment.shipmentNumber}",
                style: System.data.textStyleUtil.mainLabel(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                "${DateFormat('EEEE, dd MMMM yyyy', '${System.data.resource.locale}').format(super.model.shipment.shipmentDate)}",
                textAlign: TextAlign.end,
                style: System.data.textStyleUtil.mainLabel(
                  fontWeight: FontWeight.w500,
                  fontSize: System.data.fontUtil.m,
                ),
              ),
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
              System.data.colorUtil.primaryColor2,
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
                text:
                    widget.finisButtonLabel ?? System.data.resource.pendingPod,
                textColor: System.data.colorUtil.secondaryColor,
                colorBackground: System.data.colorUtil.primaryColor,
              );
            } else {
              return buttonFinish();
            }
          },
        ),
      ),
    );
  }

  Widget buttonFinish() {
    return BottonComponent.roundedButton(
      onPressed: () => finishShipment(),
      text: widget.finisButtonLabel ?? System.data.resource.finish,
      textColor: System.data.colorUtil.secondaryColor,
      colorBackground: System.data.colorUtil.primaryColor,
    );
  }

  Widget bottomAddTripReport() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
          left: 14,
          right: 14,
          bottom: 17,
        ),
        child: BottonComponent.roundedButton(
          onPressed: () => super.tripReport(),
          text: widget.finisButtonLabel ?? "${System.data.resource.tripReport}",
          textColor: System.data.colorUtil.secondaryColor,
          colorBackground: System.data.colorUtil.primaryColor,
        ),
      ),
    );
  }

  Widget bottomAddTripAllowance() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
          left: 14,
          right: 14,
          bottom: 17,
        ),
        child: BottonComponent.roundedButton(
          onPressed: () => super.addTripAllowance(),
          text: widget.finisButtonLabel ??
              "${System.data.resource.addBalance} ${System.data.resource.allowance}",
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
            shipment(),
            truck(),
            products(),
            detailProduct(),
            statusOrder(),
            bottomNavigationBar(),
          ],
        ),
      ),
    );
  }

  Widget products() {
    return Container();
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

  Widget shipment() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(right: 24, bottom: 10, top: 10, left: 20),
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
      child: Container(
        child: Column(
          children: List.generate(
            model.shipment.tmsShipmentDestinationList.length,
            (i) {
              return Column(
                children: [
                  i == 0
                      ? sampleDecoration.DecorationComponent.detailShipment(
                          context: context,
                          showContactPerson: widget.showContactPerson,
                          showStatusInCharge: widget.showInchargeStatus,
                          showLinkToPickup: true,
                          onTapLinkToPickup: () {
                            ontapPickupDetail(model
                                .shipment
                                .tmsShipmentDestinationList
                                .first
                                .detailshipmentId);
                          },
                          poinName: "${System.data.resource.pickUpLocation}",
                          rightWidget: GestureDetector(
                            onTap: () {
                              widget.onTapTrack(model.shipment);
                            },
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "${System.data.resource.track}",
                                  style: System.data.textStyleUtil.linkLabel(),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  FontAwesomeRegular(
                                      FontAwesomeId.fa_chevron_right),
                                  size: 15,
                                  color: System.data.colorUtil.primaryColor,
                                ),
                              ],
                            ),
                          ),
                          name:
                              "${model.shipment.tmsShipmentDestinationList.first.originContactPerson}",
                          phone:
                              "${model.shipment.tmsShipmentDestinationList.first.originContactNumber}",
                          next: true,
                          icon: SvgPicture.asset("assets/boxs.svg"),
                          address:
                              "${model.shipment.tmsShipmentDestinationList.first.originAddress}",
                          detailAddress:
                              "${model.shipment.tmsShipmentDestinationList.first.originAdditionalInfo}",
                          guarent: false,
                          onTapNoteForDriver: () {
                            sampleDecoration.DecorationComponent.detailNote(
                                context,
                                noteForDriver: model
                                    .shipment
                                    .tmsShipmentDestinationList[i]
                                    .originNoteForDriver);
                          },
                        )
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                  sampleDecoration.DecorationComponent.detailShipment(
                    context: context,
                    showContactPerson: widget.showContactPerson,
                    showStatusInCharge: widget.showInchargeStatus,
                    showLinkToPod: true,
                    onTapLinkToPod: () {
                      onTapUnloadingDetail(
                        model.shipment.tmsShipmentDestinationList[i]
                            .detailshipmentId,
                      );
                    },
                    poinName:
                        "${System.data.resource.destination} ${model.shipment.tmsShipmentDestinationList.length > 1 ? i + 1 : ""}",
                    name:
                        "${model.shipment.tmsShipmentDestinationList[i].destinationContactPerson}",
                    phone:
                        "${model.shipment.tmsShipmentDestinationList[i].destinationContactNumber}",
                    icon: model.shipment.tmsShipmentDestinationList.length == 1
                        ? Icon(
                            FontAwesomeSolid(FontAwesomeId.fa_map_marker_alt),
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
                                  color: System.data.colorUtil.lightTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                    address:
                        "${model.shipment.tmsShipmentDestinationList[i].destinationAddress}",
                    detailAddress:
                        "${model.shipment.tmsShipmentDestinationList[i].destinationAdditionalInfo}",
                    guarent: false,
                    next: (i + 1) !=
                            model.shipment.tmsShipmentDestinationList.length
                        ? true
                        : false,
                    onTapNoteForDriver: () {
                      sampleDecoration.DecorationComponent.detailNote(context,
                          noteForDriver: model
                              .shipment
                              .tmsShipmentDestinationList[i]
                              .destinationNoteForDriver);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
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
    return Container();
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
