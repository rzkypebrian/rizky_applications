import 'package:enerren/app/inovatrack/aCustomer/localData.dart';
import 'package:enerren/model/menuModel.dart';
import 'package:enerren/module/dashboard/view.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:enerren/app/inovatrack/aCustomer/module/menu/main.dart' as menu;
import 'package:provider/provider.dart';
import 'viewModel.dart';
import 'inovatrackPresenter.dart';
import 'package:enerren/component/inovatrackDecorationComponent.dart';

class InovatrackView extends View with InovatrackPresenter {
  final VoidCallback onTapSetting;
  final VoidCallback onTapListVehicle;
  final VoidCallback onTapMaps;
  final VoidCallback onTapContact;

  InovatrackView({
    this.onTapSetting,
    this.onTapListVehicle,
    this.onTapMaps, 
    this.onTapContact,
  });

  List<Widget> components() {
    return <Widget>[
      ChangeNotifierProvider<ViewModel>(
        create: (ctx) => super.model,
        child: Consumer<ViewModel>(
          builder: (ctx, dt, child) {
            return Stack(
              children: <Widget>[
                Container(
                  child: SvgPicture.asset("assets/inovatrack/bg_cloud.svg"),
                ),
                Column(
                  children: <Widget>[
                    headerTop(dt),
                    summary(dt),
                  ],
                ),
              ],
            );
          },
        ),
      )
    ];
  }

