import 'package:enerren/app/sierad/aDriver/localData.dart';
import 'package:enerren/app/sierad/aDriver/module/dashboard/driverPresenter.dart';
import 'package:enerren/app/sierad/model/SieradShipmentDetailHatcheryModel.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/externalLinkComponent.dart';
import 'package:enerren/component/menuComponent.dart';
import 'package:enerren/model/menuModel.dart';
import 'package:enerren/model/profileModel.dart';
import 'package:component_icons/font_awesome.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/InternalDataUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:enerren/app/sierad/module/dashboard/sieradView.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DriverView extends SieradView with DriverPresenter {
  final VoidCallback history;
  final ValueChanged<List<TmsShipmentModel<SieradShipmentDetailHatcheryModel>>>
      liveMap;
  final VoidCallback setting;
  final VoidCallback score;
  final VoidCallback contact;
  final ValueChanged<List<TmsShipmentModel<SieradShipmentDetailHatcheryModel>>>
      emergency;
  final VoidCallback onTapNotification;
  final VoidCallback onTapPendingData;
  final String rankingAnimation1;
  final String rankingAnimation2;
  final String rankingAnimation3;
  final String rankingAnimationPlay;
  final String rankingAnimationStop;

  @override
  void initState() {
    super.initState();
  }

  void initData() {
    super.profile = new ProfileModel(
      name: System.data.getLocal<LocalData>().user.driverName ?? "",
      email: System.data.getLocal<LocalData>().user.email ?? "",
      phone: System.data.getLocal<LocalData>().user.phoneNumber ?? "",
      urlImmage: System.data.getLocal<LocalData>().user.urlProfileImage == null
          ? profile.urlImmage
          : System.data.getLocal<LocalData>().user.urlProfileImage,
      registeredDate: System.data.getLocal<LocalData>().user.insertedDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return super.build(context);
  }

  DriverView({
    this.history,
    this.liveMap,
    this.setting,
    this.score,
    this.contact,
    this.emergency,
    this.onTapNotification,
    this.onTapPendingData,
    this.rankingAnimation1,
    this.rankingAnimation2,
    this.rankingAnimation3,
    this.rankingAnimationPlay,
    this.rankingAnimationStop,
  });

  @override
  Widget extraButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 60,
          width: 75,
          margin: EdgeInsets.only(
            right: 5,
            top: 10,
          ),
          child: GestureDetector(
            onTap: () {
              if (System.data.getLocal<LocalData>().user.isReadyToWork ==
                  false) {
                setToActive();
              } else {
                setToRest();
              }
            },
            child: Consumer<InternalDataUtil>(
              builder: (context, data, child) {
                return Stack(
                  children: <Widget>[
                    Center(
                      child: FlareActor(
                        "assets/flares/switch.flr",
                        animation:
                            "${System.data.getLocal<LocalData>().user.isReadyToWork ? "on" : "off"}",
                        fit: BoxFit.fitWidth,
                        sizeFromArtboard: false,
                        // controller: controls,
                      ),
                    ),
                    Align(
                      alignment:
                          System.data.getLocal<LocalData>().user.isReadyToWork
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          "${System.data.getLocal<LocalData>().user.isReadyToWork ? System.data.resource.active : System.data.resource.rest}",
                          style: TextStyle(
                              fontSize: System.data.fontUtil.xsPlus - 1),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
        Container(
          height: 60,
          width: 30,
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.only(top: 8, right: 5, bottom: 0, left: 3),
          child: Center(
            child: GestureDetector(
              onTap: setting,
              child: Container(
                child: SvgPicture.asset("assets/sierad/icon_setting.svg"),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  List<MenuModel> menuItems() {
    return <MenuModel>[
      MenuModel(
          textMenu: "${System.data.resource.notification}",
          immageAssetUrl: "assets/sierad/icon_notification.svg",
          onTap: onTapNotification,
          icon: FontAwesomeRegular(FontAwesomeId.fa_plus)),
      MenuModel(
          textMenu: "${System.data.resource.history}",
          immageAssetUrl: "assets/sierad/icon_riwayat.svg",
          onTap: history,
          icon: FontAwesomeRegular(FontAwesomeId.fa_list)),
      MenuModel(
          textMenu: "${System.data.resource.map}",
          immageAssetUrl: "assets/sierad/icon_map.svg",
          onTap: () {
            currentShipment(callback: (shipment) {
              liveMap(shipment);
            });
          },
          icon: FontAwesomeRegular(FontAwesomeId.fa_shipping_fast)),
      MenuModel(
          textMenu: "${System.data.resource.emergency}",
          immageAssetUrl: "assets/sierad/icon_emergency.svg",
          onTap: () {
            currentShipment(callback: (shipment) {
              emergency(shipment);
            });
          },
          // onTap: emergency,
          icon: FontAwesomeRegular(FontAwesomeId.fa_money_check_alt),
          iconMargin: EdgeInsets.only(right: 0)),
      MenuModel(
          textMenu: "${System.data.resource.contact}",
          immageAssetUrl: "assets/sierad/icon_contact.svg",
          iconHeight: 30,
          iconWidht: 30,
          onTap: showModalCantact,
          icon: FontAwesomeRegular(FontAwesomeId.fa_box_check),
          iconMargin: EdgeInsets.only(right: 0)),
      MenuModel(
          textMenu: "${System.data.resource.pendingPod}",
          immageAssetUrl: "assets/sierad/pending_pod.svg",
          onTap: onTapPendingData,
          iconHeight: 30,
          icon: FontAwesomeRegular(FontAwesomeId.fa_calculator_alt),
          iconMargin: EdgeInsets.only(top: 2)),
    ];
  }

  @override
  Widget ranking({
    @required double width,
    @required double value,
    String animation1 = "assets/flares/empty_score1.flr",
    String animation2 = "assets/flares/empty_score2.flr",
    String animation3 = "assets/flares/empty_score3.flr",
    String moveAnimationName = "move",
    String stayAnimationName = "stay",
    Color barValueColor,
    Color barBackgroudColor,
    TextStyle valueStyle,
  }) {
    return GestureDetector(
      onTap: score,
      child: super.ranking(
        width: width,
        value: System.data.getLocal<LocalData>().user.score,
        animation1: rankingAnimation1 ?? animation1,
        animation2: rankingAnimation2 ?? animation2,
        animation3: rankingAnimation3 ?? animation3,
        moveAnimationName: rankingAnimationPlay ?? moveAnimationName,
        stayAnimationName: rankingAnimationStop ?? stayAnimationName,
      ),
    );
  }

  void showModalCantact() {
    ModalComponent.bottomModalWithCorner(context,
        height: 205,
        backgroundWidget: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
              image: DecorationImage(
                  image: AssetImage("assets/sierad/popup_background.png"),
                  alignment: Alignment.topLeft,
                  fit: BoxFit.cover),
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 70,
                      width: 70,
                      child: SvgPicture.asset(
                          "assets/sierad/icon_contact_admin.svg"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${System.data.resource.admin}",
                      style: System.data.textStyleUtil.mainTitle(
                        color: System.data.colorUtil.darkTextColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MenuComponent.circleMenu(
                            sizeMenuButton: 60,
                            size: 50,
                            textMenuSpace: 0,
                            textMenu: "",
                            backgroundColor: Colors.white,
                            colorIcon: Colors.red,
                            neonStyle: false,
                            menu: Center(
                              child:
                                  SvgPicture.asset("assets/sierad/phone.svg"),
                            ),
                            shadow: [
                               BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
                            ],
                            onTap: () {
                              ExternalLinkComponent.openPhone(System.data
                                  .getLocal<LocalData>()
                                  .user
                                  .adminPhoneNumber);
                            }),
                        SizedBox(
                          width: 20,
                        ),
                        MenuComponent.circleMenu(
                            sizeMenuButton: 60,
                            size: 50,
                            textMenuSpace: 0,
                            textMenu: "",
                            backgroundColor: Colors.white,
                            colorIcon: Colors.red,
                            neonStyle: false,
                            menu: Center(
                              child:
                                  SvgPicture.asset("assets/sierad/comment.svg"),
                            ),
                            shadow: [
                               BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
                            ],
                            onTap: () {
                              ExternalLinkComponent.openWA(System.data
                                  .getLocal<LocalData>()
                                  .user
                                  .adminWhatsAppNumber);
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 70,
                      width: 70,
                      child: SvgPicture.asset(
                          "assets/sierad/icon_contact_transporter.svg"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${System.data.resource.transporter}",
                      style: System.data.textStyleUtil.mainTitle(
                        color: System.data.colorUtil.darkTextColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MenuComponent.circleMenu(
                            sizeMenuButton: 60,
                            size: 50,
                            textMenuSpace: 0,
                            textMenu: "",
                            backgroundColor: Colors.white,
                            colorIcon: Colors.red,
                            neonStyle: false,
                            menu: Center(
                              child:
                                  SvgPicture.asset("assets/sierad/phone.svg"),
                            ),
                            shadow: [
                               BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
                            ],
                            onTap: () {
                              ExternalLinkComponent.openPhone(System.data
                                  .getLocal<LocalData>()
                                  .user
                                  .transporterPhoneNumber);
                            }),
                        SizedBox(
                          width: 20,
                        ),
                        MenuComponent.circleMenu(
                            sizeMenuButton: 60,
                            size: 50,
                            textMenuSpace: 0,
                            textMenu: "",
                            backgroundColor: Colors.white,
                            colorIcon: Colors.red,
                            neonStyle: false,
                            menu: Center(
                              child:
                                  SvgPicture.asset("assets/sierad/comment.svg"),
                            ),
                            shadow: [
                               BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
                            ],
                            onTap: () {
                              ExternalLinkComponent.openWA(System.data
                                  .getLocal<LocalData>()
                                  .user
                                  .transporterWhatsAppNumber);
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
