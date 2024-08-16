import 'package:enerren/app/angkut/aDriver/localData.dart';
import 'package:enerren/app/angkut/aDriver/module/dashboard/angkutPresenter.dart';
import 'package:enerren/app/angkut/aDriver/module/dashboard/viewModel.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/multipleImagePickerComponent.dart';
import 'package:enerren/model/menuModel.dart';
import 'package:enerren/model/profileModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/InternalDataUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:component_icons/font_awesome.dart';
import 'package:enerren/app/angkut/module/menu/main.dart' as menu;

import 'package:enerren/module/dashboard/view.dart';
import 'package:provider/provider.dart';

class AngkutView extends View with AngkutPresenter {
  final FlareControls controls = FlareControls();
  final VoidCallback onTapSetting;
  final ValueChanged<AngkutShipmentModel> onTapEmergency;
  final ValueChanged<AngkutShipmentModel> onTapLiveMap;
  final VoidCallback onTapHistory;
  final VoidCallback onTapUangJalan;
  final VoidCallback onTapNotification;
  final VoidCallback onTapScore;
  final String logoAssets;
  final String animationScoreAssets;
  final String animationNotificationAssets;

  AngkutView({
    this.onTapHistory,
    this.onTapSetting,
    this.onTapEmergency,
    this.onTapLiveMap,
    this.onTapUangJalan,
    this.onTapNotification,
    this.onTapScore,
    this.logoAssets,
    this.animationScoreAssets,
    this.animationNotificationAssets,
  });

  @override
  void initState() {
    super.initState();
  }

  void initData() {
    super.profile = new ProfileModel(
      name: System.data.getLocal<LocalData>().user.driverName,
      email: System.data.getLocal<LocalData>().user.email,
      phone: System.data.getLocal<LocalData>().user.phoneNumber,
      urlImmage: System.data.getLocal<LocalData>().user.urlProfileImage.isEmpty
          ? profile.urlImmage
          : System.data.getLocal<LocalData>().user.urlProfileImage,
      // urlImmage: null,
    );
  }

