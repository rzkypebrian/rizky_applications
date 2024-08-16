import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/bottomDockComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/customeGoogleMap/googleMaps.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:provider/provider.dart';
import 'presenter.dart';
import 'package:flutter/material.dart';
import 'package:enerren/util/boolExtention.dart';

import 'viewModel.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => super.model,
      child: Consumer<ViewModel>(
        builder: (ctx, vm, child) {
          return Scaffold(
            backgroundColor: System.data.colorUtil.primaryColor,
            appBar: BottonComponent.customAppBar1(
              context: context,
              backgroundColor: System.data.colorUtil.primaryColor,
              backButtonColor: System.data.colorUtil.secondaryColor,
              actionText: System.data.resource.back,
              title: System.data.resource.liveMap,
              titleColor: System.data.colorUtil.secondaryColor,
            ),
            body: body(),
          );
        },
      ),
    );
  }

  Widget body() {
    return Container(
      child: Stack(
        children: listComponent(),
      ),
    );
  }

  List<Widget> listComponent() {
    return <Widget>[
      map(),
      estimationTime(),
    ];
  }

  Widget map() {
    return Container(
      child: Stack(
        children: <Widget>[
          GoogleMaps(
            googleMapController: model.googleMapsControllers,
            // on: (latLng) => super.setFollowVehicle(false),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                layer(),
                SizedBox(
                  height: 10,
                ),
                trafic(),
                SizedBox(
                  height: 10,
                ),
                reCenter(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          mapCircularProgressIndicatorDecoration(mapLoadingController)
        ],
      ),
    );
  }

  Widget mapCircularProgressIndicatorDecoration(
      CircularProgressIndicatorController mapLoadingController) {
    return CircularProgressIndicatorComponent(
      aligment: Alignment.center,
      controller: mapLoadingController,
    );
  }

  Widget reCenter() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: System.data.colorUtil.shadowColor.withOpacity(0.2),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ]),
        child: IconButton(
          color: super.model.isFollowVehicle
              ? System.data.colorUtil.primaryColor
              : System.data.colorUtil.greyColor,
          icon: Icon(
            FontAwesomeLight(FontAwesomeId.fa_location_arrow),
            size: 20,
          ),
          onPressed: () {
            setFollowVehicle(model.isFollowVehicle.toggle());
          },
        ),
      ),
    );
  }

  Widget trafic() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: System.data.colorUtil.shadowColor.withOpacity(0.2),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ]),
        child: IconButton(
          color: super.model.isTrafic
              ? System.data.colorUtil.primaryColor
              : System.data.colorUtil.greyColor,
          icon: Icon(Icons.traffic),
          onPressed: () {
            setTrafic(model.googleMapsControllers.trafficEnabled());
          },
        ),
      ),
    );
  }

  Widget layer() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: System.data.colorUtil.shadowColor.withOpacity(0.2),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ]),
        child: IconButton(
          color: System.data.colorUtil.primaryColor,
          icon: Icon(Icons.layers),
          onPressed: () {
            model.googleMapsControllers.changeMapType();
          },
        ),
      ),
    );
  }

  Widget floatingActionBotton() {
    return Container(
      // color: Colors.red,
      height: 130,
      width: 100,
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(
                FontAwesomeRegular(FontAwesomeId.fa_marker),
                color: Colors.black,
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              onPressed: removePolyline,
              child: Icon(
                FontAwesomeRegular(FontAwesomeId.fa_draw_polygon),
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return BottomDockComponent(
      controller: super.bottomSheetController,
      gripBackground: Colors.white,
      gripColorOnFree: Colors.grey,
      gripColorOnDrag: Colors.grey,
      handleBar: (value) => Container(
        margin: EdgeInsets.only(top: 2),
        height: 20,
        color: Colors.white.withOpacity(0),
        width: double.infinity,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 5,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
          ),
        ),
      ),
      minHeight: 10,
      maxHeight: super.bottomSheetHeight,
      isExpand: super.bottomSheetController.value.isExpand,
      extraArea: 10,
      bottonSheetDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.lerp(Radius.circular(10), Radius.circular(40), 1),
          topRight: Radius.lerp(Radius.circular(10), Radius.circular(40), 1),
        ),
      ),
      contentPadding: super.bottomSheetContentPadding,
      child: bottomSheetContent(),
    );
  }

  Widget bottomSheetContent() {
    return Center(
      child: Text("nandang hermawn"),
    );
  }

  Widget estimationTime() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: widget.drawRoute
          ? Container(
              padding: EdgeInsets.only(bottom: 15, left: 8, right: 8, top: 8),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(-2, 0),
                    blurRadius: 3,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${System.data.resource.estimatedTimeOfArrival} : ",
                      style: System.data.textStyleUtil.linkLabel(),
                    ),
                    Text(
                      "${model.googleGeocoderModel.routes.isEmpty ? "-" : model.googleGeocoderModel?.routes[0]?.legs?.first?.duration?.text}",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
                  ],
                ),
              ),
            )
          : SizedBox(),
    );
  }
}
