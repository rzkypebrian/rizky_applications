import 'package:enerren/app/sierad/aCustomer/localData.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/externalLinkComponent.dart';
import 'package:enerren/component/menuComponent.dart';
import 'package:enerren/model/menuModel.dart';
import 'package:enerren/model/profileModel.dart';
import 'package:component_icons/font_awesome.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:enerren/app/sierad/module/menu/main.dart' as menu;

import 'package:enerren/app/sierad/module/dashboard/SieradView.dart';
import 'customerPresenter.dart';

class CustomerView extends SieradView with CustomerPresenter {
  VoidCallback onSetting;
  VoidCallback onHistory;
  VoidCallback onContactService;
  VoidCallback onNotification;
  ValueChanged<int> onTapRankSummary;
  Color buttonBackgroundColor;
  Color buttonIconColor;

  @override
  void initState() {
    super.initState();
  }

  void initData() {
    super.profile = new ProfileModel(
      name: System.data.getLocal<LocalData>().user.customerName ?? "",
      email: System.data.getLocal<LocalData>().user.customerEmail ?? "",
      phone: System.data.getLocal<LocalData>().user.customerMobile ?? "",
      urlImmage: System.data.getLocal<LocalData>().user.imageUrl == null
          ? profile.urlImmage
          : System.data.getLocal<LocalData>().user.imageUrl,
      // urlImmage: null,
      registeredDate:
          System.data.getLocal<LocalData>().user.registeredDate ?? null,
    );
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return super.build(context);
  }

  CustomerView({
    this.onSetting,
    this.onHistory,
    this.onContactService,
    this.onNotification,
    this.onTapRankSummary,
    this.buttonBackgroundColor,
    this.buttonIconColor,
  });