  @override
  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularLOadingIndicator(
        controller: loadingController);
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => super.model,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            super.build(context),
            DecorationComponent.circularLOadingIndicator(
                lightMode: false, controller: dashboardLoadingController),
          ],
        ),
      ),
    );
  }

  @override
  Decoration decoration() {
    return DecorationComponent.backGroundDecoration2();
  }

  List<Widget> components() {
    return <Widget>[
      logo(),
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 150,
          child: Stack(
            children: <Widget>[
              DecorationComponent.logo(
                logoColor: Colors.green,
                logo: false,
                waterMarkColor: System.data.colorUtil.backgrondColor,
              ),
              header(),
            ],
          ),
        ),
      ),
      Center(
        child: Container(
          height: 150,
          child: Stack(
            children: <Widget>[
              Container(
                child: FlareActor(
                  "assets/flares/angkut/angkut_background.flr",
                  animation: "play",
                ),
                padding: EdgeInsets.only(bottom: 50),
              ),
              ranking(
                  width: 250,
                  value: System.data
                      .getLocal<LocalData>()
                      .user
                      .score
                      .floor()
                      .toDouble(),
                  barValueColor: System.data.colorUtil.yellowColor,
                  barBackgroudColor: Color(0xFFDEDEDE),
                  valueStyle: System.data.textStyleUtil.mainLabel(
                    color: System.data.colorUtil.yellowColor,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      ),
    ];
  }

  @override
  Widget mainBody({List<MenuModel> Function() menus}) {
    return Container(
      height: MediaQuery.of(context).size.height -
          400 -
          MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          )),
      child: Stack(
        children: <Widget>[
          menu.Presenter(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.only(top: 10),
              view: menu.AngkutView(),
              width: MediaQuery.of(context).size.width,
              heigth: MediaQuery.of(context).size.height - 430,
              menus: menuItems),
        ],
      ),
    );
  }

  @override
  Widget rankingAnimation({
    @required double width,
    @required double value,
    String animation1 = "assets/flares/empty_score1.flr",
    String animation2 = "assets/flares/empty_score2.flr",
    String animation3 = "assets/flares/empty_score3.flr",
    String moveAnimationName = "move",
    String stayAnimationName = "stay",
  }) {
    return Center(
      child: GestureDetector(
        onTap: onTapScore,
        child: Container(
          width: width,
          height: 100,
          // color: Colors.green,
          child: Container(
            child: FlareActor(
              animationScoreAssets ??
                  "assets/flares/angkut/angkut_car_score.flr",
              animation: value < 50
                  ? "score1"
                  : value < 65
                      ? "score2"
                      : "score3",
              alignment: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget logo() {
    return SafeArea(
      child: Container(
        height: 50,
        // color: Colors.red,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 20),
                child: SvgPicture.asset(
                  logoAssets ?? "assets/angkut/logo_angkut_horizontal.svg",
                  width: 100,
                ),
              ),
            ),
            Consumer<InternalDataUtil>(
              builder: (ctx, data, child) {
                return Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 60,
                    width: 60,
                    child: GestureDetector(
                      onTap: () {
                        if (System.data
                                .getLocal<LocalData>()
                                .user
                                .isReadyToWork ==
                            false) {
                          showConfirmToWork();
                        } else {
                          showConfirmToRest();
                        }
                      },
                      child: FlareActor(
                        "assets/flares/angkut/switch.flr",
                        animation:
                            "${System.data.getLocal<LocalData>().user.isReadyToWork ? "on" : "off"}",
                        fit: BoxFit.fitWidth,
                        sizeFromArtboard: false,
                        controller: controls,
                      ),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: onTapNotification,
                      child: Container(
                        margin: EdgeInsets.only(top: 8),
                        height: 35,
                        width: 35,
                        child: FlareActor(
                          animationNotificationAssets ??
                              "assets/flares/angkut/angkut_icon_notification.flr",
                          animation: "stop",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0, left: 10),
                      height: 25,
                      width: 25,
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeRegular(FontAwesomeId.fa_cog),
                            size: 20,
                            color: Colors.white,
                          ),
                          onPressed: onTapSetting,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget profileLabel() {
    return Container(
      height: 40,
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${super.profile.name}",
            style: System.data.textStyleUtil.mainLabel(
              color: System.data.colorUtil.yellowColor,
              fontSize: System.data.fontUtil.s,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${System.data.resource.driver}",
            style: System.data.textStyleUtil.mainLabel(
              color: System.data.colorUtil.lightTextColor,
              fontSize: System.data.fontUtil.s,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<MenuModel> menuItems() {
    return <MenuModel>[
      MenuModel(
          textMenu: "${System.data.resource.map}",
          immageAssetUrl: "assets/angkut/angkut_icon_menu_map.svg",
          onTap: () {
            currentShipment(
              callback: onTapLiveMap,
            );
          },
          icon: FontAwesomeRegular(FontAwesomeId.fa_list)),
      MenuModel(
          textMenu: "${System.data.resource.tripReport}",
          onTap: () {
            currentShipment(
              callback: onTapEmergency,
            );
          },
          immageAssetUrl: "assets/angkut/icon_trip_report.svg",
          icon: FontAwesomeRegular(FontAwesomeId.fa_money_check_alt),
          iconMargin: EdgeInsets.only(right: 5)),
      MenuModel(
          textMenu: "${System.data.resource.allowance}",
          immageAssetUrl: "assets/angkut/angkut_icon_menu_allowance.svg",
          onTap: onTapUangJalan,
          icon: FontAwesomeRegular(FontAwesomeId.fa_shipping_fast)),
      MenuModel(
          textMenu: "${System.data.resource.history}",
          immageAssetUrl: "assets/angkut/angkut_icon_menu_history.svg",
          onTap: () {
            onTapHistory();
          },
          icon: FontAwesomeRegular(FontAwesomeId.fa_plus)),
    ];
  }

  void modalEmergency() {
    ModalComponent.bottomModalWithCorner(context,
        child: Container(
          height: 234,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: SvgPicture.asset(
                              "assets/angkut/anglut_avatar_police.svg"),
                        ),
                      ),
                      Text(
                        "${System.data.resource.callPolice}",
                        style: System.data.textStyleUtil.linkLabel(),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                color: Colors.red,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          loadingController.stopLoading(
                              messageAlign: Alignment.topCenter,
                              isError: false,
                              duration: Duration(seconds: 5),
                              messageWidget:
                                  DecorationComponent.topMessageDecoration(
                                backgroundColor:
                                    System.data.colorUtil.greenColor,
                                message:
                                    System.data.resource.yourReportHasBeenSend,
                              ));
                        },
                        child: Container(
                          color: System.data.colorUtil.primaryColor,
                          height: double.infinity,
                          child: Center(
                            child: Text(
                              "${System.data.resource.yes}",
                              style: System.data.textStyleUtil.mainTitle(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          currentShipment(
                            callback: onTapEmergency,
                          );
                        },
                        child: Container(
                          color: System.data.colorUtil.disableColor,
                          height: double.infinity,
                          child: Center(
                            child: Text(
                              "${System.data.resource.no}",
                              style: System.data.textStyleUtil.mainTitle(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void showConfirmToWork() {
    ModalComponent.bottomModalWithCorner(
      context,
      child: Container(
        height: 234,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 130,
              width: 130,
              child: SvgPicture.asset("assets/angkut/icon_confirm_to_work.svg"),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                "${System.data.resource.areYouReadyToWork}",
                style: System.data.textStyleUtil.linkLabel(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 45,
              decoration: BoxDecoration(
                  border: Border.all(
                color: System.data.colorUtil.primaryColor,
                width: 1,
              )),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: BottonComponent.roundedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          checkAbsteins().then((value) {
                            if (value == true) {
                              setToWork();
                            } else if (value == false) {
                              showInputdailyAbsent();
                            }
                          }).catchError((onError) {
                            loadingController.stopLoading(
                              messageAlign: Alignment.topCenter,
                              messageWidget:
                                  DecorationComponent.topMessageDecoration(
                                message:
                                    ErrorHandlingUtil.handleApiError(onError),
                              ),
                            );
                          });
                        },
                        colorBackground: System.data.colorUtil.primaryColor,
                        radius: 0,
                        text: System.data.resource.yes,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: BottonComponent.roundedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          colorBackground: Colors.white,
                          text: System.data.resource.no,
                          textstyle: System.data.textStyleUtil.mainTitle(
                            color: System.data.colorUtil.primaryColor,
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showConfirmToRest() {
    ModalComponent.bottomModalWithCorner(
      context,
      height: 266,
      child: Container(
        height: 250,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 140,
              width: 130,
              child: SvgPicture.asset("assets/angkut/angkut_rest.svg"),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                "${System.data.resource.byTurningOffThisFeatureYouCannotReceiveOrders}",
                textAlign: TextAlign.center,
                style: System.data.textStyleUtil.linkLabel(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 45,
              decoration: BoxDecoration(
                  border: Border.all(
                color: System.data.colorUtil.primaryColor,
                width: 1,
              )),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: BottonComponent.roundedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          setToRest();
                        },
                        colorBackground: System.data.colorUtil.primaryColor,
                        radius: 0,
                        text: System.data.resource.yes,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: BottonComponent.roundedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          colorBackground: Colors.white,
                          text: System.data.resource.no,
                          textstyle: System.data.textStyleUtil.mainTitle(
                            color: System.data.colorUtil.primaryColor,
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showInputdailyAbsent() {
    ModalComponent.bottomModalWithCorner(
      context,
      isDismissible: true,
      height: MediaQuery.of(context).size.height - 150,
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              height: MediaQuery.of(context).size.height - 167,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  ValueListenableBuilder<AbsentModel>(
                    valueListenable: absentController,
                    builder: (ctx, data, child) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 65),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${System.data.resource.pleaseCheckYourVehicleCondition}",
                                      style:
                                          System.data.textStyleUtil.linkLabel(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 30,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                  "${System.data.resource.fuelIsSufficient}"),
                                            ),
                                          ),
                                          Checkbox(
                                            value: data.fuelLevel,
                                            onChanged:
                                                absentController.setFuelStatus,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                  "${System.data.resource.engineTemperatureIsRoadworthy}"),
                                            ),
                                          ),
                                          Checkbox(
                                            value: data.engineTemperature,
                                            onChanged: absentController
                                                .setEngineTemperatureStatus,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                  "${System.data.resource.oilInGoodCondition}"),
                                            ),
                                          ),
                                          Checkbox(
                                            value: data.oilLevel,
                                            onChanged:
                                                absentController.oilStatus,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                  "${System.data.resource.batteriesInGoodCondition}"),
                                            ),
                                          ),
                                          Checkbox(
                                            value: data.batteraiStatus,
                                            onChanged:
                                                absentController.batterayStatus,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        "${System.data.resource.takeYourSelfieAndDashBoardPhoto}",
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 200,
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: SingleChildScrollView(
                                  child: MultipleImagePickerComponent(
                                    galery: false,
                                    controller:
                                        data.multipleImagePickerController,
                                  ),
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Checkbox(
                                        value: data.confirm,
                                        onChanged:
                                            absentController.confirmStatus),
                                    Container(
                                        width: 200,
                                        child: Text(
                                            "${System.data.resource.iAmResponsibleForTheCorrectnessOfTheDataAbove}")),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      height: 45,
                      child: BottonComponent.roundedButton(
                        onPressed: send,
                        colorBackground: System.data.colorUtil.primaryColor,
                        text: System.data.resource.send,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 170,
              child: DecorationComponent.circularLOadingIndicator(
                  margin: EdgeInsets.only(bottom: 130),
                  controller: absentLoadingController),
            )
          ],
        ),
      ),
    );
  }
}
