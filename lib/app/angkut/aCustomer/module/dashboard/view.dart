import 'package:enerren/app/angkut/aCustomer/LocalData.dart';
import 'package:enerren/app/angkut/model/VehicleCategory.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/customeGoogleMap/googleMaps.dart';
import 'package:enerren/model/menuModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'presenter.dart';
import 'package:component_icons/font_awesome.dart';
import 'viewModel.dart';
import 'package:enerren/component/ModalComponent.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => model,
      child: Scaffold(
        drawer: drawer(),
        appBar: appBar(),
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: home(model),
            ),
            DecorationComponent.circularLOadingIndicator(
              margin: EdgeInsets.only(bottom: 55),
              lightMode: false,
              controller: model.controller,
            )
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: System.data.colorUtil.primaryColor,
      title: Text(
        System.data.resource.home,
        textAlign: TextAlign.center,
        style: System.data.textStyleUtil.mainTitle(
          color: System.data.colorUtil.lightTextColor,
        ),
      ),
    );
  }

  Drawer drawer() {
    return Drawer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              widget.backgroundColor1 ?? Color(0xff00549E),
              widget.backgroundColor2 ?? Color(0xff008AF6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 150,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Colors.white,
                  style: BorderStyle.solid,
                  width: 2,
                ))),
                child: Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            widget.onTapProfile();
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                "${System.data.getLocal<LocalData>().user?.imageUrl}",
                                fit: BoxFit.fitHeight,
                                errorBuilder: (bb, o, st) => Container(
                                  child: Image.asset(
                                      "assets/angkut/avatar_no_regis.png"),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${System.data.getLocal<LocalData>().user?.customerName ?? System.data.resource.username}",
                          style: System.data.textStyleUtil.mainTitle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, top: 15),
                child: Column(
                  children: List.generate(menuItem().length, (i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5, top: 5),
                      child: GestureDetector(
                        onTap: menuItem()[i].onTap,
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: menuItem()[i].iconWidget,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: Text(
                                menuItem()[i].textMenu,
                                style: System.data.textStyleUtil.mainTitle(
                                  fontSize: System.data.fontUtil.m,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<MenuModel> menuItem() {
    return [
      MenuModel(
        textMenu: System.data.resource.tackOrder,
        iconWidget: SvgPicture.asset("assets/angkut/track_order.svg",
            color: Colors.white),
        onTap: widget.onTapTrack,
      ),
      MenuModel(
          textMenu: System.data.resource.orderHistory,
          iconWidget: SvgPicture.asset("assets/angkut/History_order.svg",
              color: Colors.white),
          onTap: widget.onTapHistory),
      MenuModel(
        textMenu: System.data.resource.priceSimulation,
        iconWidget: SvgPicture.asset(
          "assets/angkut/route.svg",
          color: Colors.white,
        ),
        onTap: widget.onTapPriceSimulation,
      ),
      MenuModel(
          textMenu: System.data.resource.notification,
          iconWidget: Icon(
            FontAwesomeLight(FontAwesomeId.fa_bell),
            color: Colors.white,
            size: 23,
          ),
          onTap: widget.onTapNotification),
      MenuModel(
          textMenu: System.data.resource.help,
          iconWidget: SvgPicture.asset(
            "assets/angkut/help.svg",
            color: Colors.white,
          ),
          onTap: widget.onTapHelp),
      MenuModel(
          textMenu: System.data.resource.setting,
          iconWidget: SvgPicture.asset("assets/angkut/settings.svg",
              color: Colors.white),
          onTap: widget.onTapSetting),
    ];
  }

  Widget home(ViewModel model) {
    return Container(
      child: Stack(
        children: listComponent(),
      ),
    );
  }

  List<Widget> listComponent() {
    return <Widget>[
      maps(model),
      top(
        model: model,
        height: 280,
      ),
      buttom(
        height: heightLocation + 180,
      ),
      gotoCurrentLocation(),
    ];
  }

  Widget gotoCurrentLocation() {
    return Align(
      alignment: Alignment(-1, -0.64),
      child: Container(
        child: IconButton(
          onPressed: gotoCurrentLocations,
          iconSize: 30,
          icon: Icon(
            FontAwesomeLight(FontAwesomeId.fa_location),
            color: System.data.colorUtil.darkTextColor,
          ),
        ),
      ),
    );
  }

  Widget top({ViewModel model, double height}) {
    return Consumer<ViewModel>(
      builder: (c, d, h) {
        return AnimatedContainer(
          duration: duration,
          alignment: model.alignmentTop,
          curve: curve,
          child: Container(
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      wizardBar(),
                      vehicleSelectorPageViewMode(model.vehicleCategory),
                    ],
                  ),
                ),
                selectedVehicless(model: model),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget selectedVehicless({ViewModel model}) {
    return Container(
      child: model.showVehicles
          ? Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 0, left: 40, right: 40),
                child: ListView.builder(
                  itemCount: model.selectedVehicleTypeList.length,
                  itemBuilder: (ctx, i) {
                    return GestureDetector(
                      onTap: () {
                        model.selectedVehicleTypes =
                            model.selectedVehicleTypeList[i];
                        notifSelectedVehicleTyoe(model.selectedVehicleTypes);
                        showVehicles();
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            color: model.selectedVehicleTypes ==
                                    model.selectedVehicleTypeList[i]
                                ? System.data.colorUtil.primaryColor
                                : System.data.colorUtil.secondaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                child: SvgPicture.network(
                                  model.selectedVehicleTypeList[i].iconUrl,
                                  width: 50,
                                  fit: BoxFit.cover,
                                )),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${toBeginningOfSentenceCase(model.selectedVehicleTypeList[i].vehicleTypeName)}",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            IconButton(
                              iconSize: 15,
                              icon: Icon(
                                FontAwesomeLight(FontAwesomeId.fa_eye),
                                color: System.data.colorUtil.darkTextColor,
                              ),
                              onPressed: () => showDetailVehicle(
                                  model.selectedVehicleTypeList[i]),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          : selectedSubTypeVehicle(
              onTap: () => showVehicles(show: true),
            ),
    );
  }

  Widget selectedSubTypeVehicle({VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        child: FlareActor(
          "assets/flares/angkut/arrow.flr",
          animation: "play",
        ),
      ),
    );
  }

  Widget maps(ViewModel model) {
    return Align(
      alignment: Alignment.topCenter,
      child: GoogleMaps(
        googleMapController: model.googleMapControllers,
        onCameraMoveStarted: startMaps,
        onCameraIdle: stopMaps,
      ),
    );
  }

  Widget buttom({
    EdgeInsetsGeometry padding,
    double height,
  }) {
    return Consumer<ViewModel>(
      builder: (c, d, h) {
        return AnimatedContainer(
          duration: duration,
          alignment: model.alignmentBottom,
          curve: curve,
          child: Container(
            height: height,
            padding: padding ??
                EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: System.data.colorUtil.secondaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: bottomListComponent(),
                  ),
                ),
                buttonNext()
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> bottomListComponent() {
    return <Widget>[
      listDestination(),
      buttonAddDestination(),
      bottomInfo(),
    ];
  }

  Widget listDestination() {
    return Container(
      height: model.heightInput,
      child: addPoints(),
    );
  }

  Widget buttonAddDestination() {
    return GestureDetector(
      onTap: addNewLocation,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 45, bottom: 10, top: 0),
              child: Icon(
                FontAwesomeSolid(FontAwesomeId.fa_plus_circle),
                color: System.data.colorUtil.primaryColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5, top: 3),
              child: Text(
                "${toBeginningOfSentenceCase(System.data.resource.addDestination)}",
                style: TextStyle(
                  color: System.data.colorUtil.primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomInfo() {
    return Container(
      height: 0,
      width: 0,
    );
  }

  Widget buttonNext({String label, VoidCallback onTap}) {
    return GestureDetector(
      onTap: () {
        if (model.controller.onLoading == false) {
          onTap != null ? onTap() : nextJalan();
        }
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: System.data.colorUtil.primaryColor,
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            "${label ?? toBeginningOfSentenceCase(System.data.resource.next)}",
            style: System.data.textStyleUtil.mainTitle(
              color: System.data.colorUtil.secondaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget wizardBar() {
    return DecorationComponent.wizardBar();
  }

  Widget vehicleSelectorPageViewMode(List<VehicleCategory> vehicles) {
    return Container(
      height: 65,
      color: System.data.colorUtil.secondaryColor,
      child: model.finishTypeVehicle
          ? PageView.builder(
              controller: model.typeController,
              itemCount: vehicles.length,
              onPageChanged: ((selected) {
                model.selectedVehicleCategory = vehicles[selected];
                model.selectedVehicleTypeList =
                    vehicles[selected].vehicleTypeList;
                model.selectedVehicleTypes = null;
                model.alignmentTop1 = Alignment(0, -0.75);
                showVehicles();
              }),
              itemBuilder: (BuildContext context, int itemIndex) {
                return vehicleItem(vehicles[itemIndex], context, itemIndex);
              },
            )
          : Container(),
    );
  }

  Widget vehicleItem(
      VehicleCategory vehicle, BuildContext context, int itemIndex) {
    if (model.selectedVehicleTypes != null &&
        model.selectedVehicleCategory == vehicle) {
      return vehicleTypeSelectedItem();
    } else {
      return vehicleCategoryItem(vehicle);
    }
  }

  Widget vehicleTypeSelectedItem() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 5, left: 5, right: 5),
              child: SvgPicture.network(
                model.selectedVehicleTypes.iconUrl,
                height: 40,
                fit: BoxFit.cover,
              )),
          SizedBox(
            height: 5,
          ),
          Text(
            "${toBeginningOfSentenceCase(model.selectedVehicleTypes.vehicleTypeName)}",
            style: System.data.textStyleUtil.mainLabel(
                fontSize: System.data.fontUtil.xsPlus,
                color: System.data.colorUtil.primaryColor),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget vehicleCategoryItem(VehicleCategory vehicle) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 5, left: 5, right: 5),
              child: SvgPicture.network(
                vehicle.urlIcon,
                height: 40,
                fit: BoxFit.contain,
              )),
          SizedBox(
            height: 5,
          ),
          Text(
            "${toBeginningOfSentenceCase(vehicle.vehicleSizeName)}",
            style: System.data.textStyleUtil.mainLabel(
              fontSize: System.data.fontUtil.xsPlus,
              color: model.selectedVehicleCategory == vehicle
                  ? System.data.colorUtil.primaryColor
                  : System.data.colorUtil.disableColor,
            ),
          )
        ],
      ),
    );
  }

  Widget radiusContainer(int i) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
          child: Text(
        "$i",
        style: TextStyle(
            color: System.data.colorUtil.secondaryColor,
            fontWeight: FontWeight.bold),
      )),
    );
  }

  Widget addPoints() {
    return ListView(
      controller: scrollController,
      children:
          List.generate(model.googleMapControllers.totalPoint(id: 0), (a) {
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 55,
                width: 30,
                margin: EdgeInsets.only(right: 10),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: model.googleMapControllers.totalPoint(id: 0) > 2
                            ? a == 0
                                ? SvgPicture.asset(
                                    "${widget.pickUpAssetsIcon}",
                                    width: widget.pickUpWidthIcon,
                                  )
                                : radiusContainer(a)
                            : SvgPicture.asset(
                                a == 0
                                    ? "${widget.pickUpAssetsIcon}"
                                    : "assets/angkut/pin_lokasi.svg",
                                width: a == 0 ? widget.pickUpWidthIcon : null,
                              ),
                      ),
                    ),
                    (a == 0)
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              child: SvgPicture.asset(
                                "assets/angkut/arrow_destination.svg",
                                height: 20,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onTapTexteditor(i: a);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: System.data.colorUtil.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(3),
                                child: Text(
                                  "${toBeginningOfSentenceCase(model.googleMapControllers.getListPoint[0][a].address ?? "")}",
                                  style: System.data.textStyleUtil.titleTable(
                                      color:
                                          System.data.colorUtil.darkTextColor),
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ),
                          (a > 1)
                              ? Center(
                                  child: IconButton(
                                    onPressed: () => removePoint(a),
                                    icon: Icon(
                                      FontAwesomeSolid(
                                          FontAwesomeId.fa_minus_circle),
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      )),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  showDetailVehicle(VehicleType vehicleType) {
    ModalComponent.bottomModalWithCorner(context,
        height: 300,
        child: Container(
          height: 284,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Container(
                            width: 100,
                            height: 90,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: SvgPicture.network(
                                    vehicleType.iconUrl,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    "${toBeginningOfSentenceCase(vehicleType.vehicleTypeName)}",
                                    style: System.data.textStyleUtil.titleTable(
                                        color: System
                                            .data.colorUtil.darkTextColor),
                                  ),
                                )
                              ],
                            )),
                      ),
                      Divider(),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${toBeginningOfSentenceCase(System.data.resource.length)} : ${vehicleType.length ?? ""}",
                              style: System.data.textStyleUtil.titleTable(
                                  color: System.data.colorUtil.darkTextColor),
                            ),
                            Text(
                              "${toBeginningOfSentenceCase(System.data.resource.volume)} : ${vehicleType.volume ?? ""}",
                              style: System.data.textStyleUtil.titleTable(
                                  color: System.data.colorUtil.darkTextColor),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "${toBeginningOfSentenceCase(System.data.resource.width)} : ${vehicleType.width ?? ""}",
                              style: System.data.textStyleUtil.titleTable(
                                  color: System.data.colorUtil.darkTextColor),
                            ),
                            Text(
                              "${toBeginningOfSentenceCase(System.data.resource.weight)} : ${vehicleType.weight ?? ""}",
                              style: System.data.textStyleUtil.titleTable(
                                  color: System.data.colorUtil.darkTextColor),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "${toBeginningOfSentenceCase(System.data.resource.height)} : ${vehicleType.height ?? ""}",
                              style: System.data.textStyleUtil.titleTable(
                                  color: System.data.colorUtil.darkTextColor),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 47,
                    color: System.data.colorUtil.primaryColor,
                    child: Center(
                        child: Text(
                      "${toBeginningOfSentenceCase(System.data.resource.ok)}",
                      style: System.data.textStyleUtil.titleTable(
                          color: System.data.colorUtil.secondaryColor),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
