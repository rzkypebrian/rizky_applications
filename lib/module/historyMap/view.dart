import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/customeGoogleMap/googleMaps.dart';
import 'package:enerren/component/positionInfoDecoration.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'presenter.dart';
import 'package:flutter/material.dart';
import 'viewModel.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => model,
      child: Consumer<ViewModel>(
        builder: (ctx, vm, child) {
          return Scaffold(
            backgroundColor: System.data.colorUtil.primaryColor,
            appBar: BottonComponent.customAppBar1(
              context: context,
              backgroundColor: System.data.colorUtil.primaryColor,
              backButtonColor: System.data.colorUtil.secondaryColor,
              actionText: System.data.resource.back,
              title: System.data.resource.history,
              titleColor: System.data.colorUtil.secondaryColor,
            ),
            body: body(vm),
          );
        },
      ),
    );
  }

  Widget body(ViewModel vm) {
    return Container(
      color: System.data.colorUtil.lightTextColor,
      child: Stack(
        children: <Widget>[
          Column(
            children: listComponent(vm),
          ),
          Center(
            child: circularProgressIndicatorDecoration(),
          ),
        ],
      ),
    );
  }

  List<Widget> listComponent(ViewModel vm) {
    return <Widget>[
      map(vm),
      controllerHistory(vm),
    ];
  }

  Widget controllerHistory(ViewModel vm) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 500,
      ),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: System.data.colorUtil.shadowColor.withOpacity(0.2),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ]),
      height: vm.boxHeight,
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(0, -1.07),
            child: Container(
              child: IconButton(
                iconSize: 15,
                color: System.data.colorUtil.primaryColor,
                icon: Icon(
                  vm.iconDetail,
                ),
                onPressed: super.detailHistory,
              ),
            ),
          ),
          detailInfo(vm),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              height: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: Text(
                        "${vm.isLoaded == true ? DateFormat('yyyy-MM-dd H:m:s').format(vm.listVtsPositionModel[vm.currentIndexInt].dateTime) : "-"} "),
                  ),
                  Container(
                    height: 30,
                    child: Slider(
                      activeColor: System.data.colorUtil.primaryColor,
                      value: vm.isLoaded ? vm.currentIndex : 0,
                      onChanged: (i) {
                        if (i < model.currentIndex) {
                          super.movePrevious(i.toInt());
                        } else {
                          super.moveNext(i.toInt());
                        }
                      },
                      min: vm.isLoaded ? vm.minSlider : 0,
                      max: vm.isLoaded ? vm.maxSlider : 0,
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        decoreationContainer(
                          IconButton(
                            iconSize: 20,
                            color: System.data.colorUtil.primaryColor,
                            icon: Icon(
                              FontAwesomeSolid(FontAwesomeId.fa_step_backward),
                            ),
                            onPressed: () => super.movePrevious(0),
                          ),
                        ),
                        decoreationContainer(
                          IconButton(
                            iconSize: 20,
                            color: System.data.colorUtil.primaryColor,
                            icon: Icon(
                              FontAwesomeSolid(FontAwesomeId.fa_backward),
                            ),
                            onPressed: () => super.movePrevious(
                                (vm.currentIndexInt - 1) < 0
                                    ? 0
                                    : (vm.currentIndexInt - 1)),
                          ),
                        ),
                        decoreationContainer(
                          IconButton(
                            iconSize: 20,
                            color: vm.startTimer
                                ? System.data.colorUtil.redColor
                                : System.data.colorUtil.primaryColor,
                            icon: Icon(
                              vm.startTimer
                                  ? FontAwesomeSolid(FontAwesomeId.fa_pause)
                                  : vm.currentIndex == vm.maxSlider
                                      ? FontAwesomeSolid(
                                          FontAwesomeId.fa_redo_alt)
                                      : FontAwesomeSolid(FontAwesomeId.fa_play),
                            ),
                            onPressed: super.play,
                          ),
                        ),
                        decoreationContainer(
                          IconButton(
                            iconSize: 20,
                            color: System.data.colorUtil.primaryColor,
                            icon: Icon(
                              FontAwesomeSolid(FontAwesomeId.fa_forward),
                            ),
                            onPressed: () => super.moveNext(
                                (vm.currentIndexInt + 1) >
                                        vm.listVtsPositionModel.length - 1
                                    ? vm.listVtsPositionModel.length - 1
                                    : (vm.currentIndexInt + 1)),
                          ),
                        ),
                        decoreationContainer(
                          IconButton(
                            iconSize: 20,
                            color: System.data.colorUtil.primaryColor,
                            icon: Icon(
                              FontAwesomeSolid(FontAwesomeId.fa_step_forward),
                            ),
                            onPressed: () => super
                                .moveNext(vm.listVtsPositionModel.length - 1),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailInfo(ViewModel vm) {
    return Align(
      alignment: Alignment(0, -0.9),
      child: Container(
        height: 260,
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            vm.listVtsPositionModel.length > 0
                ? tabContent(vm)
                : Container(
                    height: 0,
                    width: 0,
                  ),
            vm.listVtsPositionModel.length > 0
                ? tabBarButton(vm)
                : Container(
                    height: 0,
                    width: 0,
                  ),
          ],
        ),
      ),
    );
  }

  Widget tabContent(ViewModel vm) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: TabBarView(
          controller: tabController,
          children: <Widget>[
            PositionInfoDecoration.summary(
                vm.listVtsPositionModel[vm.currentIndexInt]),
            PositionInfoDecoration.position(
                vm.listVtsPositionModel[vm.currentIndexInt]),
            PositionInfoDecoration.status(
                vm.listVtsPositionModel[vm.currentIndexInt]),
          ],
        ),
      ),
    );
  }

  Widget tabBarButton(ViewModel vm) {
    return Container(
      height: 40,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(0, -0.35),
            child: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              controller: tabController,
              indicatorPadding: EdgeInsets.all(0),
              onTap: super.ontapTabView,
              indicatorWeight: 0.00001,
              tabs: List.generate(
                vm.lengthTab,
                (i) {
                  return Container(
                    height: 20,
                    width: 10,
                    decoration: BoxDecoration(
                      color: vm.currentIndexTab == i
                          ? System.data.colorUtil.primaryColor
                          : System.data.colorUtil.lightTextColor,
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: System.data.colorUtil.shadowColor
                              .withOpacity(0.2),
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return CircularProgressIndicatorComponent(
      controller: loadingController,
    );
  }

  Widget decoreationContainer(Widget child) {
    return Container(
      width: 36,
      height: 36,
      margin: EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: System.data.colorUtil.primaryColor)),
      child: child,
    );
  }

  Widget map(ViewModel vm) {
    return Expanded(
      child: Container(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: GoogleMaps(
                googleMapController: googleMapControllers,
              ),
            ),
            mapControll(vm)
          ],
        ),
      ),
    );
  }

  Widget mapControll(ViewModel vm) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(
                  FontAwesomeLight(FontAwesomeId.fa_traffic_light),
                  color: vm.showTrafic == true
                      ? System.data.colorUtil.primaryColor
                      : null,
                ),
                onPressed: changeTrafic,
              ),
            ),
            Container(
              child: IconButton(
                  icon: Icon(FontAwesomeLight(FontAwesomeId.fa_search_plus)),
                  onPressed: googleMapControllers.zoom),
            ),
            Container(
              child: IconButton(
                  icon: Icon(FontAwesomeLight(FontAwesomeId.fa_search_minus)),
                  onPressed: () => googleMapControllers.zoom(zoom: false)),
            ),
            Container(
              child: IconButton(
                  icon: Icon(FontAwesomeLight(FontAwesomeId.fa_map)),
                  onPressed: googleMapControllers.changeMapType),
            ),
          ],
        ),
      ),
    );
  }
}