  @override
  Widget extraButton() {
    return GestureDetector(
      onTap: onSetting,
      child: Container(
        margin: EdgeInsets.only(right: 15, top: 0),
        padding: EdgeInsets.only(top: 20),
        height: 50,
        width: 25,
        child: SvgPicture.asset("assets/sierad/icon_setting.svg"),
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
    return Container(
      height: 150,
      width: double.infinity,
      margin: EdgeInsets.only(left: 50, right: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          eggItem(
              label: System.data.resource.process,
              value: System.data
                  .getLocal<LocalData>()
                  .shipmentCountSummary
                  .process,
              onTap: () {
                onTapRankSummary(0);
              }),
          // eggItem(
          //     width: 70,
          //     icon: "assets/sierad/icon_egg_shipped.svg",
          //     paddingValue: EdgeInsets.only(top: 18, left: 10),
          //     label: System.data.resource.shipped,
          //     value: System.data
          //         .getLocal<LocalData>()
          //         .shipmentCountSummary
          //         .shipped,
          //     onTap: () {
          //       onTapRankSummary(1);
          //     }),
          eggItem(
              iconHeight: 75,
              icon: "assets/sierad/icon_egg_finish.svg",
              paddingValue: EdgeInsets.only(top: 18, left: 1),
              label: System.data.resource.finish,
              value:
                  System.data.getLocal<LocalData>().shipmentCountSummary.finish,
              onTap: () {
                onTapRankSummary(2);
              }),
          eggItem(
              label: System.data.resource.cancel,
              paddingValue: EdgeInsets.only(top: 20, left: 1),
              icon: "assets/sierad/icon_egg_canceled.svg",
              value:
                  System.data.getLocal<LocalData>().shipmentCountSummary.cancel,
              onTap: () {
                onTapRankSummary(3);
              }),
        ],
      ),
    );
  }

  Widget eggItem({
    String icon,
    EdgeInsetsGeometry paddingValue,
    String label,
    double width,
    double iconHeight,
    int value,
    VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 60,
        height: 100,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SvgPicture.asset(
                  "${icon ?? "assets/sierad/icon_egg_process.svg"}",
                  height: iconHeight ?? 60,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding:
                    paddingValue ?? const EdgeInsets.only(top: 16, left: 1),
                child: Text(
                  "${value != null ? value > 100 ? "99+" : value : "0"}",
                  style: System.data.textStyleUtil.mainLabel(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "$label",
                style: System.data.textStyleUtil.mainLabel(),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<MenuModel> menuItems() {
    return <MenuModel>[
      MenuModel(
          textMenu: "${System.data.resource.notification}",
          immageAssetUrl: "assets/sierad/icon_notification.svg",
          onTap: onNotification,
          icon: FontAwesomeRegular(FontAwesomeId.fa_plus)),
      MenuModel(
          textMenu: "${System.data.resource.history}",
          immageAssetUrl: "assets/sierad/icon_riwayat.svg",
          onTap: onHistory,
          icon: FontAwesomeRegular(FontAwesomeId.fa_list)),
      MenuModel(
          textMenu: "${System.data.resource.contact}",
          iconHeight: 30,
          immageAssetUrl: "assets/sierad/icon_contact.svg",
          onTap: openPopupContact,
          icon: FontAwesomeRegular(FontAwesomeId.fa_shipping_fast)),
    ];
  }

  @override
  Widget mainBody({
    List<MenuModel> Function() menus,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height -
          350 -
          MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            // stops: [0.9, 0.2],
            // stops: [0.7,0.5],
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xffFFD281),
              System.data.colorUtil.primaryColor2,
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          )),
      child: Stack(
        children: <Widget>[
          contureBottomBackground(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 8),
              child: SvgPicture.asset(
                "assets/poweredby_tms.svg",
                color: Colors.white,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height -
                390 -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                   BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(55),
                  topRight: Radius.circular(55),
                  bottomLeft: Radius.elliptical(300, 120),
                  bottomRight: Radius.elliptical(300, 120),
                )),
          ),
          menu.Presenter(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.only(top: 10),
              view: menu.SieradView(),
              width: MediaQuery.of(context).size.width,
              heigth: MediaQuery.of(context).size.height - 430,
              menus: menuItems),
        ],
      ),
    );
  }

  void openPopupContact() {
    ModalComponent.bottomModalWithCorner(
      context,
      height: 120,
      child: Container(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MenuComponent.circleMenu(
                sizeMenuButton: 60,
                size: 60,
                textMenuSpace: 0,
                textMenu: "", //"${System.data.resource.call}",
                backgroundColor: buttonBackgroundColor ?? Colors.white,
                colorIcon: Colors.red,
                neonStyle: false,
                borderColor: buttonBackgroundColor ?? Colors.white,
                menu: Center(
                  child: SvgPicture.asset(
                    "assets/sierad/phone.svg",
                    color: buttonIconColor,
                  ),
                ),
                shadow: [
                   BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
                ],
                onTap: () {
                  ExternalLinkComponent.openPhone(
                      System.data.getLocal<LocalData>().user.adminPhoneNumber);
                }),
            SizedBox(
              width: 50,
            ),
            MenuComponent.circleMenu(
              sizeMenuButton: 60,
              size: 60,
              textMenuSpace: 100,
              // textMenu: "${System.data.resource.chat}",
              backgroundColor: buttonBackgroundColor ?? Colors.white,
              colorIcon: Colors.red,
              neonStyle: false,
              borderColor: buttonBackgroundColor ?? Colors.white,
              menu: Center(
                child: SvgPicture.asset(
                  "assets/sierad/comment.svg",
                  color: buttonIconColor,
                ),
              ),
              shadow: [
                 BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
              ],
              onTap: () {
                ExternalLinkComponent.openWA(
                    System.data.getLocal<LocalData>().user.adminWhatsAppNumber);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget contureBottomBackground() {
    return Container(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: SvgPicture.asset("assets/sierad/customer_egg_3.svg"),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset("assets/sierad/customer_egg_4.svg"),
          ),
        ],
      ),
    );
  }
}
