import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/customeGoogleMapUpdate/googleMaps.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => model,
      child: Consumer<ViewModel>(
        builder: (ctx, vm, child) {
          return DecoratedBox(
            decoration: decoration(),
            child: Scaffold(
              appBar: appBar(context),
              backgroundColor: System.data.colorUtil.primaryColor,
              body: body(vm),
              bottomNavigationBar: Container(
                height: MediaQuery.of(context).size.height / 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          padding: EdgeInsets.all(5),
                          child: title(
                              title: "start ${vm.getStartPosition?.target}"),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          padding: EdgeInsets.all(5),
                          child:
                              title(title: "end ${vm.getEndPosition?.target}"),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: startPolygon,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 4,
                            padding: EdgeInsets.all(5),
                            color:
                                vm.getStatusPolygon ? Colors.green : Colors.red,
                            child: title(title: "Polygon"),
                          ),
                        ),
                        GestureDetector(
                          onTap: startPolyline,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 4,
                            padding: EdgeInsets.all(5),
                            color: vm.getStatusPolyline
                                ? Colors.green
                                : Colors.red,
                            child: title(title: "Polyline"),
                          ),
                        ),
                        GestureDetector(
                          onTap: startMarker,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 4,
                            padding: EdgeInsets.all(5),
                            color: vm.getStatusPolymaker
                                ? Colors.green
                                : Colors.red,
                            child: title(
                              title: "marker",
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: startCircle,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 4,
                            padding: EdgeInsets.all(5),
                            color:
                                vm.getStatusCircle ? Colors.green : Colors.red,
                            child: title(
                              title: "circle",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return BottonComponent.customAppBar1(
        context: context,
        actionText: null,
        title: toBeginningOfSentenceCase("${System.data.resource.map}"),
        titleStyle: System.data.textStyleUtil.mainLabel(
            color: System.data.colorUtil.lightTextColor,
            fontSize: System.data.fontUtil.xl),
        backgroundColor: System.data.colorUtil.primaryColor,
        backButtonColor: System.data.colorUtil.lightTextColor);
  }

  Widget circularProgressIndicatorDecoration() {
    return CircularProgressIndicatorComponent(
      controller: loadingController,
    );
  }

  Decoration decoration() {
    return BoxDecoration(
      color: Colors.transparent,
    );
  }

  Widget body(ViewModel vm) {
    return Container(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).size.height / 5 -
          20,
      margin: EdgeInsets.only(bottom: 20),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              child: Column(
                children: [
                  Expanded(child: maps(viewModel: vm)),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: double.infinity,
              child: Column(
                children: [
                  acctionData(
                      title: "remove list polygon",
                      ontap: vm.googleMapControllers.removeAllPolygon),
                  acctionData(
                      title: "remove list polyline",
                      ontap: vm.googleMapControllers.removeAllPolyline),
                  acctionData(
                      title: "remove all marker",
                      ontap: vm.googleMapControllers.removeAllMarker),
                  acctionData(
                      title: "remove all list",
                      ontap: vm.googleMapControllers.removeAll),
                  acctionData(
                      title: "remove point polygon",
                      ontap: () {
                        vm.googleMapControllers.removePointPolygon(layer: 0);
                      }),
                  acctionData(
                      title: "remove point polyline",
                      ontap: () {
                        vm.googleMapControllers.removePointPolyline(layer: 0);
                      }),
                  acctionData(
                      title: "remove point marker",
                      ontap: () {
                        vm.googleMapControllers.removePoint(layer: 0);
                      }),
                  acctionData(
                      title: "remove point and draw list",
                      ontap: vm.googleMapControllers.removeLayer),
                  acctionData(
                    title: "move camera",
                    ontap: moveCamera,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget title({String title}) {
    return Container(
      child: Text(
        "$title",
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget acctionData({String title, VoidCallback ontap}) {
    return GestureDetector(
        onTap: ontap,
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.green,
          ),
          child: Container(
            child: Text(
              "$title",
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }

  Widget maps({ViewModel viewModel}) {
    return Container(
      child: GoogleMaps(
        center: viewModel.center,
        googleMapController: viewModel.googleMapControllers,
        onCameraMoveStarted: (startPosition) {
          viewModel.setStartPositoin = startPosition;
        },
        onCameraIdle: (endPosition) {
          viewModel.setEndPositoin = endPosition;
        },
      ),
    );
  }
}
