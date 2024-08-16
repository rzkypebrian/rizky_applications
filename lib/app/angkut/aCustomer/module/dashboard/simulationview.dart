import 'package:component_icons/font_awesome.dart';
import 'package:enerren/app/angkut/aCustomer/module/dashboard/view.dart';
import 'package:enerren/app/angkut/model/VehicleCategory.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'viewModel.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';

class SimulationView extends View {
  @override
  Drawer drawer() {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => model,
      child: Stack(
        children: [
          Scaffold(
            drawer: drawer(),
            appBar: appBar(),
            body: Stack(
              children: <Widget>[
                Align(alignment: Alignment.topCenter, child: home(model)),
                DecorationComponent.circularLOadingIndicator(
                  margin: EdgeInsets.only(bottom: 55),
                  lightMode: false,
                  controller: model.controller,
                )
              ],
            ),
          ),
          popUpMap()
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(System.data.resource.priceSimulation,
          textAlign: TextAlign.center,
          style: System.data.textStyleUtil.mainTitle(
            color: System.data.colorUtil.lightTextColor,
          )),
    );
  }

  @override
  Widget wizardBar() {
    return Container(
      height: 0,
      width: 0,
    );
  }

  @override
  Widget buttonNext({String label, VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
      child: super.buttonNext(
          label: System.data.resource.priceCheck,
          onTap: () {
            if (model.controller.onLoading) return;
            model.controller.startLoading();
            if (model.googleMapControllers.getListPoint[0]
                        .any((e) => e.latLng == null) ==
                    false &&
                model.selectedVehicleTypes != null) {
              model.calculatePrice().then((value) {
                model.controller.stopLoading();
                return ModalComponent.bottomModalWithCorner(context,
                    corner: 0,
                    height: 220,
                    child: Container(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: detailItem(
                              fontWeight: FontWeight.bold,
                              label: System.data.resource.priceEstimation,
                              value: "",
                            ),
                          ),
                          Expanded(
                              child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: detailItem(
                                    label: System.data.resource.rate,
                                    value: NumberFormat("Rp #,###",
                                            System.data.resource.locale)
                                        .format(value.basicPrice),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: detailItem(
                                    label: System.data.resource.shipCost,
                                    value: NumberFormat("Rp #,###",
                                            System.data.resource.locale)
                                        .format(value.totalShipCost),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: detailItem(
                                    label: System.data.resource.discount,
                                    value: NumberFormat("Rp #,###",
                                            System.data.resource.locale)
                                        .format(value.discountAmount),
                                  ),
                                )
                              ],
                            ),
                          )),
                          Container(
                            height: 50,
                            color: System.data.colorUtil.primaryColor,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 5),
                                child: detailItem(
                                    fontWeight: FontWeight.bold,
                                    textColor:
                                        System.data.colorUtil.lightTextColor,
                                    label: "${System.data.resource.price} ",
                                    value: NumberFormat("Rp #,###",
                                            System.data.resource.locale)
                                        .format(value.totalPrice)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
              }).catchError((onError) {
                model.controller.stopLoading(
                  messageAlign: Alignment.topCenter,
                  messageWidget: DecorationComponent.topMessageDecoration(
                    message: ErrorHandlingUtil.handleApiError(onError),
                  ),
                );
              });
            } else {
              model.controller.stopLoading(
                messageAlign: Alignment.topCenter,
                messageWidget: DecorationComponent.topMessageDecoration(
                  message: System.data.resource
                      .pleaseDefineYourePickupAndDestinationLocation,
                ),
              );
            }
          }),
    );
  }

  @override
  Widget vehicleItem(
      VehicleCategory vehicle, BuildContext context, int itemIndex) {
    return vehicleCategoryItem(vehicle);
  }

  @override
  Widget home(ViewModel model) {
    return Stack(
      children: [
        Container(
          child: Column(
            children: listComponent(),
          ),
        ),
      ],
    );
  }

  Widget popUpMap() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Consumer<ViewModel>(
        builder: (c, d, h) {
          return SafeArea(
            child: AnimatedContainer(
              onEnd: () {
                model.finishShowRoute = true;
                model.commit();
              },
              margin: model.showRoute == false
                  ? EdgeInsets.only(top: MediaQuery.of(context).size.height)
                  : EdgeInsets.only(top: 0),
              height: MediaQuery.of(context).size.height,
              duration: Duration(milliseconds: 250),
              curve: Curves.easeIn,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(30),
                    // topRight: Radius.circular(30),
                    ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  heightFactor: 0.3,
                  widthFactor: 2.5,
                  child: Stack(
                    children: [
                      model.finishShowRoute
                          ? maps(model)
                          : Container(
                              color: Colors.lightBlue[200],
                            ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.all(9),
                          child: GestureDetector(
                            onTap: () {
                              model.finishShowRoute = false;
                              model.showRoute = false;
                              model.commit();
                            },
                            child: Icon(FontAwesomeLight(
                                FontAwesomeId.fa_times_circle)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  List<Widget> listComponent() {
    return <Widget>[
      Container(
        width: double.infinity,
        height: 30,
        padding: EdgeInsets.only(left: 15),
        color: Colors.white,
        alignment: Alignment.centerLeft,
        child: Text(
          System.data.resource.vehicleSize,
          style: System.data.textStyleUtil.mainLabel(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        )),
        child: top(model: model, height: null),
      ),
      Expanded(
        child: Stack(
          children: [
            Container(
              height: 100,
              width: 100,
              child: maps(model),
            ),
            Container(
              color: System.data.colorUtil.secondaryColor,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 30,
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.only(left: 15),
                    color: Colors.white,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      System.data.resource.vehicleType,
                      style: System.data.textStyleUtil.mainLabel(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 110,
                    width: double.infinity,
                    child: Consumer<ViewModel>(
                      builder: (c, d, h) {
                        try {
                          return PageView(
                            controller: model.typePageController,
                            onPageChanged: (index) {
                              model.selectedVehicleTypes =
                                  model.selectedVehicleTypeList[index];
                              model.commit();
                            },
                            children: List.generate(
                                model.selectedVehicleTypeList?.length, (index) {
                              return Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: SvgPicture.asset(
                                              "assets/angkut/car_shadow.svg",
                                              color: model.selectedVehicleTypes
                                                              ?.vehicleTypeId ==
                                                          model
                                                              .selectedVehicleTypeList[
                                                                  index]
                                                              ?.vehicleTypeId ||
                                                      model.selectedVehicleTypes ==
                                                          null
                                                  ? null
                                                  : Colors.white
                                                      .withOpacity(0.5),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5),
                                              child: SvgPicture.network(
                                                model
                                                        .selectedVehicleTypeList[
                                                            index]
                                                        ?.iconUrl ??
                                                    "",
                                                fit: BoxFit.fitHeight,
                                                colorBlendMode:
                                                    BlendMode.lighten,
                                                color: model.selectedVehicleTypes
                                                                ?.vehicleTypeId ==
                                                            model
                                                                .selectedVehicleTypeList[
                                                                    index]
                                                                ?.vehicleTypeId ||
                                                        model.selectedVehicleTypes ==
                                                            null
                                                    ? null
                                                    : Colors.white
                                                        .withOpacity(0.5),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        model.selectedVehicleTypeList[index]
                                                ?.vehicleTypeName ??
                                            "${System.data.resource.pleaseSelectVehicleType}",
                                        style:
                                            System.data.textStyleUtil.mainLabel(
                                          color: System
                                              .data.colorUtil.primaryColor,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                          );
                        } catch (e) {
                          return Container(
                            height: 0,
                            width: 0,
                          );
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 25,
                              alignment: Alignment.center,
                              child: Text(
                                "${System.data.resource.vehicleDetail}",
                                style: System.data.textStyleUtil.mainLabel(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Divider(
                              endIndent: 15,
                              color: Colors.black,
                            ),
                            Expanded(
                                child: Container(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: SingleChildScrollView(
                                child: Consumer<ViewModel>(
                                  builder: (c, d, h) {
                                    if (model.selectedVehicleTypes == null) {
                                      try {
                                        print("masuh sini");
                                        model.selectedVehicleTypes =
                                            model.selectedVehicleTypeList[0];
                                        model.typePageController.jumpToPage(0);
                                      } catch (e) {}
                                    }
                                    return Column(
                                      children: [
                                        detailItem(
                                          label:
                                              "${System.data.resource.length}: ${model.selectedVehicleTypes?.length ?? "-"}",
                                          value:
                                              "${System.data.resource.volume}: ${model.selectedVehicleTypes?.volume ?? "-"}",
                                        ),
                                        detailItem(
                                          label:
                                              "${System.data.resource.width}: ${model.selectedVehicleTypes?.width ?? "-"}",
                                          value:
                                              "${System.data.resource.weight}: ${model.selectedVehicleTypes?.weight ?? "-"}",
                                        ),
                                        detailItem(
                                          label:
                                              "${System.data.resource.height}: ${model.selectedVehicleTypes?.height ?? "-"}",
                                          value: "",
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      buttom(),
      // gotoCurrentLocation(),
    ];
  }

  @override
  List<Widget> bottomListComponent() {
    return <Widget>[
      Container(
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              System.data.resource.location,
              style: System.data.textStyleUtil.mainLabel(
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                model.finishShowRoute = false;
                model.showRoute = true;
                model.commit();
              },
              child: Text(
                System.data.resource.seeRoute,
                style: System.data.textStyleUtil.linkLabel(
                  fontWeight: FontWeight.bold,
                  textDecoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
      listDestination(),
      bottomInfo(),
    ];
  }

  @override
  Widget selectedSubTypeVehicle({VoidCallback onTap}) {
    return Container(
      height: 0,
      width: 0,
    );
  }

  Widget detailItem({
    String label,
    String value,
    Color textColor,
    FontWeight fontWeight,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "$label",
                style: System.data.textStyleUtil.mainLabel(
                    color: textColor ?? System.data.colorUtil.darkTextColor,
                    fontWeight: fontWeight),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                "$value",
                style: System.data.textStyleUtil.mainLabel(
                  color: textColor ?? System.data.colorUtil.darkTextColor,
                  fontWeight: fontWeight,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget buttom({EdgeInsetsGeometry padding, double height}) {
    return super.buttom(padding: EdgeInsets.all(0), height: null);
  }

  @override
  void startMaps() {
    return;
  }
}
