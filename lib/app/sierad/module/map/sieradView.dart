import 'package:enerren/app/sierad/model/SieradShipmentDetailHatcheryModel.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/driverInfoDecoration.dart';
import 'package:enerren/component/menuComponent.dart';
import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/component/vehicleInfoDecoration.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/module/maps/view.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'sieradPresenter.dart';
import 'sieradViewModel.dart';

class SieradView extends View with SieradPresenter {
  final ValueChanged<List<TmsShipmentModel<SieradShipmentDetailHatcheryModel>>>
      onTapDetailOrder;
  final ValueChanged3Param<int, DateTime, DateTime> onTapSearchHistoery;

  SieradView({
    this.onTapDetailOrder,
    this.onTapSearchHistoery,
  });

  @override
  Widget bottomNavigationBar() {
    return ChangeNotifierProvider<SieradViewModel>(
      create: (cts) => super.sieradViewModel,
      child: Consumer<SieradViewModel>(
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
                      size: 40,
                      backgroundColor: Colors.white,
                      textMenuSpace: 40,
                      menu: SvgPicture.asset("assets/sierad/icon_car.svg"),
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
                    size: 40,
                    backgroundColor: Colors.white,
                    textMenuSpace: 40,
                    menu: SvgPicture.asset("assets/sierad/icon_info.svg"),
                  ),
                  MenuComponent.circleMenu(
                    textMenu: System.data.resource.history,
                    textMenuStyle: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.lightTextColor,
                    ),
                    neonStyle: false,
                    size: 40,
                    backgroundColor: Colors.white,
                    textMenuSpace: 40,
                    iconMargin: EdgeInsets.only(right: 3),
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
                          height: 226,
                          child: Container(
                            height: 200,
                            child: openModalHistory(),
                          ),
                        );
                      }
                    },
                    menu: SvgPicture.asset(
                      "assets/sierad/icon_riwayat.svg",
                    ),
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
        child: ValueListenableBuilder<SieradViewModel>(
          valueListenable: super.sieradViewModelController,
          builder: (BuildContext context, SieradViewModel value, Widget child) {
            return Center(
              child: Container(
                height: 300,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      child: InputComponent.inputTextWithCorner(
                        controller: value.searchController,
                        stateInput: StateInput.Enable,
                        corner: 15,
                        onChanged: (val) {
                          sieradViewModelController.filter();
                          value.commit();
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView(
                          children:
                              List.generate(value.filteredVehicle.length, (i) {
                            return Container(
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
                                        ? value.filteredVehicle[i]
                                                    .vtsVehicleId ==
                                                super.model.selected.vehicleId
                                            ? System.data.colorUtil.primaryColor
                                            : Colors.transparent
                                        : Colors.transparent,
                                  )),
                              height: 50,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        moveToSelected(value
                                            .filteredVehicle[i].vtsVehicleId);
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: 30,
                                              margin: EdgeInsets.only(right: 5),
                                              alignment: Alignment.centerLeft,
                                              child: SvgPicture.network(value
                                                  .vehicles[i]
                                                  .vehicleTypeIconUrl),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "${value.filteredVehicle[i].vehicleNumber}",
                                                  style: System
                                                      .data.textStyleUtil
                                                      .mainLabel(
                                                    fontSize:
                                                        System.data.fontUtil.s,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: value.filteredVehicle[i]
                                                  .vehicleStatusId ==
                                              0
                                          ? Colors.red
                                          : value.filteredVehicle[i]
                                                      .vehicleStatusId ==
                                                  1
                                              ? Colors.green
                                              : Colors.yellow,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "${value.filteredVehicle[i].driverName}",
                                                style: System.data.textStyleUtil
                                                    .mainLabel(
                                                  fontSize:
                                                      System.data.fontUtil.s,
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
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50)),
                                                color: System.data.colorUtil
                                                    .primaryColor,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "${value.filteredVehicle[i].driverImageUrl}"))),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget openModalInfo() {
    return ValueListenableBuilder(
      valueListenable: super.sieradViewModelController,
      builder: (BuildContext context, SieradViewModel value, Widget child) {
        return Stack(
          children: <Widget>[
            Center(
              child: PageView(
                controller: value.pageController,
                onPageChanged: (id) {
                  sieradViewModelController.setState(
                    () {
                      sieradViewModelController.value.currentPage = id;
                    },
                  );
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

  Widget contentPage1(SieradViewModel data) {
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
                  onTapDetailOrder(data.selectedVehicle.shipmentHeaderData);
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

  Widget contentPage2(SieradViewModel data, VtsPositionModel positionData) {
    return VehicleInfoDecoration.popupMapVehicleInfo(
      temperature: positionData.temp1,
      vehicleImageUrl: data.selectedVehicle.vehicleTypeIconUrl,
      vehicleName: data.selectedVehicle.vehicleName,
      vehicleNumber: data.selectedVehicle.vehicleNumber,
      vehicleType: data.selectedVehicle.vehicleTypeName,
      phoneNumber: data.selectedVehicle.driverPhoneNumber,
      backDoorSensor: VtsPositionModel.readSensor(
          data.selectedVehicle.vehicleBackDoorSensor, positionData) as bool,
      fanSensor: VtsPositionModel.readSensor(
          data.selectedVehicle.vehicleFanSensor, positionData) as bool,
      onTapGotoMap: (lat, lng) {
        openMap();
      },
      topLeftWidget: data.selectedVehicle.shipmentHeaderData.isNotEmpty
          ? GestureDetector(
              onTap: () {
                if (onTapDetailOrder != null) {
                  onTapDetailOrder(data.selectedVehicle.shipmentHeaderData);
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

  Widget openModalHistory() {
    return ValueListenableBuilder<SieradViewModel>(
      valueListenable: super.sieradViewModelController,
      builder: (ctx, dt, child) {
        print("fire me");
        return Container(
          height: 100,
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
          ),
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
                      borderInputGray:
                          dt.toDateController.stateInput == StateInput.Error
                              ? Colors.red
                              : Colors.grey.shade300,
                    ),
                    GestureDetector(
                      onTap: () =>
                          sieradViewModelController.selectFromDate(context),
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
                      borderInputGray:
                          dt.toDateController.stateInput == StateInput.Error
                              ? Colors.red
                              : Colors.grey.shade300,
                      autoFocus: false,
                    ),
                    GestureDetector(
                      onTap: () =>
                          sieradViewModelController.selectToDate(context),
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
                width: 200,
                height: 45,
                child: BottonComponent.roundedButton(
                  text: System.data.resource.search,
                  onPressed: () {
                    if (!sieradViewModelController.validateSearchHistory())
                      return;
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
                      onTapSearchHistoery(dt.selectedVehicle.vtsVehicleId,
                          dt.selectedFromDate, dt.selectedToDate);
                    }
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
