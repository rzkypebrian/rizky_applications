import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/customeGoogleMap/googleMaps.dart';
import 'package:enerren/component/flutterGooglePLace/flutter_google_places.dart';
import 'package:enerren/model/LocationModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'viewModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:component_icons/font_awesome.dart';

import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => model,
      child: Consumer<ViewModel>(
        builder: (ctx, dt, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: appBar(viewModel: dt),
            body: body(viewModel: dt),
          );
        },
      ),
    );
  }

  Widget body({ViewModel viewModel}) {
    return Container(
      child: Stack(
        children: <Widget>[
          Center(
            child: maps(viewModel: viewModel),
          ),
          Center(
            child: pinPicker(viewModel: viewModel),
          ),
          widget.showCneterGuidPoint == true
              ? centerGuidPont(viewModel: viewModel)
              : Container(
                  height: 0,
                  width: 0,
                ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              child: searchBoxs(viewModel: viewModel),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: buttonSetLocation(viewModel: viewModel),
            ),
          )
        ],
      ),
    );
  }

  PreferredSizeWidget appBar({ViewModel viewModel}) {
    return BottonComponent.customAppBar1(
        context: context,
        actionText: "",
        backButtonColor: System.data.colorUtil.lightTextColor,
        backgroundColor: System.data.colorUtil.primaryColor,
        title: System.data.resource.selectLocation,
        titleStyle: System.data.textStyleUtil.mainTitle(
          color: System.data.colorUtil.lightTextColor,
        ));
  }

  Widget searchBoxs({ViewModel viewModel}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: viewModel.openSearchResult ? 300 : 50,
      margin: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      width: double.infinity,
      child: PlacesAutocompleteWidget(
        apiKey: "${System.data.global.googleMapApiKey}",
        inputSearchContainer: (controller) {
          viewModel.searchBoxController = controller;
          viewModel.commit();
          return Container(
            height: 100,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: System.data.colorUtil.primaryColor,
                ),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 50,
                    child: Center(
                      child: Icon(
                        FontAwesomeLight(FontAwesomeId.fa_search),
                        color: System.data.colorUtil.primaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: TextField(
                        controller: viewModel.searchBoxController,
                        onTap: () {
                          openSearchHistory();
                        },
                        onChanged: (str) {
                          openSearchHistory();
                        },
                        style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black.withOpacity(0.9)
                                  : Colors.white.withOpacity(0.9),
                          fontSize: 16.0,
                        ),
                        decoration: InputDecoration(
                          hintText: System.data.resource.search,
                          filled: true,
                          fillColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.white30
                                  : Colors.black38,
                          hintStyle: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black38
                                    : Colors.white30,
                            fontSize: 16.0,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            right: 10,
                            top: 5,
                            bottom: 5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      viewModel.searchBoxController.text = "";
                      viewModel.selectedLocation = null;
                      viewModel.commit();
                    },
                    child: Container(
                      height: 100,
                      width: 50,
                      child: Center(
                        child: Icon(
                          FontAwesomeLight(FontAwesomeId.fa_times_circle),
                          color: System.data.colorUtil.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        builder: (prediction) {
          return Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: ListView(
              children: List.generate(prediction.length, (i) {
                return GestureDetector(
                  onTap: () {
                    viewModel.searchBoxController.text =
                        prediction[i].description.trim();
                    viewModel.placeId = prediction[i].placeId;
                    viewModel.commit();
                    gotoPositionByPlaceId();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(prediction[i].description),
                  ),
                );
              }),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: System.data.colorUtil.shadowColor.withOpacity(0.2),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          );
        },
        onEmptyResult: (context) {
          return Container(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 15,
            ),
            child: locationHistory(viewModel),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: System.data.colorUtil.shadowColor.withOpacity(0.2),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buttonSetLocation({ViewModel viewModel}) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: BottonComponent.roundedButton(
          onPressed: pickLocation,
          colorBackground: System.data.colorUtil.primaryColor,
          text: "${System.data.resource.useThisLocation}",
          textstyle: System.data.textStyleUtil.mainTitle(),
        ),
      ),
    );
  }

  Widget historyItem({LocationModel history, ViewModel viewModel}) {
    return GestureDetector(
      onTap: () {
        viewModel.searchBoxController.text = history.address.trim();
        viewModel.selectedLatlong = LatLng(history.lat, history.lon);
        viewModel.commit();
        gotoPosition();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "${history.address}",
          style: System.data.textStyleUtil.mainLabel(),
        ),
      ),
    );
  }

  Widget maps({ViewModel viewModel}) {
    return Align(
      alignment: Alignment.topCenter,
      child: GoogleMaps(
        center: widget.center,
        googleMapController: googleMapControllers,
        onCameraMoveStarted: closeSearchHistory,
        onCameraIdle: () {
          onUpdateMap(googleMapControllers.value.latLng);
        },
      ),
    );
  }

  Widget pinPicker({double width = 300, Widget child, ViewModel viewModel}) {
    return Align(
      // alignment: Alignment(0, 1),
      child: Container(
        height: 180,
        width: 200,
        padding: EdgeInsets.only(bottom: 80),
        color: null,
        child: Align(
          child: FlareActor(
            "assets/flares/angkut/pin_maps_angkut.flr",
            animation: "play",
            shouldClip: true,
            // color: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget centerGuidPont({ViewModel viewModel}) {
    return Center(
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(50))),
      ),
    );
  }

  Widget locationHistory(ViewModel viewModel) {
    return FutureBuilder<List<LocationModel>>(
      future: LocationModel.getHistory(
        token: System.data.global.token,
      ),
      initialData: <LocationModel>[],
      builder: (ctx, snapshoot) {
        if (snapshoot.hasData) {
          viewModel.locationHistory = snapshoot.data;
          viewModel.commit();
        }
        return ListView(
          children: List.generate(viewModel.locationHistory.length + 1, (i) {
            if (i == 0) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${System.data.resource.history}",
                  style: System.data.textStyleUtil.linkLabel(),
                ),
              );
            } else {
              return historyItem(
                history: viewModel.locationHistory[(i - 1)],
                viewModel: viewModel,
              );
            }
          }),
        );
      },
    );
  }
}
