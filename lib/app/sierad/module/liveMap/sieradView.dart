import 'package:enerren/app/sierad/model/SieradShipmentDetailHatcheryModel.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/externalLinkComponent.dart';
import 'package:enerren/component/menuComponent.dart';
// import 'package:enerren/module/liveMaps/viewModel.dart';
import 'package:enerren/app/sierad/module/liveMap/SieradViewModel.dart';
import 'package:enerren/app/sierad/module/liveMap/sieradPresenter.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/vehicleInfoDecoration.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/module/liveMaps/view.dart';
import 'package:enerren/util/GeolocatorUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:enerren/module/liveMaps/main.dart';
import 'package:enerren/util/StringExtention.dart';

class SieradView extends View with SieradPresenter, TickerProviderStateMixin {
  final UserType userType;
  final SieradViewModel sieradViewModel;
  final ValueChanged<TmsShipmentModel<SieradShipmentDetailHatcheryModel>>
      onTapDetailOrder;
  bool mapToDestination;

  SieradView({
    this.sieradViewModel,
    this.onTapDetailOrder,
    this.mapToDestination,
    this.userType,
  }) {
    super.viewModel = this.sieradViewModel;
  }

  @override
  void initState() {
    super.bottomSheetHeight = 430;
    super.bottomSheetContentPadding = EdgeInsets.only(top: 15);
    super.viewModel.pageController =
        new PageController(initialPage: 0, viewportFraction: 1.0);

    super.initState();
  }

  @override
  List<Widget> listComponent() {
    return <Widget>[
      map(),
      estimationTime(),
      bottomSheet(),
    ];
  }

  @override
  Widget floatingActionBotton() {
    return null;
  }

