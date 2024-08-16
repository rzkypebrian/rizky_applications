import 'package:enerren/app/tms/aDriver/localData.dart';
import 'package:enerren/app/tms/aDriver/module/dashboard/driverPresenter.dart';
import 'package:enerren/component/BottonComponent.dart';
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
import 'package:flutter_svg/svg.dart';
import 'package:enerren/app/tms/module/dashboard/tmsView.dart';
import 'package:provider/provider.dart';

class DriverView<T> extends TmsView with DriverPresenter {
  final VoidCallback history;
  final ValueChanged<List<TmsShipmentModel<T>>> liveMap;
  final VoidCallback setting;
  final VoidCallback score;
  final VoidCallback contact;
  final ValueChanged<List<TmsShipmentModel<T>>> emergency;
  final VoidCallback onTapNotification;
  final VoidCallback onTapPendingData;
  final String backgroudPopUpContact;
  final String iconAdminContact;
  final String iconTransporterContact;
  final String iconPhone;
  final String iconMessage;
  final VoidCallback gotoAttendance;

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
    this.backgroudPopUpContact,
    this.iconAdminContact,
    this.iconTransporterContact,
    this.iconPhone,
    this.iconMessage,
    this.gotoAttendance,
  });

  @override
  Widget extraButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Consumer<InternalDataUtil>(
          builder: (c, d, h) {
            return Container(
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
                    checkAttendance().then((value) {
                      if (value == true) {
                        setToActive();
                      } else if (value == false) {
                        showInputAbsent();
                      }
                    });
                    //setToActive();
                    //showInputAbsent();
                  } else {
                    setToRest();
                  }
                },
                child: Stack(
                  children: <Widget>[
                    FlareActor(
                      "assets/flares/switch.flr",
                      animation:
                          "${System.data.getLocal<LocalData>().user.isReadyToWork ? "on" : "off"}",
                      fit: BoxFit.fitWidth,
                      sizeFromArtboard: false,
                      // controller: controls,
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
                ),
              ),
            );
          },
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
                child: SvgPicture.asset("assets/tms/icon_setting.svg"),
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
          immageAssetUrl: "assets/tms/icon_notification.svg",
          onTap: onTapNotification,
          icon: FontAwesomeRegular(FontAwesomeId.fa_plus)),
      MenuModel(
          textMenu: "${System.data.resource.history}",
          immageAssetUrl: "assets/tms/icon_riwayat.svg",
          onTap: history,
          icon: FontAwesomeRegular(FontAwesomeId.fa_list)),
      MenuModel(
          textMenu: "${System.data.resource.map}",
          immageAssetUrl: "assets/tms/icon_map.svg",
          onTap: () {
            currentShipment(callback: (shipment) {
              liveMap(shipment);
            });
          },
          icon: FontAwesomeRegular(FontAwesomeId.fa_shipping_fast)),
      MenuModel(
          textMenu: "${System.data.resource.emergency}",
          immageAssetUrl: "assets/tms/icon_emergency.svg",
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
        immageAssetUrl: "assets/tms/icon_contact.svg",
        iconHeight: 30,
        iconWidht: 30,
        onTap: showModalCantact,
        icon: FontAwesomeRegular(FontAwesomeId.fa_box_check),
        iconMargin: EdgeInsets.only(right: 0),
      ),
      MenuModel(
          textMenu: "${System.data.resource.pendingPod}",
          immageAssetUrl: "assets/tms/pending_pod.svg",
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
    int lowScore = 50,
    int midleScore = 70,
    int hightScore = 80,
  }) {
    return GestureDetector(
      onTap: score,
      child: super.ranking(
        animation1: "assets/flares/tms/troli_score_3.flr",
        animation2: "assets/flares/tms/troli_score_2.flr",
        animation3: "assets/flares/tms/troli_score_1.flr",
        width: width,
        value: System.data.getLocal<LocalData>().user.score,
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
                  image: AssetImage("assets/tms/popup_background.png"),
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
                      child: SvgPicture.asset(iconAdminContact ??
                          "assets/tms/icon_contact_admin.svg"),
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
                              child: SvgPicture.asset(
                                  iconPhone ?? "assets/tms/phone.svg"),
                            ),
                            shadow: [
                              BoxShadow(
                                color: System.data.colorUtil.shadowColor
                                    .withOpacity(0.2),
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
                              child: SvgPicture.asset(
                                  iconMessage ?? "assets/tms/comment.svg"),
                            ),
                            shadow: [
                              BoxShadow(
                                color: System.data.colorUtil.shadowColor
                                    .withOpacity(0.2),
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
                      child: SvgPicture.asset(iconTransporterContact ??
                          "assets/tms/icon_contact_transporter.svg"),
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
                              child: SvgPicture.asset(
                                  iconPhone ?? "assets/tms/phone.svg"),
                            ),
                            shadow: [
                              BoxShadow(
                                color: System.data.colorUtil.shadowColor
                                    .withOpacity(0.2),
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
                              child: SvgPicture.asset(
                                  iconMessage ?? "assets/tms/comment.svg"),
                            ),
                            shadow: [
                              BoxShadow(
                                color: System.data.colorUtil.shadowColor
                                    .withOpacity(0.2),
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

  showInputAbsent() {
    ModalComponent.bottomModalWithCorner(context,
        isDismissible: true,
        height: MediaQuery.of(context).size.height - 365,
        child: GestureDetector(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                padding: EdgeInsets.only(left: 20, right: 20),
                height: MediaQuery.of(context).size.height - 391,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SvgPicture.asset("assets/absensiPicture.svg"),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      child: Center(
                        child: Text(
                          "${System.data.resource.attendance}",
                          style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.color009789,
                              fontSize: System.data.fontUtil.xl),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text(
                          "${System.data.resource.pleaseFillYourAttendanceDataFirst}!",
                          style: System.data.textStyleUtil
                              .mainLabel(fontSize: System.data.fontUtil.l),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 17),
                            child: BottonComponent.roundedButton(
                              height: 48,
                              width: 98,
                              onPressed: () {
                                Navigator.of(context).pop();
                                gotoAttendance();
                              },
                              colorBackground:
                                  System.data.colorUtil.primaryColor,
                              text: System.data.resource.yes,
                            ),
                          ),
                          Container(
                            child: BottonComponent.roundedButton(
                              height: 48,
                              width: 98,
                              onPressed: Navigator.of(context).pop,
                              colorBackground: Colors.white,
                              border: Border.all(
                                  color: System.data.colorUtil.primaryColor),
                              text: System.data.resource.cancel,
                              textColor: System.data.colorUtil.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
