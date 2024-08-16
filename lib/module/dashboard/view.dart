import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/externalLinkComponent.dart';
import 'package:enerren/component/menuComponent.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'presenter.dart';
import 'package:component_icons/font_awesome.dart';
import '../../module/menu/main.dart' as menu;
import '../../model/menuModel.dart';

class View extends PresenterState {
  Widget header() {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      padding: EdgeInsets.only(top: 5),
      // height: 123,
      child: GestureDetector(
        onTap: () => gotoProfile(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            avatar(),
            SizedBox(
              height: 8,
            ),
            profileLabel(),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget avatar() {
    return Container(
      decoration: BoxDecoration(
          color: System.data.colorUtil.borderInputColor,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: System.data.colorUtil.shadowColor.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ]),
      child: CircleAvatar(
        backgroundImage: NetworkImage("${profile.urlImmage}"),
        backgroundColor: Colors.white30,
        radius: 30,
      ),
    );
  }

  Widget profileLabel() {
    return Text(
      "${profile.name}",
      style: System.data.textStyleUtil.linkLabel(
        fontSize: System.data.fontUtil.xl,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: decoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            top: false,
            bottom: false,
            child: Container(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: components(),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: mainBody(menus: menuItems)),
                  circularProgressIndicatorDecoration(),
                ],
              ),
            )),
      ),
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return CircularProgressIndicatorComponent(
      controller: loadingController,
    );
  }

  List<Widget> components() {
    return <Widget>[
      logo(),
      header(),
      ranking(width: 250, value: 70),
    ];
  }

  Widget mainBody({
    List<MenuModel> Function() menus,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      height: MediaQuery.of(context).size.height - 350,
      child: Stack(
        children: <Widget>[
          menu.Presenter(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.only(top: 10),
              view: menu.View(),
              width: MediaQuery.of(context).size.width,
              heigth: MediaQuery.of(context).size.height - 430,
              menus: menuItems),
        ],
      ),
    );
  }

  Decoration decoration() {
    return BoxDecoration(
      color: Colors.transparent,
    );
  }

  Widget logo() {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          company(),
          extraButton(),
        ],
      ),
    );
  }

  Widget company() {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 15),
      child: SvgPicture.asset(
        "assets/logo_sierad.svg",
        height: 30,
      ),
    );
  }

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
    barValueColor = barValueColor ?? System.data.colorUtil.primaryColor;
    valueStyle = valueStyle ?? System.data.textStyleUtil.mainLabel();
    return Container(
      height: 150,
      child: Column(
        children: <Widget>[
          rankingAnimation(
            value: value,
            width: width,
            animation1: animation1,
            animation2: animation2,
            animation3: animation3,
            moveAnimationName: moveAnimationName,
            stayAnimationName: stayAnimationName,
          ),
          Container(
            width: width,
            height: 9,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: (width * value / 100) + 10.0,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_up, color: Colors.red)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: width,
            height: 8,
            child: Container(
              color: barBackgroudColor,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: (width * value / 100),
                  color: barValueColor,
                ),
              ),
            ),
          ),
          Container(
            width: width,
            margin: EdgeInsets.only(top: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: (width * value / 100) + 10.0,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${value / 10}",
                    style: valueStyle ?? System.data.textStyleUtil.linkLabel(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
      child: Container(
        width: width,
        height: 100,
        // color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              height: value < 50 ? 80 : 60,
              width: value < 50 ? 80 : 60,
              // color: Colors.red,
              child: FlareActor(
                "$animation1",
                animation: "${value < 50 ? "move" : "stay"}",
                controller: flare1,
              ),
            ),
            Container(
              height: value >= 50 && value < 70 ? 80 : 60,
              width: value >= 50 && value < 70 ? 80 : 60,
              // color: Colors.green,
              child: FlareActor(
                "$animation2",
                animation: "${value >= 50 && value < 70 ? "move" : "stay"}",
              ),
            ),
            Container(
              height: value >= 70 ? 80 : 60,
              width: value >= 70 ? 80 : 60,
              // color: Colors.purple,
              child: FlareActor(
                "$animation3",
                animation: "${value >= 70 ? "move" : "stay"}",
              ),
            ),
            // SvgPicture.asset("assets/icon_driver_star_1.svg"),
            // SvgPicture.asset("assets/icon_driver_star_2.svg"),
            // SvgPicture.asset("assets/icon_driver_star_3.svg"),
          ],
        ),
      ),
    );
  }

  Widget extraButton() {
    return Container(
      margin: EdgeInsets.only(right: 15, top: 15),
      height: 30,
      width: 50,
      decoration: BoxDecoration(
          border: Border.all(
            color: System.data.colorUtil.scafoldColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.only(right: 2),
              child: Text(
                "${System.data.resource.lang.toUpperCase()}",
                textAlign: TextAlign.center,
                style: System.data.textStyleUtil.mainLabel(
                  color: System.data.colorUtil.scafoldColor,
                  fontSize: System.data.fontUtil.s,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<MenuModel> menuItems() {
    return <MenuModel>[
      MenuModel(
          textMenu: "menu 1",
          immageAssetUrl: "assets/icon_notification.svg",
          onTap: () => ModeUtil.debugPrint("menu 1 tapped"),
          icon: FontAwesomeRegular(FontAwesomeId.fa_plus)),
      MenuModel(
          textMenu: "menu 2",
          immageAssetUrl: "assets/icon_notification.svg",
          onTap: () => ModeUtil.debugPrint("menu 2 tapped"),
          icon: FontAwesomeRegular(FontAwesomeId.fa_list)),
      MenuModel(
          textMenu: "menu 3",
          immageAssetUrl: "assets/icon_notification.svg",
          onTap: () => ModeUtil.debugPrint("menu 3 tapped"),
          icon: FontAwesomeRegular(FontAwesomeId.fa_shipping_fast)),
      MenuModel(
          textMenu: "menu 4",
          onTap: () => ModeUtil.debugPrint("menu 4 tapped"),
          immageAssetUrl: "assets/icon_notification.svg",
          icon: FontAwesomeRegular(FontAwesomeId.fa_money_check_alt),
          iconMargin: EdgeInsets.only(right: 5)),
      MenuModel(
          textMenu: "menu 5",
          immageAssetUrl: "assets/icon_notification.svg",
          onTap: () => ModeUtil.debugPrint("menu 5 tapped"),
          icon: FontAwesomeRegular(FontAwesomeId.fa_box_check),
          iconMargin: EdgeInsets.only(right: 3)),
      MenuModel(
          textMenu: "menu 6",
          immageAssetUrl: "assets/icon_notification.svg",
          iconHeight: 100,
          iconWidht: 100,
          onTap: () => ModeUtil.debugPrint("menu 6 tapped"),
          icon: FontAwesomeRegular(FontAwesomeId.fa_calculator_alt)),
    ];
  }

  void showModalCantact() {
    ModalComponent.bottomModalWithCorner(context,
        height: 205,
        backgroundWidget: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
              image: widget.showAdminContact == true &&
                      widget.showTransporterContact == true
                  ? DecorationImage(
                      image: AssetImage("assets/popup_background.png"),
                      alignment: Alignment.topLeft,
                      fit: BoxFit.cover)
                  : null,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            widget.showAdminContact == true
                ? Expanded(
                    child: Container(
                      height: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 70,
                            width: 70,
                            child: SvgPicture.asset(
                              widget.iconAdminContact ??
                                  "assets/icon_contact_admin.svg",
                              color: widget.iconAdminContactColor,
                            ),
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
                                      widget.iconPhone ?? "assets/phone.svg",
                                      color: widget.iconPhoneColor,
                                    ),
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
                                    ExternalLinkComponent.openPhone(
                                        widget.adminPhoneNumber);
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
                                      widget.iconMessage ??
                                          "assets/comment.svg",
                                      color: widget.iconMessageColor,
                                    ),
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
                                    ExternalLinkComponent.openWA(
                                        widget.adminWhatsAppNumber);
                                  }),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
            widget.showTransporterContact == true
                ? Expanded(
                    child: Container(
                      height: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 70,
                            width: 70,
                            child: SvgPicture.asset(
                              widget.iconTransporterContact ??
                                  "assets/icon_contact_transporter.svg",
                              color: widget.iconTransporterContactColor,
                            ),
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
                                      widget.iconPhone ?? "assets/phone.svg",
                                      color: widget.iconPhoneColor,
                                    ),
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
                                    ExternalLinkComponent.openPhone(
                                      widget.transporterPhoneNumber,
                                    );
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
                                      widget.iconMessage ??
                                          "assets/comment.svg",
                                      color: widget.iconMessageColor,
                                    ),
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
                                    ExternalLinkComponent.openWA(
                                        widget.transporterWhatsAppNumber);
                                  }),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ));
  }
}