  @override
  Widget bottomSheetContent() {
    return ChangeNotifierProvider(
      create: (ctx) => super.viewModel,
      child: Consumer<SieradViewModel>(
        builder: (ctx, data, child) {
          return Stack(
            children: <Widget>[
              Center(
                child: PageView(
                  controller: data.pageController,
                  onPageChanged: (id) {
                    data.currentPage = id;
                    data.commit();
                  },
                  children: <Widget>[
                    contentPage1(),
                    contentPage2(),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 20,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              color: viewModel.currentPage == 0
                                  ? System.data.colorUtil.primaryColor
                                  : Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              color: viewModel.currentPage == 1
                                  ? System.data.colorUtil.primaryColor
                                  : Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget contentPage1() {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: InkWell(
                  child: Text(
                    "${System.data.resource.orderDetail}",
                    style: System.data.textStyleUtil.linkLabel(
                        color: System.data.colorUtil.primaryColor,
                        textDecoration: TextDecoration.underline),
                  ),
                  onTap: () {
                    if (onTapDetailOrder != null) {
                      onTapDetailOrder(viewModel.selectedShipment);
                    }
                  },
                ),
              ),
              ExternalLinkComponent.mapPhoneWA(
                phoneNumber: userType == UserType.Customer
                    ? viewModel.customerPhoneNumber
                    : viewModel.driverPhoneNumber,
                onTapMap: (lat, lng) {
                  showModalSelectTarget();
                },
              ),
            ],
          )),
          Center(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: System.data.colorUtil.primaryColor),
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage("${viewModel.driverImageUrl}"),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    height: 30,
                    width: 100,
                    child: BottonComponent.roundedButton(
                      text: "${viewModel.driverName}",
                      textstyle: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.lightTextColor,
                          fontSize: System.data.fontUtil.s),
                      colorBackground: System.data.colorUtil.primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "${viewModel.shipment.first.customerName}",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: System.data.colorUtil.blackColor,
          ),
          Container(
            child: viewModel.selectedShipment != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                "${System.data.resource.loadingGoods}",
                                style: System.data.textStyleUtil.mainLabel(
                                  color: System.data.colorUtil.primaryColor,
                                ),
                              ),
                            ),
                            FutureBuilder(
                              future: GeolocatorUtil.getAddress(
                                  viewModel.originLat, viewModel.originLon),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                return Container(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "${viewModel.originAddress.isNullOrEmpty() ? snapshot.data : viewModel.originAddress}",
                                    style: System.data.textStyleUtil.mainLabel(
                                      color: System.data.colorUtil.blackColor,
                                    ),
                                  ),
                                );
                              },
                              initialData: "${System.data.resource.loading}...",
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                "${System.data.resource.unloadingGoods}",
                                style: System.data.textStyleUtil.mainLabel(
                                  color: System.data.colorUtil.primaryColor,
                                ),
                              ),
                            ),
                            FutureBuilder(
                              future: GeolocatorUtil.getAddress(
                                  viewModel.destinationLat,
                                  viewModel.destinationLon),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                return Container(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "${viewModel.desinationAddress.isNullOrEmpty() ? snapshot.data : viewModel.desinationAddress}",
                                    style: System.data.textStyleUtil.mainLabel(
                                      color: System.data.colorUtil.blackColor,
                                    ),
                                  ),
                                );
                              },
                              initialData: "${System.data.resource.loading}...",
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                "${System.data.resource.shipmentType}",
                                style: System.data.textStyleUtil.mainLabel(
                                  color: System.data.colorUtil.primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                "${viewModel.shipmentType}",
                                style: System.data.textStyleUtil.mainLabel(
                                  color: System.data.colorUtil.blackColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                : Center(
                    child: Text("${System.data.resource.noShipmentProcessed}"),
                  ),
          ),
        ],
      ),
    );
  }

  Widget contentPage2() {
    return VehicleInfoDecoration.popupMapVehicleInfo(
      temperature: model.currentPoition.temp1,
      vehicleNumber: viewModel.vehicleNumber,
      vehicleType: viewModel.vehicleType,
      vehicleName:
          viewModel.vehicleName ?? super.model.currentPoition.vehicleName,
      vehicleImageUrl: viewModel.vehicleImageUrl,
      phoneNumber: userType == UserType.Customer
          ? viewModel.customerPhoneNumber
          : viewModel.driverPhoneNumber,
      backDoorSensor: viewModel.backdoor,
      fanSensor: viewModel.fan,
      showTempSensor: true,
      onTapGotoMap: (lat, lng) {
        showModalSelectTarget();
      },
      topLeftWidget: sieradViewModel.selectedShipment != null
          ? GestureDetector(
              onTap: () {
                if (onTapDetailOrder != null) {
                  onTapDetailOrder(viewModel.selectedShipment);
                }
              },
              child: Text(
                "${System.data.resource.orderDetail}",
                style: System.data.textStyleUtil
                    .linkLabel(textDecoration: TextDecoration.underline),
              ),
            )
          : Container(
              width: 0,
              height: 0,
            ),
    );
  }

  void showModalSelectTarget() {
    if (mapToDestination != null) {
      super.openMap(mapToDestination);
    } else {
      ModalComponent.bottomModalWithCorner(
        context,
        height: 150,
        child: Container(
          height: 120,
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MenuComponent.circleMenu(
                  size: 60,
                  textMenu: System.data.resource.vehicle,
                  textMenuStyle: System.data.textStyleUtil.mainLabel(
                    color: System.data.colorUtil.darkTextColor,
                  ),
                  shadow: <BoxShadow>[
                    BoxShadow(
                      color: System.data.colorUtil.shadowColor.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                  neonStyle: false,
                  backgroundColor: Colors.white,
                  textMenuSpace: 85,
                  menu: SvgPicture.asset(
                    "assets/sierad/icon_car.svg",
                    height: 25,
                  ),
                  onTap: () {
                    openMap(false);
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                MenuComponent.circleMenu(
                  size: 60,
                  textMenu: System.data.resource.destination,
                  textMenuStyle: System.data.textStyleUtil.mainLabel(
                    color: System.data.colorUtil.darkTextColor,
                  ),
                  shadow: <BoxShadow>[
                    BoxShadow(
                      color: System.data.colorUtil.shadowColor.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                  neonStyle: false,
                  backgroundColor: Colors.white,
                  textMenuSpace: 85,
                  menu: SvgPicture.asset("assets/sierad/icon_map.svg"),
                  onTap: () {
                    openMap(true);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
