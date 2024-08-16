import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:enerren/util/DateTimeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'ViewModel.dart';
import 'presenter.dart';

class View<T> extends PresenterState<T> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel<T>>(
      create: (BuildContext context) => model,
      child: Consumer<ViewModel<T>>(
        builder: (BuildContext context, value, Widget child) {
          return Scaffold(
            appBar: appBar(),
            body: Stack(
              children: <Widget>[
                home(value),
                circularProgressIndicatorComponent(),
              ],
            ),
          );
          // } catch (e) {
          //   ModeUtil.debugPrint(e);
          //   return Scaffold(
          //     appBar: appBar(),
          //     body: Container(),
          //   );
          // }
        },
      ),
    );
  }

  Widget circularProgressIndicatorComponent() {
    return DecorationComponent.circularProgressDecoration(
      controller: loadingController,
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      title: System.data.resource.listVehicle,
      context: context,
      actionText: "",
      titleColor: System.data.colorUtil.secondaryColor,
      backButtonColor: System.data.colorUtil.lightTextColor,
      actionTextStyle: System.data.textStyleUtil.mainLabel(),
      actionTextColor: System.data.colorUtil.lightTextColor,
      titleStyle: System.data.textStyleUtil.mainTitle(),
      backgroundColor: System.data.colorUtil.primaryColor,
    );
  }

  Widget home(ViewModel viewModel) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
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
            margin: EdgeInsets.only(bottom: 10),
            child: TabBar(
              controller: listController,
              labelColor: Colors.white,
              indicator: BoxDecoration(
                color: System.data.colorUtil.primaryColor.withOpacity(0.8),
              ),
              onTap: changeTab,
              tabs: <Tab>[
                Tab(
                  child: Container(
                    child: Text(
                        toBeginningOfSentenceCase(
                          "${System.data.resource.vehicle}",
                        ),
                        style: System.data.textStyleUtil.mainLabel(
                            fontWeight: FontWeight.bold,
                            color: model.selectedTab == 0
                                ? System.data.colorUtil.secondaryColor
                                : System.data.colorUtil.greyColor)),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                        toBeginningOfSentenceCase(
                          "${System.data.resource.driver}",
                        ),
                        style: System.data.textStyleUtil.mainLabel(
                            fontWeight: FontWeight.bold,
                            color: model.selectedTab == 1
                                ? System.data.colorUtil.secondaryColor
                                : System.data.colorUtil.greyColor)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: TabBarView(
                controller: listController,
                children: <Widget>[
                  vehicles(viewModel),
                  drivers(viewModel),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget vehicles(ViewModel item) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
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
            margin: EdgeInsets.only(bottom: 10),
            child: TabBar(
              controller: listControllerVehicle,
              isScrollable: true,
              labelColor: Colors.red,
              indicatorColor: Colors.transparent,
              unselectedLabelColor: System.data.colorUtil.greenColor,
              onTap: onTapSubTabVehicle,
              tabs: <Tab>[
                Tab(
                  child: Container(
                    // width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        circleContainer(
                            color: 0 == model.selectedVehicle
                                ? System.data.colorUtil.blueColor
                                : System.data.colorUtil.greyColor),
                        Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.all}"),
                          style: System.data.textStyleUtil.mainTitle(
                              color: System.data.colorUtil.blueColor),
                        ),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    // width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        circleContainer(
                            color: 1 == model.selectedVehicle
                                ? System.data.colorUtil.yellowColor
                                : System.data.colorUtil.greyColor),
                        Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.order}"),
                          style: System.data.textStyleUtil.mainTitle(
                              color: System.data.colorUtil.yellowColor),
                        )
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    // width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        circleContainer(
                            color: 2 == model.selectedVehicle
                                ? System.data.colorUtil.greenColor
                                : System.data.colorUtil.greyColor),
                        Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.standBy}"),
                          style: System.data.textStyleUtil.mainTitle(
                              color: System.data.colorUtil.greenColor),
                        )
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    // width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        circleContainer(
                            color: 3 == model.selectedVehicle
                                ? System.data.colorUtil.redColor
                                : System.data.colorUtil.greyColor),
                        Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.rest}"),
                          style: System.data.textStyleUtil
                              .mainTitle(color: System.data.colorUtil.redColor),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: TabBarView(
                controller: listControllerVehicle,
                children: [
                  vehicless(model.suitableVehicle),
                  vehicless(model.suitableVehicle
                      .where((x) =>
                          x.vehicleStatusId == 2 || x.vehicleStatusId == 3)
                      .toList()),
                  vehicless(model.suitableVehicle
                      .where((x) => x.vehicleStatusId == 1)
                      .toList()),
                  vehicless(model.suitableVehicle
                      .where((x) => x.vehicleStatusId == 0)
                      .toList()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget vehicless(List<TmsVehicleModel<T>> items) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
            children: items.map((f) {
          return GestureDetector(
            onTap: () {
              onTapItemVehicle(
                  f,
                  f.isSuitable
                      ? model.positions
                          .where((p) => p.vehicleId == f.vtsVehicleId)
                          .toList()
                          ?.first
                      : null);
            },
            child: vehicleItemView(
                f,
                f.isSuitable
                    ? model.positions
                        .where((p) => p.vehicleId == f.vtsVehicleId)
                        .toList()
                        ?.first
                    : null),
          );
        }).toList()),
      ),
    );
  }

  Widget statusRight(TmsVehicleModel<T> f) {
    Color _color;
    if (f.vehicleStatusId == 0) {
      _color = System.data.colorUtil.redColor;
    } else if (f.vehicleStatusId == 1) {
      _color = System.data.colorUtil.greenColor;
    } else {
      _color = System.data.colorUtil.yellowColor;
    }
    return Container(
      width: 60,
      padding: EdgeInsets.only(left: 10),
      child: Center(
        // child: SvgPicture.asset(_pathEgg),
        child: Icon(
          Icons.brightness_1,
          size: 30,
          color: _color,
        ),
      ),
    );
  }

  Widget vehicleItemView(TmsVehicleModel<T> f, VtsPositionModel positionModel) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
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
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
                height: 120,
                width: 60,
                child: SvgPicture.asset(
                  "assets/sierad/rightlist.svg",
                  fit: BoxFit.fill,
                )),
          ),
          Align(
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 75,
                    height: 120,
                    margin: EdgeInsets.only(right: 10),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Container(
                            width: 50,
                            height: 50,
                            child:
                                SvgPicture.network("${f.vehicleTypeIconUrl}"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                    f.isSuitable
                                        ? DateTimeUtil.getStringDateDiff(
                                            positionModel.dateTime)
                                        : "-",
                                    style: System.data.textStyleUtil.mainLabel(
                                        fontSize: System.data.fontUtil.s)),
                              ],
                            ),
                          ),
                          Divider(
                            color: System.data.colorUtil.darkTextColor,
                            thickness: 1,
                            height: 15,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    toBeginningOfSentenceCase(
                                        "${f.vehicleTypeCode}"),
                                  ),
                                ),
                                Text(
                                  toBeginningOfSentenceCase(f.isSuitable
                                      ? "${VtsPositionModel.readSensor(f.vehicleTemperatureSensor, positionModel) ?? "-"}"
                                      : "-"),
                                ),
                                Container(
                                  height: 20,
                                  width: 20,
                                  child: FlareActor(
                                    "assets/flares/temperature_warm.flr",
                                    animation: "play",
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    toBeginningOfSentenceCase(
                                        "${f.vehicleNumber}"),
                                  ),
                                ),
                                Text(
                                  toBeginningOfSentenceCase(f.isSuitable
                                      ? "${VtsPositionModel.readSensor(f.vehicleBackDoorSensor, positionModel) == false ? System.data.resource.closed : VtsPositionModel.readSensor(f.vehicleBackDoorSensor, positionModel) == true ? System.data.resource.open : "-"}"
                                      : "-"),
                                ),
                                Container(
                                  height: 20,
                                  width: 20,
                                  child: FlareActor(
                                    "assets/flares/sierad/backdoor.flr",
                                    animation: f.isSuitable
                                        ? "${VtsPositionModel.readSensor(f.vehicleBackDoorSensor, positionModel) == false ? "close" : VtsPositionModel.readSensor(f.vehicleBackDoorSensor, positionModel) == true ? "open" : "-"}"
                                        : "open",
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    toBeginningOfSentenceCase(
                                        "${f.driverName}"),
                                  ),
                                ),
                                Text(
                                  toBeginningOfSentenceCase(f.isSuitable
                                      ? "${VtsPositionModel.readSensor(f.vehicleFanSensor, positionModel) == false ? System.data.resource.on : VtsPositionModel.readSensor(f.vehicleFanSensor, positionModel) == true ? System.data.resource.off : "-"}"
                                      : "-"),
                                ),
                                Container(
                                  height: 20,
                                  width: 20,
                                  child: FlareActor(
                                    "assets/flares/sierad/fan.flr",
                                    animation: f.isSuitable
                                        ? "${VtsPositionModel.readSensor(f.vehicleFanSensor, positionModel) == false ? "play" : VtsPositionModel.readSensor(f.vehicleFanSensor, positionModel) == true ? "off" : "-"}"
                                        : "-",
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  statusRight(f),
                ],
              )),
        ],
      ),
    );
  }

  Widget drivers(ViewModel items) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
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
            margin: EdgeInsets.only(bottom: 10),
            child: TabBar(
              controller: listControllerDriver,
              labelColor: Colors.red,
              indicatorColor: Colors.transparent,
              unselectedLabelColor: Colors.green,
              isScrollable: true,
              onTap: onTapSubTabDriver,
              tabs: <Tab>[
                Tab(
                  child: Container(
                    // width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        circleContainer(
                            color: 0 == model.selectetDriver
                                ? System.data.colorUtil.blueColor
                                : System.data.colorUtil.greyColor),
                        Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.all}"),
                          style: System.data.textStyleUtil.mainTitle(
                              color: System.data.colorUtil.blueColor),
                        ),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    // width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        circleContainer(
                            color: 1 == model.selectetDriver
                                ? System.data.colorUtil.yellowColor
                                : System.data.colorUtil.greyColor),
                        Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.order}"),
                          style: System.data.textStyleUtil.mainTitle(
                              color: System.data.colorUtil.yellowColor),
                        )
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    // width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        circleContainer(
                            color: 2 == model.selectetDriver
                                ? Colors.green
                                : System.data.colorUtil.greyColor),
                        Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.standBy}"),
                          style: System.data.textStyleUtil
                              .mainTitle(color: Colors.green),
                        )
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    // width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        circleContainer(
                            color: 3 == model.selectetDriver
                                ? System.data.colorUtil.redColor
                                : System.data.colorUtil.greyColor),
                        Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.rest}"),
                          style: System.data.textStyleUtil
                              .mainTitle(color: System.data.colorUtil.redColor),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: TabBarView(
                controller: listControllerDriver,
                children: [
                  driverss(model.suitableVehicle),
                  driverss(model.suitableVehicle
                      .where((x) =>
                          x.vehicleStatusId == 2 || x.vehicleStatusId == 3)
                      .toList()),
                  driverss(model.suitableVehicle
                      .where((x) => x.vehicleStatusId == 1)
                      .toList()),
                  driverss(model.suitableVehicle
                      .where((x) => x.vehicleStatusId == 0)
                      .toList()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget driverss(List<TmsVehicleModel<T>> driverModel) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
            children: driverModel.map((f) {
          return GestureDetector(
            onTap: () {
              onTapItemDriver(
                  f,
                  f.isSuitable
                      ? model.positions
                          .where((p) => p.vehicleId == f.vtsVehicleId)
                          .toList()
                          ?.first
                      : null);
            },
            child: driverItemView(
                f,
                f.isSuitable
                    ? model.positions
                        .where((p) => p.vehicleId == f.vtsVehicleId)
                        .toList()
                        ?.first
                    : null),
          );
        }).toList()),
      ),
    );
  }

  Widget driverItemView(TmsVehicleModel<T> f, VtsPositionModel positionModel) {
    String _pathEgg;
    if (f.vehicleStatusId == 0) {
      _pathEgg = "assets/sierad/redEgg.svg";
    } else if (f.vehicleStatusId == 1) {
      _pathEgg = "assets/sierad/greenEgg.svg";
    } else {
      _pathEgg = "assets/sierad/yellowEgg.svg";
    }
    return Container(
      margin: EdgeInsets.only(bottom: 10),
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
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: SvgPicture.asset("assets/sierad/rightlist.svg"),
          ),
          Align(
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 93,
                    margin: EdgeInsets.only(right: 10),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: System.data.colorUtil.disableColor,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage("${f.driverImageUrl}"))),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Text(
                                toBeginningOfSentenceCase("${f.driverName}")),
                          ),
                          Container(
                            child: Text(toBeginningOfSentenceCase(
                                "${f.driverSimType}")),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    child: Center(
                      child: SvgPicture.asset(_pathEgg),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget circleContainer({Color color = Colors.red}) {
    return Container(
      width: 20,
      height: 20,
      margin: EdgeInsets.only(right: 5),
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 17,
              height: 17,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 13,
              height: 13,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
