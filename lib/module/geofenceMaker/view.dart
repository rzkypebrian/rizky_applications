import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/customeGoogleMap/googleMaps.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: [
          body(),
          circularProgressIndicatorComponent(),
        ],
      ),
    );
  }

  Widget body() {
    return ChangeNotifierProvider(
      create: (_) => super.model,
      child: Stack(
        children: [
          GoogleMaps(
            googleMapController: model.mapControllers,
            onTapMap: onTap,
          ),
          positionMapButton(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: buttonSetGeofence(),
            ),
          )
        ],
      ),
    );
  }

  Widget circularProgressIndicatorComponent() {
    return DecorationComponent.circularProgressDecoration(
      controller: model.loadingController,
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      context: context,
      actionText: "",
      backButtonColor: System.data.colorUtil.primaryColor,
      backgroundColor: System.data.colorUtil.primaryColor,
      title: System.data.resource.createGeofence,
      titleStyle: System.data.textStyleUtil.mainTitle(
        color: System.data.colorUtil.lightTextColor,
      ),
    );
  }

  Widget positionMapButton() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: listMapButton(),
        ),
      ),
    );
  }

  List<Widget> listMapButton() {
    return [
      buttonLayer(),
      SizedBox(
        height: 10,
      ),
      buttonMyLocation(),
      SizedBox(
        height: 10,
      ),
      buttonRemove(),
    ];
  }

  Widget buttonLayer() {
    return functionButton(onTap: () {
      model.mapControllers.changeMapType();
    });
  }

  Widget buttonMyLocation() {
    return functionButton(
        iconData: Icons.my_location,
        onTap: () {
          getMyLocation();
        });
  }

  Widget buttonRemove() {
    return functionButton(
      iconData: Icons.remove_circle_rounded,
      onTap: remove,
    );
  }

  Widget functionButton({
    IconData iconData,
    VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          boxShadow: <BoxShadow>[
             BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
          ],
        ),
        child: Icon(
          iconData ?? Icons.layers,
          color: System.data.colorUtil.primaryColor,
        ),
      ),
    );
  }

  Widget buttonSetGeofence() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: BottonComponent.roundedButton(
          onPressed: setGeofence,
          colorBackground: System.data.colorUtil.primaryColor,
          text: "${System.data.resource.useThisLocation}",
          textstyle: System.data.textStyleUtil.mainTitle(),
        ),
      ),
    );
  }
}
