import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: System.data.colorUtil.greyColor,
      appBar: appbar(),
      body: Container(
        child: Stack(
          children: <Widget>[
            tabBar(),
            tabBarView(),
          ],
        ),
      ),
    );
  }

  Widget appbar() {
    return BottonComponent.customAppBar1(
      context: context,
      actionText: "",
      title: "${System.data.resource.trackShipment}",
      titleColor: System.data.colorUtil.lightTextColor,
      backgroundColor: System.data.colorUtil.blueColor,
      backButtonColor: System.data.colorUtil.lightTextColor,
    );
  }

  Widget tabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
           BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TabBar(
        indicator: BoxDecoration(
          border: Border.all(
              width: 50, color: System.data.colorUtil.tabBarBlueColor),
        ),
        labelColor: System.data.colorUtil.lightTextColor,
        labelStyle: System.data.textStyleUtil.mainLabel(
            color: System.data.colorUtil.lightTextColor,
            fontWeight: FontWeight.bold),
        unselectedLabelColor: System.data.colorUtil.disableColor,
        unselectedLabelStyle:
            System.data.textStyleUtil.mainLabel(fontWeight: FontWeight.bold),
        controller: tabController,
        tabs: <Widget>[
          new Tab(
            text: "${System.data.resource.status}",
          ),
          new Tab(
            text: "${System.data.resource.map}",
          ),
        ],
      ),
    );
  }

  Widget tabBarView() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: TabBarView(
        controller: tabController,
        children: <Widget>[
          statusShipment(),
          mapShipment(),
        ],
      ),
    );
  }

  Widget statusShipment() {
    return Container(
      child: Center(child: Text("Status")),
      color: Colors.white,
    );
  }

  Widget mapShipment() {
    return Container(
      child: Center(
        child: Text(
          "Map",
        ),
      ),
      color: Colors.blue,
    );
  }
}