  Widget headerTop(dt) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        height: 200,
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    child: Tooltip(
                      message:
                          "${System.data.getLocal<LocalData>().user.memberName}",
                      child: Text(
                        "${System.data.getLocal<LocalData>().user.memberName}",
                        overflow: TextOverflow.ellipsis,
                        style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.blueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: System.data.fontUtil.s,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "${System.data.getLocal<LocalData>().user.userFullName}",
                      style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.blueColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 170,
                width: 160,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 160,
                      width: 160,
                      child: FlareActor(
                        "assets/flares/inovatrack/speedometer_vts.flr",
                        animation: "50",
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: 110, left: 0, bottom: 40),
                        child: Text(
                          "${dt.rankTotal}.0 %",
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.lightTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: System.data.fontUtil.l,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "${System.data.resource.fleetUtilization}",
                        style: System.data.textStyleUtil.mainLabel(
                            fontWeight: FontWeight.bold,
                            color: System.data.colorUtil.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child:
                          SvgPicture.asset("assets/inovatrack/icon_bell.svg"),
                    ),
                    Container(
                      child: GestureDetector(
                        child: SvgPicture.asset(
                            "assets/inovatrack/icon_setting.svg"),
                        onTap: onTapSetting,
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
  }

  Widget summary(dt) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              totalVehicle(dt),
              movingVehicle(dt),
              inPoolVehicle(dt),
              maintenanceVehicle(dt),
            ],
          ),
        ],
      ),
    );
  }

  Widget totalVehicle(dt) {
    return Column(
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              border: Border.all(
                color: System.data.colorUtil.primaryColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 5),
                  height: 23,
                  width: 33,
                  child: SvgPicture.asset(
                    "assets/inovatrack/icon_car.svg",
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 25,
                  color: Colors.blue,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: Text(
                    "${dt.totalVehicles}",
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.lightTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: System.data.fontUtil.s),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Text(
            "${System.data.resource.total}",
            style: System.data.textStyleUtil.mainLabel(
              color: System.data.colorUtil.primaryColor,
              fontSize: System.data.fontUtil.s,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget movingVehicle(dt) {
    return Column(
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              border: Border.all(
                color: System.data.colorUtil.primaryColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 5),
                  height: 23,
                  width: 33,
                  child: SvgPicture.asset(
                    "assets/inovatrack/icon_clock.svg",
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 25,
                  color: Colors.blue,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: Text(
                    "${dt.movingVehicles}",
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.lightTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: System.data.fontUtil.s),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Text(
            "${System.data.resource.moving}",
            style: System.data.textStyleUtil.mainLabel(
              color: System.data.colorUtil.primaryColor,
              fontSize: System.data.fontUtil.s,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget inPoolVehicle(dt) {
    return Column(
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              border: Border.all(
                color: System.data.colorUtil.primaryColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 5),
                  height: 23,
                  width: 33,
                  child: SvgPicture.asset(
                    "assets/inovatrack/icon_garage.svg",
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 25,
                  color: Colors.blue,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: Text(
                    "${dt.inPoolVehicles}",
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.lightTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: System.data.fontUtil.s),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Text(
            "${System.data.resource.inPool}",
            style: System.data.textStyleUtil.mainLabel(
              color: System.data.colorUtil.primaryColor,
              fontSize: System.data.fontUtil.s,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget maintenanceVehicle(dt) {
    return Column(
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              border: Border.all(
                color: System.data.colorUtil.primaryColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 5),
                  height: 23,
                  width: 33,
                  child: SvgPicture.asset(
                    "assets/inovatrack/icon_wrench.svg",
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 25,
                  color: Colors.blue,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: Text(
                    "${dt.maintenanceVehicles}",
                    style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.lightTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: System.data.fontUtil.s),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Text(
            "${System.data.resource.maintenance}",
            style: System.data.textStyleUtil.mainLabel(
              color: System.data.colorUtil.primaryColor,
              fontSize: System.data.fontUtil.s,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget mainBody({
    List<MenuModel> Function() menus,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height -
          350 -
          MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: <Color>[
              System.data.colorUtil.primaryColor,
              System.data.colorUtil.primaryColor,
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          )),
      child: Stack(
        children: <Widget>[
          // Align(
          //   alignment: Alignment.bottomLeft,
          //   child: SvgPicture.asset("assets/sierad/customer_egg_3.svg"),
          // ),
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: SvgPicture.asset("assets/sierad/customer_egg_4.svg"),
          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 15),
              child: SvgPicture.asset(
                "assets/inovatrack/icon_logo_inovatrack.svg",
                color: Colors.white,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height -
                390 -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                   BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(55),
                  topRight: Radius.circular(55),
                  bottomLeft: Radius.elliptical(300, 120),
                  bottomRight: Radius.elliptical(300, 120),
                )),
          ),
          menu.Presenter(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.only(top: 10),
              view: menu.InovatrackView(),
              width: MediaQuery.of(context).size.width,
              heigth: MediaQuery.of(context).size.height - 430,
              menus: menuItems),
        ],
      ),
    );
  }

  List<MenuModel> menuItems() {
    return <MenuModel>[
      MenuModel(
        textMenu: "${System.data.resource.map}",
        immageAssetUrl: "assets/inovatrack/icon_menu_map.svg",
        onTap: onTapMaps,
      ),
      MenuModel(
        textMenu: "${System.data.resource.vehicle}",
        immageAssetUrl: "assets/inovatrack/icon_menu_car.svg",
        onTap: onTapListVehicle,
      ),
      MenuModel(
        textMenu: "${System.data.resource.history}",
        immageAssetUrl: "assets/inovatrack/icon_menu_history.svg",
        // onTap: onTapContact,
      ),
      MenuModel(
        textMenu: "${System.data.resource.statistic}",
        immageAssetUrl: "assets/inovatrack/icon_menu_chart.svg",
        // onTap: onTapMap,
      ),
      MenuModel(
        textMenu: "${System.data.resource.maintenance}",
        immageAssetUrl: "assets/inovatrack/icon_menu_setting.svg",
        // onTap: onTapMap,
      ),
      MenuModel(
        textMenu: "${System.data.resource.help}",
        immageAssetUrl: "assets/inovatrack/icon_menu_contact.svg",
        onTap: onTapContact,
      ),
    ];
  }

  @override
  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularProgressDecoration(
      controller: super.loadingController,
    );
  }
}
