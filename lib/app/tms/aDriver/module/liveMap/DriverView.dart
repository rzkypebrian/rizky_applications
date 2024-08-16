import 'package:enerren/app/tms/aDriver/localData.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/externalLinkComponent.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/module/liveMaps/view.dart';
import 'package:enerren/util/GeolocatorUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:component_icons/font_awesome.dart';
import 'package:enerren/module/liveMaps/main.dart';
import '../../../../../util/SystemUtil.dart';
import 'ViewModelLiveMap.dart';
import 'driverPresenter.dart';
import 'package:enerren/util/StringExtention.dart';

class DriverView extends View with DriverPresenter {
  final ValueChanged<ViewModeliveMap> onTapPickup;
  final VoidCallback onTapStart;
  final ValueChanged2Param<ViewModeliveMap, int> onTapFinish;
  final TmsShipmentModel tmsShipmentModel;
  final ValueChanged<ViewModeliveMap> onTapDetail;
  final ValueChanged<ViewModeliveMap> onTapEmergency;
  final bool showStartButton;
  final String headerStartStatusCode;
  final bool showPickupButton;
  final String headerPickUpStatusCode;
  final String headerUnloadingStatusCode;
  final String headerFinishStatusCode;
  final String destinationUnloadingStatusCode;

  DriverView({
    this.onTapPickup,
    this.onTapStart,
    this.onTapFinish,
    this.tmsShipmentModel,
    this.onTapDetail,
    this.onTapEmergency,
    this.showStartButton,
    this.showPickupButton = true,
    this.headerStartStatusCode,
    this.headerPickUpStatusCode,
    this.headerUnloadingStatusCode,
    this.headerFinishStatusCode,
    this.destinationUnloadingStatusCode,
  }) {
    super.viewModeliveMap.tmsShipmentModel = this.tmsShipmentModel;
    super.onTapFinish = this.onTapFinish;
    super.pickupStatusCode = this.headerPickUpStatusCode;
    super.headerUnloadingStatusCode = this.headerUnloadingStatusCode;
    super.destinationUnloadingStatusCode = this.destinationUnloadingStatusCode;
  }

  @override
  void initState() {
    super.bottomSheetHeight = 450;
    super.bottomSheetContentPadding = EdgeInsets.only(top: 15);
    super.initState();
    super.bottomSheetController.expand();
  }

  @override
  List<Widget> listComponent() {
    return <Widget>[
      map(),
      bottomSheet(),
      DecorationComponent.circularLOadingIndicator(
          controller: viewModeliveMap.loadingController),
    ];
  }

  @override
  Widget floatingActionBotton() {
    return null;
  }

