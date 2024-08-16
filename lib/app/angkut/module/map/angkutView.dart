import 'package:component_icons/font_awesome.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/driverInfoDecoration.dart';
import 'package:enerren/component/menuComponent.dart';
import 'package:enerren/component/vehicleInfoDecoration.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:enerren/module/maps/view.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'angkutPresenter.dart';
import 'angkutViewModel.dart';

class AngkutView extends View with AngkutPresenter {
  final ValueChanged<AngkutShipmentModel> onTapDetailOrder;
  final ValueChanged3Param<TmsVehicleModel, DateTime, DateTime>
      onTapSearchHistoery;

  AngkutView({
    this.onTapDetailOrder,
    this.onTapSearchHistoery,
  }) {
    super.onMarkerSelected = () {
      ModalComponent.bottomModalWithCorner(
        context,
        height: 426,
        child: Container(
          height: 400,
          child: openModalInfo(),
        ),
      );
    };
  }

  @override
  Widget bottomNavigationBar() {
    return ChangeNotifierProvider<AngkutViewModel>(
      create: (cts) => super.angkutViewModel,
      child: Consumer<AngkutViewModel>(
        builder: (ctx, data, child) {
          return Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: System.data.colorUtil.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MenuComponent.circleMenu(
                      textMenu: System.data.resource.vehicle,
                      textMenuStyle: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.lightTextColor,
                      ),
                      neonStyle: false,
                      size: 45,
                      borderColor: Colors.transparent,
                      textMenuSpace: 40,
                      menu: SvgPicture.asset("assets/angkut/icon_car.svg"),
                      onTap: openAllVehicleModal),
                  MenuComponent.circleMenu(
                    textMenu: System.data.resource.information,
                    textMenuStyle: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.lightTextColor,
                    ),
                    onTap: () {
                      if (data.selectedVehicle == null) {
                        super.mapLoadingController.stopLoading(
                            messageAlign: Alignment.topCenter,
                            messageWidget:
                                DecorationComponent.topMessageDecoration(
                              message: System.data.resource.notVehicleSelected,
                            ));
                      } else {
                        ModalComponent.bottomModalWithCorner(
                          context,
                          height: 426,
                          child: Container(
                            height: 400,
                            child: openModalInfo(),
                          ),
                        );
                      }
                    },
                    neonStyle: false,
                    size: 45,
                    textMenuSpace: 40,
                    borderColor: Colors.transparent,
                    menu: SvgPicture.asset("assets/angkut/icon_info.svg"),
                  ),
                  MenuComponent.circleMenu(
                    textMenu: System.data.resource.history,
                    textMenuStyle: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.lightTextColor,
                    ),
                    neonStyle: false,
                    size: 45,
                    textMenuSpace: 40,
                    borderColor: Colors.transparent,
                    iconMargin: EdgeInsets.only(right: 3),
                    menu: SvgPicture.asset("assets/angkut/icon_riwayat.svg"),
                    onTap: () {
                      if (data.selectedVehicle == null) {
                        super.mapLoadingController.stopLoading(
                            messageAlign: Alignment.topCenter,
                            messageWidget:
                                DecorationComponent.topMessageDecoration(
                              message: System.data.resource.notVehicleSelected,
                            ));
                      } else {
                        ModalComponent.bottomModalWithCorner(
                          context,
                          height: 356,
                          child: Container(
                            height: 330,
                            child: openModalHistory(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void openAllVehicleModal() {
    ModalComponent.bottomModalWithCorner(
      context,
      height: 316,
      child: Container(
        height: 300,
        width: double.infinity,
        child: ListView(
          children: List.generate(angkutViewModel.vehicles.length, (i) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                ModalComponent.bottomModalWithCorner(
                  context,
                  height: 426,
                  child: Container(
                    height: 400,
                    child: openModalInfo(),
                  ),
                );
                moveToSelected(angkutViewModel.vehicles[i].vtsVehicleId);
              },
              child: Container(
                margin: EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                  left: 10,
                  right: 10,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    border: Border.all(
                      color: super.model.selected != null
                          ? angkutViewModel.vehicles[i].vtsVehicleId ==
                                  super.model.selected.vehicleId
                              ? System.data.colorUtil.primaryColor
                              : Colors.transparent
                          : Colors.transparent,
                    )),
                height: 50,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 30,
                              margin: EdgeInsets.only(right: 5),
                              alignment: Alignment.centerLeft,
                              child: SvgPicture.network(angkutViewModel
                                      .vehicles[i].vehicleTypeIconUrl ??
                                  "https://sendeyo.com/up/d/5f93ef24be"),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${angkutViewModel.vehicles[i].vehicleNumber}",
                                  style: System.data.textStyleUtil.mainLabel(
                                    fontSize: System.data.fontUtil.s,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: angkutViewModel.vehicles[i].vehicleStatusId == 0
                            ? Colors.red
                            : angkutViewModel.vehicles[i].vehicleStatusId == 1
                                ? Colors.green
                                : Colors.yellow,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "${angkutViewModel.vehicles[i].driverName}",
                                  textAlign: TextAlign.right,
                                  style: System.data.textStyleUtil.mainLabel(
                                    fontSize: System.data.fontUtil.s,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              width: 30,
                              height: 30,
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: System.data.colorUtil.primaryColor,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      // "${sieradViewModel.vehicles[i].driverImageUrl}",
                                      "https://awsimages.detik.net.id/community/media/visual/2018/06/05/bb04507a-16cb-472d-8b5a-cbf5bfff4b6c.jpeg?a=1"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget openModalInfo() {
    return ValueListenableBuilder(
      valueListenable: super.angkutViewModelController,
      builder: (BuildContext context, AngkutViewModel value, Widget child) {
        return Stack(
          children: <Widget>[
            Center(
              child: PageView(
                controller: value.pageController,
                onPageChanged: (id) {
                  angkutViewModelController.setState(() {
                    angkutViewModelController.value.currentPage = id;
                  });
                },
                children: <Widget>[
                  contentPage1(value),
                  contentPage2(value, super.model.selected),
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
                            color: value.currentPage == 0
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
                            color: value.currentPage == 1
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
    );
  }

  Widget openModalHistory() {
    return ValueListenableBuilder<AngkutViewModel>(
      valueListenable: super.angkutViewModelController,
      builder: (ctx, dt, child) {
        return Container(
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        child: SvgPicture.asset(
                            "assets/angkut/backgroud_angkut_vehicle.svg"),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: SvgPicture.network(
                          "${angkutViewModel.selectedVehicle.vehicleTypeIconUrl}",
                          height: 60,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: (60 + 15).toDouble()),
                        child: Text(
                          "${angkutViewModel.selectedVehicle.vehicleTypeName}",
                          style: System.data.textStyleUtil.linkLabel(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: (60 + 15 + 20).toDouble()),
                        child: Text(
                          "${angkutViewModel.selectedVehicle.vehicleNumber}",
                          style: System.data.textStyleUtil.mainLabel(
                            fontSize: System.data.fontUtil.xl,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          InputComponent.inputTextWithCorner(
                            controller: dt.fromDateController,
                            hintText: System.data.resource.fromDate,
                            corner: 5,
                            stateInput: dt.fromDateController.stateInput,
                            autoFocus: false,
                            borderInputGray: dt.toDateController.stateInput ==
                                    StateInput.Error
                                ? Colors.red
                                : Colors.grey.shade300,
                            suffixIcon: Icon(
                                FontAwesomeLight(FontAwesomeId.fa_calendar)),
                          ),
                          GestureDetector(
                            onTap: () => angkutViewModelController
                                .selectFromDate(context),
                            child: Container(
                              height: 50,
                              color: Colors.red.withOpacity(0),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Stack(
                        children: <Widget>[
                          InputComponent.inputTextWithCorner(
                            controller: dt.toDateController,
                            hintText: System.data.resource.toDate,
                            corner: 5,
                            stateInput: dt.toDateController.stateInput,
                            borderInputGray: dt.toDateController.stateInput ==
                                    StateInput.Error
                                ? Colors.red
                                : Colors.grey.shade300,
                            autoFocus: false,
                            suffixIcon: Icon(
                                FontAwesomeLight(FontAwesomeId.fa_calendar)),
                          ),
                          GestureDetector(
                            onTap: () =>
                                angkutViewModelController.selectToDate(context),
                            child: Container(
                              height: 50,
                              color: Colors.red.withOpacity(0),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 45,
                      child: BottonComponent.roundedButton(
                        text: System.data.resource.loadHistory,
                        onPressed: () {
                          if (!angkutViewModelController
                              .validateSearchHistory()) return;
                          Navigator.of(context).pop();
                          if (dt.selectedFromDate.isAfter(dt.selectedToDate)) {
                            mapLoadingController.stopLoading(
                                messageAlign: Alignment.topCenter,
                                messageWidget:
                                    DecorationComponent.topMessageDecoration(
                                  message: System.data.resource
                                      .startDateNotAllowedBeGreaterThanEndDate,
                                ));
                          } else {
                            onTapSearchHistoery(dt.selectedVehicle,
                                dt.selectedFromDate, dt.selectedToDate);
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget contentPage1(AngkutViewModel data) {
    return DriverInfoDecoration.popupMapDriverInfo(
      address: data.selectedVehicle.driverAddress,
      birdDate: data.selectedVehicle.driverBirthDate,
      driverImageUrl: data.selectedVehicle.driverImageUrl,
      driverName: data.selectedVehicle.driverName,
      email: data.selectedVehicle.driverEmail,
      nik: data.selectedVehicle.driverNik,
      phoneNumber: data.selectedVehicle.driverPhoneNumber,
      topRightWidget: data.selectedVehicle.shipmentHeaderData.isNotEmpty
          ? GestureDetector(
              onTap: () {
                if (onTapDetailOrder != null) {
                  onTapDetailOrder(
                      data.selectedVehicle.shipmentHeaderData.first);
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

  Widget contentPage2(AngkutViewModel data, VtsPositionModel positionData) {
    return VehicleInfoDecoration.popupMapVehicleInfo(
      vtsPositionModel: positionData,
      temperature: positionData.temp1,
      vehicleImageUrl: data.selectedVehicle.vehicleTypeIconUrl ??
          "https://sendeyo.com/up/d/5f93ef24be",
      vehicleName: data.selectedVehicle.vehicleName,
      vehicleNumber: data.selectedVehicle.vehicleNumber,
      vehicleType: data.selectedVehicle.vehicleTypeName,
      phoneNumber: data.selectedVehicle.driverPhoneNumber,
      showTempSensor: false,
      showBackdoorSensor: false,
      showFanSensor: false,
      autoGenerateSensor: true,
      onTapGotoMap: (lat, lng) {
        openMap();
      },
      topLeftWidget: data.selectedVehicle.shipmentHeaderData.isNotEmpty
          ? GestureDetector(
              onTap: () {
                if (onTapDetailOrder != null) {
                  onTapDetailOrder(
                      data.selectedVehicle.shipmentHeaderData.first);
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
      showMapLink: false,
    );
  }
}
