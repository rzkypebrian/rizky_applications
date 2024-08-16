import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/app/inovatrack/aCustomer/module/detailVehicle/presenter.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/positionInfoDecoration.dart';
import 'package:enerren/component/inovatrackDecorationComponent.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'presenter.dart';

class View extends PresenterState with TickerProviderStateMixin {
  TabController tabController;
  void initState() {
    tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => model,
      child: Scaffold(
        backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
        appBar: appBar(context),
        body: Stack(
          children: <Widget>[
            bgVehicle(),
            body(),
            DecorationComponent.circularProgressDecoration(
              controller: loadingController,
            )
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return BottonComponent.customAppBar1(
        backgroundColor: System.data.colorUtil.primaryColor,
        actionText: "",
        context: context,
        backButtonColor: System.data.colorUtil.lightTextColor,
        title: System.data.resource.detailVehicleTitle,
        titleStyle: System.data.textStyleUtil.mainTitle(),
        rightWidget: GestureDetector(
          onTap: () {
            modalConfirmImmobilize();
          },
          child: Container(
            margin: EdgeInsets.only(right: 15),
            height: 30,
            width: 30,
            color: Colors.transparent,
            child: SvgPicture.asset("assets/inovatrack/immobilize_off.svg"),
          ),
        ));
  }

  Widget body() {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          //bgVehicle(),
          mainBody(),
        ],
      ),
    );
  }

  Widget bgVehicle() {
    return Stack(
      children: <Widget>[
        Container(
          child: SvgPicture.asset("assets/inovatrack/vehiclebg3.svg"),
        ),
        Container(
          //color: Colors.red,
          height: 80,
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 38),
          padding: EdgeInsets.only(left: 5, right: 5, top: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 20,
                margin: EdgeInsets.only(bottom: 2),
                child: Text(
                  "${model.vtsPositionModel.vehicleNumber}\n",
                  style: System.data.textStyleUtil.mainLabel(
                      fontSize: System.data.fontUtil.xl,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  height: 20,
                  child: Text(
                    "${model.vtsPositionModel.vehicleName}",
                    style: System.data.textStyleUtil.mainLabel(
                        fontSize: System.data.fontUtil.s,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Widget mainBody() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 120),
        padding: EdgeInsets.only(left: 20, right: 20),
        height: MediaQuery.of(context).size.height -
            200 -
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
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
              // bottomLeft: Radius.elliptical(300, 0),
              // bottomRight: Radius.elliptical(300, 0),
            )),
        child: Stack(
          children: <Widget>[
            Center(
              child: vehicleTab(),
            ),
            Container(
              margin: EdgeInsets.only(top: 100),
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  Container(child: detailVehicleItem1(model.vtsPositionModel)),
                  Container(child: detailVehicleItem2(model.vtsPositionModel)),
                  Container(child: detailVehicleItem3(model.vtsPositionModel)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 50),
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: onTapMap,
                child: SvgPicture.asset("assets/inovatrack/location.svg"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget vehicleTab() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: new BorderRadius.all(Radius.circular(8)),
                color: System.data.colorUtil.borderInputColor),
            height: 50,
            child: TabBar(
              controller: tabController,
              unselectedLabelColor: System.data.colorUtil.greyColor,
              unselectedLabelStyle: System.data.textStyleUtil.mainLabel(
                  fontWeight: FontWeight.bold,
                  fontSize: System.data.fontUtil.xl),
              labelColor: System.data.colorUtil.lightTextColor,
              labelStyle: System.data.textStyleUtil.mainLabel(
                  fontWeight: FontWeight.bold,
                  fontSize: System.data.fontUtil.xl),
              indicator: BoxDecoration(
                  // borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                width: 30,
                color: System.data.colorUtil.blueColor,
              )),
              labelPadding: EdgeInsets.only(top: 5),
              tabs: <Widget>[
                Tab(text: "${System.data.resource.summary}"),
                Tab(text: "${System.data.resource.position}"),
                Tab(text: "${System.data.resource.status}")
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget detailVehicleItem1(VtsPositionModel data) {
    return PositionInfoDecoration.summary(data);
  }

  Widget detailVehicleItem2(VtsPositionModel data) {
    return PositionInfoDecoration.position(data);
  }

  Widget detailVehicleItem3(VtsPositionModel data) {
    return PositionInfoDecoration.status(data);
  }

  Widget circularProgressIndicatorComponent() {
    return CircularProgressIndicatorComponent();
  }

  void modalConfirmImmobilize() {
    ModalComponent.bottomModalWithCorner(context,
        height: 330,
        backgroundColor: Colors.transparent,
        child: Container(
            height: 312,
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 255,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child:
                        SvgPicture.asset("assets/inovatrack/bg_mobilize.svg"),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 50),
                    child: SvgPicture.asset(
                      "assets/inovatrack/immobilize_confirm.svg",
                      alignment: Alignment.topLeft,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: 100,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "${System.data.resource.areYouSureToImmobilizeVehicle}",
                            style: System.data.textStyleUtil.mainLabel(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: System.data.colorUtil.primaryColor),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      //
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      color: System.data.colorUtil.primaryColor,
                                      child: Center(
                                        child: Text(
                                          System.data.resource.yes,
                                          textAlign: TextAlign.center,
                                          style: System.data.textStyleUtil
                                              .mainTitle(
                                            color: System
                                                .data.colorUtil.lightTextColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      //
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      color: Colors.white,
                                      child: Center(
                                        child: Text(
                                          System.data.resource.no,
                                          textAlign: TextAlign.center,
                                          style: System.data.textStyleUtil
                                              .mainTitle(
                                            color: System
                                                .data.colorUtil.darkTextColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                )
              ],
            )));
  }
}