  Widget bottomSheetContent() {
    return ChangeNotifierProvider<ViewModeliveMap>(
      create: (BuildContext context) => viewModeliveMap,
      child: Consumer<ViewModeliveMap>(
        builder: (ctx, dt, child) {
          return Center(
            child: Container(
              child: Stack(
                children: <Widget>[
                  viewModeliveMap.tmsShipmentModel.shipmentStatus !=
                          (headerFinishStatusCode ?? "POD")
                      ? emergencyBotton()
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        onTapDetail(viewModeliveMap);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        child: Text(
                          System.data.resource.detail,
                          style: System.data.textStyleUtil.linkLabel(
                            textDecoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 120,
                            width: 200,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  child: SvgPicture.asset(
                                      "assets/angkut/background_bercak_avatar.svg"),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    margin:
                                        EdgeInsets.only(left: 17, bottom: 9),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(System.data
                                              .getLocal<LocalData>()
                                              .user
                                              .urlProfileImage),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 25,
                            width: 120,
                            child: BottonComponent.roundedButton(
                                colorBackground:
                                    System.data.colorUtil.primaryColor,
                                text:
                                    "${System.data.getLocal<LocalData>().user.driverName}",
                                textstyle:
                                    System.data.textStyleUtil.mainTitle()),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.only(bottom: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: System.data.colorUtil.greyColor,
                              style: BorderStyle.solid,
                            ))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // Expanded(
                                //   child: Text(
                                //     "${viewModeliveMap.tmsShipmentModel.distancePickupToDestination} km ${System.data.resource.distanceToLocationPickup}",
                                //     style:
                                //         System.data.textStyleUtil.linkLabel(),
                                //   ),
                                // ),
                                GestureDetector(
                                  onTap: () =>
                                      ExternalLinkComponent.openGooleMap(
                                    lat: getMapLocationDirection.latitude,
                                    lon: getMapLocationDirection.longitude,
                                  ),
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    margin: EdgeInsets.only(right: 10),
                                    // child: SvgPicture.asset(
                                    //   "assets/angkut/navigation_icon.svg",
                                    // ),
                                    child: Icon(
                                      Icons.place,
                                      color: System.data.colorUtil.primaryColor,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => ExternalLinkComponent.openPhone(
                                      viewModeliveMap
                                          .tmsShipmentModel.customerPhone),
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    margin: EdgeInsets.only(right: 10),
                                    child: SvgPicture.asset(
                                      "assets/angkut/help_tlp.svg",
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => ExternalLinkComponent.openWA(
                                      viewModeliveMap
                                          .tmsShipmentModel.customerPhone),
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    child: SvgPicture.asset(
                                      "assets/angkut/whatsApp_logo.svg",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 5,
                            ),
                            width: double.infinity,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${System.data.resource.pickUpLocation}",
                                    style:
                                        System.data.textStyleUtil.linkLabel(),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  FutureBuilder<String>(
                                    initialData:
                                        "${System.data.resource.loading}",
                                    future: GeolocatorUtil.getAddress(
                                      pickupLocation.latitude,
                                      pickupLocation.longitude,
                                    ),
                                    builder: ((ctx, snapshoot) {
                                      return Text(
                                        "${snapshoot.data}",
                                        style: System.data.textStyleUtil
                                            .mainLabel(),
                                      );
                                    }),
                                  ),
                                  // SizedBox(
                                  //   height: 5,
                                  // ),
                                  Container(
                                    height: 20,
                                    padding: EdgeInsets.all(0),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: 10,
                                            child: IconButton(
                                              padding: EdgeInsets.all(0),
                                              iconSize: 15,
                                              onPressed: () => viewModeliveMap
                                                  .changePageButton(
                                                      next: false),
                                              icon: Icon(
                                                FontAwesomeRegular(FontAwesomeId
                                                    .fa_chevron_left),
                                                color: viewModeliveMap
                                                            .tmsShipmentModel
                                                            .tmsShipmentDestinationList
                                                            .where((f) =>
                                                                f.detailshipmentId <
                                                                    viewModeliveMap
                                                                        .tmsShipmentModel
                                                                        .tmsShipmentDestinationList[viewModeliveMap
                                                                            .starPage]
                                                                        .detailshipmentId &&
                                                                (f.detailStatus) ==
                                                                    destinationUnloadingStatusCode)
                                                            .length >
                                                        0
                                                    ? System.data.colorUtil
                                                        .primaryColor
                                                    : Colors.transparent,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 10,
                                            child: IconButton(
                                              padding: EdgeInsets.all(0),
                                              iconSize: 15,
                                              onPressed: () => viewModeliveMap
                                                  .changePageButton(),
                                              icon: Icon(
                                                FontAwesomeRegular(
                                                  FontAwesomeId
                                                      .fa_chevron_right,
                                                ),
                                                color: viewModeliveMap
                                                            .tmsShipmentModel
                                                            .tmsShipmentDestinationList
                                                            .where((f) =>
                                                                f.detailshipmentId >
                                                                    viewModeliveMap
                                                                        .tmsShipmentModel
                                                                        .tmsShipmentDestinationList[viewModeliveMap
                                                                            .starPage]
                                                                        .detailshipmentId &&
                                                                (f.detailStatus) ==
                                                                    destinationUnloadingStatusCode)
                                                            .length >
                                                        0
                                                    ? System.data.colorUtil
                                                        .primaryColor
                                                    : Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    child: PageView(
                                      onPageChanged: viewModeliveMap.changePage,
                                      controller:
                                          viewModeliveMap.pageController,
                                      children: List.generate(
                                        viewModeliveMap.totalDestination,
                                        (i) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${System.data.resource.destination} ${i + 1}",
                                                      style: System
                                                          .data.textStyleUtil
                                                          .linkLabel(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              !viewModeliveMap
                                                      .tmsShipmentModel
                                                      .tmsShipmentDestinationList[
                                                          i]
                                                      .destinationAddress
                                                      .isNullOrEmpty()
                                                  ? Text(
                                                      "${viewModeliveMap.tmsShipmentModel.tmsShipmentDestinationList[i].destinationAddress}",
                                                      style: System
                                                          .data.textStyleUtil
                                                          .mainLabel(),
                                                    )
                                                  : FutureBuilder<String>(
                                                      future: GeolocatorUtil
                                                          .getAddress(
                                                        viewModeliveMap
                                                            .tmsShipmentModel
                                                            .tmsShipmentDestinationList[
                                                                i]
                                                            .destinationLat,
                                                        viewModeliveMap
                                                            .tmsShipmentModel
                                                            .tmsShipmentDestinationList[
                                                                i]
                                                            .destinationLong,
                                                      ),
                                                      builder:
                                                          (ctx, snapshoot) {
                                                        return Text(
                                                          "${snapshoot.data}",
                                                          style: System.data
                                                              .textStyleUtil
                                                              .mainLabel(),
                                                        );
                                                      },
                                                    ),
                                              GestureDetector(
                                                onTap: () {
                                                  DecorationComponent.detailNote(
                                                      context,
                                                      noteForDriver: viewModeliveMap
                                                          .tmsShipmentModel
                                                          .tmsShipmentDestinationList[
                                                              i]
                                                          .originNoteForDriver);
                                                },
                                                child: Container(
                                                  alignment: Alignment.topRight,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "${System.data.resource.note}",
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: System
                                                            .data.textStyleUtil
                                                            .linkLabel(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Icon(
                                                        FontAwesomeRegular(
                                                          FontAwesomeId
                                                              .fa_clipboard_list_check,
                                                        ),
                                                        size: 15,
                                                        color: System
                                                            .data
                                                            .colorUtil
                                                            .primaryColor,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 50,
                      color: Colors.red,
                      child: Row(
                        children: <Widget>[
                          showStartButton == true
                              ? Expanded(
                                  child: Container(
                                    height: double.infinity,
                                    child: BottonComponent.roundedButton(
                                      onPressed: () {
                                        if ((viewModeliveMap.tmsShipmentModel
                                                    .shipmentStatus ==
                                                (headerStartStatusCode ??
                                                    "GETDRV") &&
                                            isEmergency == false)) {
                                          confirmStartButton();
                                        }
                                      },
                                      colorBackground: (viewModeliveMap
                                                      .tmsShipmentModel
                                                      .shipmentStatus ==
                                                  (headerStartStatusCode ??
                                                      "GETDRV") &&
                                              isEmergency == false)
                                          ? System.data.colorUtil.primaryColor
                                          : System.data.colorUtil.greyColor,
                                      radius: 0,
                                      text: "${System.data.resource.start}",
                                      textColor: Colors.red,
                                      textstyle: System.data.textStyleUtil
                                          .mainTitle(
                                              color: System.data.colorUtil
                                                  .lightTextColor),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          showPickupButton == true
                              ? Expanded(
                                  child: Container(
                                    height: double.infinity,
                                    // decoration: BoxDecoration(
                                    //   border: Border(
                                    //     right: BorderSide(
                                    //         color: Colors.white,
                                    //         style: BorderStyle.solid,
                                    //         width: 3),
                                    //     left: BorderSide(
                                    //         color: Colors.white,
                                    //         style: BorderStyle.solid,
                                    //         width: 3),
                                    //   ),
                                    // ),
                                    child: BottonComponent.roundedButton(
                                      onPressed: () {
                                        if ((viewModeliveMap.tmsShipmentModel
                                                    .shipmentStatus ==
                                                (headerPickUpStatusCode ??
                                                    "PICK") &&
                                            isEmergency == false)) {
                                          if (viewModeliveMap.tmsShipmentModel
                                                      .customerName ==
                                                  viewModeliveMap
                                                      .tmsShipmentModel
                                                      .tmsShipmentDestinationList
                                                      .first
                                                      .originContactPerson &&
                                              viewModeliveMap.tmsShipmentModel
                                                      .customerPhone ==
                                                  viewModeliveMap
                                                      .tmsShipmentModel
                                                      .tmsShipmentDestinationList
                                                      .first
                                                      .originContactNumber) {
                                            // popUpConfirmReveiveCashPayment(
                                            // callback: () {
                                            // onTapPickup(viewModeliveMap);
                                            // });
                                            onTapPickup(viewModeliveMap);
                                          } else {
                                            onTapPickup(viewModeliveMap);
                                          }
                                        }
                                      },
                                      colorBackground: (viewModeliveMap
                                                      .tmsShipmentModel
                                                      .shipmentStatus ==
                                                  (headerPickUpStatusCode ??
                                                      "PICK") &&
                                              isEmergency == false)
                                          ? System.data.colorUtil.primaryColor
                                          : System.data.colorUtil.greyColor,
                                      radius: 0,
                                      text: "${System.data.resource.pickUp}",
                                      textColor: Colors.red,
                                      textstyle: System.data.textStyleUtil
                                          .mainTitle(
                                              color: System.data.colorUtil
                                                  .lightTextColor),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          Expanded(
                            child: Container(
                              height: double.infinity,
                              child: BottonComponent.roundedButton(
                                onPressed: () {
                                  if ((viewModeliveMap.tmsShipmentModel
                                              .shipmentStatus ==
                                          (headerUnloadingStatusCode ??
                                              "DELV") &&
                                      isEmergency == false)) {
                                    if (
                                        //jika boleh acak
                                        // !viewModeliveMap
                                        //   .finishUnloadingDestinetion
                                        //jika harus berurut
                                        getNextDestination() != null) {
                                      if (viewModeliveMap.tmsShipmentModel
                                                  .customerName ==
                                              getNextDestination()
                                                  .destinationContactPerson &&
                                          viewModeliveMap.tmsShipmentModel
                                                  .customerPhone ==
                                              getNextDestination()
                                                  .destinationContactNumber) {
                                        // popUpConfirmReveiveCashPayment(
                                        //     callback: () {
                                        //   onFinish();
                                        // });
                                        onFinish();
                                      } else {
                                        onFinish();
                                      }
                                    }
                                  }
                                },
                                colorBackground: viewModeliveMap
                                                .tmsShipmentModel
                                                .shipmentStatus ==
                                            ("DELV") &&
                                        isEmergency == false
                                    ?
                                    //jika boleh bebas
                                    // !viewModeliveMap
                                    //         .finishUnloadingDestinetion
                                    //jiha harus berurut
                                    getNextDestination() != null
                                        ? System.data.colorUtil.primaryColor
                                        : System.data.colorUtil.greyColor
                                    : System.data.colorUtil.greyColor,
                                radius: 0,
                                text: getNextDestinationId() ==
                                            viewModeliveMap
                                                .tmsShipmentModel
                                                .tmsShipmentDestinationList
                                                .last
                                                .detailshipmentId ||
                                        getNextDestination() == null
                                    ? "${System.data.resource.finish}"
                                    : "${System.data.resource.destination} ${getNextPodDestinationOrderNumber(getNextDestinationId())}",
                                textColor: Colors.red,
                                textstyle: System.data.textStyleUtil.mainTitle(
                                    color:
                                        System.data.colorUtil.lightTextColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget emergencyBotton() {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () {
          if (viewModeliveMap.tmsShipmentModel.shipmentStatus == "EMRGCY") {
            popUpCancelEmergency();
          } else if (isEmergency) {
          } else {
            onTapEmergency(viewModeliveMap);
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: 15),
          child: SvgPicture.asset(
            "assets/angkut/icon_emergency.svg",
            color: viewModeliveMap.tmsShipmentModel.shipmentStatus == "EMRGCY"
                ? System.data.colorUtil.yellowColor
                : isEmergency
                    ? System.data.colorUtil.redColor
                    : null,
          ),
        ),
      ),
    );
  }

  void popUpCancelEmergency() {
    ModalComponent.bottomModalWithCorner(
      context,
      height: 316,
      child: Container(
        height: 300,
        // color: Colors.red,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: SvgPicture.asset(
                            "assets/angkut/background_ilustrasi_darurat.svg"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        bottom: 30,
                        left: 15,
                        right: 15,
                      ),
                      child: Text(
                        "${System.data.resource.areYouSureToCancelThisEmergencyOrder}?",
                        textAlign: TextAlign.center,
                        style: System.data.textStyleUtil.linkLabel(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 55,
              decoration: BoxDecoration(
                border: Border.all(
                  color: System.data.colorUtil.primaryColor,
                  style: BorderStyle.solid,
                  width: 2,
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: BottonComponent.roundedButton(
                      border: Border.all(
                        color: Colors.transparent,
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        cancleEmergency();
                      },
                      text: System.data.resource.yes,
                      colorBackground: System.data.colorUtil.primaryColor,
                      textstyle: System.data.textStyleUtil.mainTitle(
                        color: System.data.colorUtil.lightTextColor,
                      ),
                      radius: 0,
                    ),
                  ),
                  Expanded(
                    child: BottonComponent.roundedButton(
                        text: System.data.resource.no,
                        colorBackground: Colors.white,
                        textstyle: System.data.textStyleUtil.mainTitle(
                          color: System.data.colorUtil.darkTextColor,
                        ),
                        radius: 0,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // void popUpConfirmReveiveCashPayment({
  //   @required VoidCallback callback,
  // }) {
  //   tmsShipmentModel.isShipmentPayed(
  //     token: System.data.global.token,
  //     shipmentId: super.viewModeliveMap.tmsShipmentModel.tmsShipmentId,
  //   ).then((value) {
  //     value == true
  //         ? callback()
  //         : ModalComponent.bottomModalWithCorner(
  //             context,
  //             child: Container(
  //               height: 234,
  //               child: Stack(
  //                 children: <Widget>[
  //                   Container(
  //                     alignment: Alignment.topCenter,
  //                     child: Column(
  //                       children: <Widget>[
  //                         Container(
  //                             child: SvgPicture.asset(
  //                                 "assets/angkut/pay_customer.svg")),
  //                         SizedBox(
  //                           height: 20,
  //                         ),
  //                         Text(
  //                           "${System.data.resource.whetherYouHaveReceivedThePayment}",
  //                           textAlign: TextAlign.center,
  //                           style: System.data.textStyleUtil.mainLabel(
  //                               color: System.data.colorUtil.primaryColor),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Container(
  //                     alignment: Alignment.bottomCenter,
  //                     child: Divider(
  //                       height: 20,
  //                       color: System.data.colorUtil.primaryColor,
  //                     ),
  //                   ),
  //                   Align(
  //                     alignment: Alignment.bottomCenter,
  //                     child: Container(
  //                       margin: EdgeInsets.only(top: 10),
  //                       height: 46,
  //                       // color: System.data.colorUtil.primaryColor,
  //                       color: Colors.red,
  //                       child: Row(
  //                         children: <Widget>[
  //                           Expanded(
  //                             child: GestureDetector(
  //                               onTap: () {
  //                                 Navigator.of(context).pop();
  //                                 AngkutShipmentModel.setShipmentPayed(
  //                                         token: System.data.global.token,
  //                                         shipmentId: super
  //                                             .viewModeliveMap
  //                                             .tmsShipmentModel
  //                                             .tmsShipmentId)
  //                                     .then((value) {
  //                                   callback();
  //                                 }).catchError((onError) {
  //                                   mapLoadingController.stopLoading(
  //                                     messageAlign: Alignment.topCenter,
  //                                     messageWidget: DecorationComponent
  //                                         .topMessageDecoration(
  //                                       message:
  //                                           ErrorHandlingUtil.handleApiError(
  //                                               onError),
  //                                     ),
  //                                   );
  //                                 });
  //                               },
  //                               child: Container(
  //                                 color: System.data.colorUtil.primaryColor,
  //                                 child: Center(
  //                                   child: Text(
  //                                     "${System.data.resource.already}",
  //                                     style: System.data.textStyleUtil
  //                                         .mainLabel(
  //                                             color: System.data.colorUtil
  //                                                 .secondaryColor),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Expanded(
  //                             child: GestureDetector(
  //                               onTap: () {
  //                                 Navigator.of(context).pop();
  //                               },
  //                               child: Container(
  //                                 color: System.data.colorUtil.secondaryColor,
  //                                 child: Center(
  //                                   child: Text(
  //                                     "${System.data.resource.notYet}",
  //                                     style: System.data.textStyleUtil
  //                                         .mainLabel(
  //                                             color: System
  //                                                 .data.colorUtil.primaryColor),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           );
  //   }).catchError((onError) {
  //     mapLoadingController.stopLoading(
  //       messageAlign: Alignment.topCenter,
  //       messageWidget: DecorationComponent.topMessageDecoration(
  //         message: ErrorHandlingUtil.handleApiError(onError),
  //       ),
  //     );
  //   });
  // }
}
