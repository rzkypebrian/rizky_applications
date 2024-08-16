import 'package:enerren/app/sierad/aTransporter/localData.dart';
import 'package:enerren/app/sierad/aTransporter/module/dashboard/transporterPresenter.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/externalLinkComponent.dart';
import 'package:enerren/component/menuComponent.dart';
import 'package:enerren/model/menuModel.dart';
import 'package:component_icons/font_awesome.dart';
import 'package:enerren/model/profileModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:enerren/app/sierad/module/menu/main.dart' as menu;

import 'package:enerren/app/sierad/module/dashboard/SieradView.dart';
import 'package:enerren/util/StringExtention.dart';
import 'package:provider/provider.dart';
import 'viewModel.dart';

class TransporterView extends SieradView with TransporterPresenter {
  final VoidCallback onSetting;
  final VoidCallback onHistory;
  final VoidCallback onContactService;
  final VoidCallback onNotification;
  final ValueChanged<int> onTapRankSummary;
  final VoidCallback onTaplistVehicle;
  final VoidCallback onTapMap;
  final String orderIcon;
  final String siagaIcon;
  final String istirahatIcon;
  final EdgeInsets paddingSiagaValue;
  final EdgeInsets paddingOrderValue;
  final EdgeInsets paddingIstirahatValue;
  final Alignment alignValue;
  final Color colorValue;

  @override
  void initState() {
    super.initState();
  }

  void initData() {
    super.profile = new ProfileModel(
      name: System.data.getLocal<LocalData>().user.transporterName ?? "",
      email: System.data.getLocal<LocalData>().user.transporterEmail ?? "",
      phone: System.data.getLocal<LocalData>().user.transporterMobile ?? "",
      urlImmage: System.data.getLocal<LocalData>().user.imageUrl.isNullOrEmpty()
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

  TransporterView({
    this.onSetting,
    this.onHistory,
    this.onContactService,
    this.onNotification,
    this.onTapRankSummary,
    this.onTaplistVehicle,
    this.onTapMap,
    this.orderIcon,
    this.siagaIcon,
    this.istirahatIcon,
    this.paddingSiagaValue,
    this.alignValue,
    this.paddingOrderValue,
    this.paddingIstirahatValue,
    this.colorValue,
  });

  @override
  Widget extraButton() {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: onNotification,
          child: Container(
            margin: EdgeInsets.only(right: 15, top: 0),
            padding: EdgeInsets.only(top: 20),
            height: 50,
            width: 25,
            child: SvgPicture.asset("assets/sierad/icon_notification.svg"),
          ),
        ),
        GestureDetector(
          onTap: onSetting,
          child: Container(
            margin: EdgeInsets.only(right: 15, top: 0),
            padding: EdgeInsets.only(top: 20),
            height: 50,
            width: 25,
            child: SvgPicture.asset("assets/sierad/icon_setting.svg"),
          ),
        ),
      ],
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
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => super.model,
      child: Consumer<ViewModel>(
        builder: (ctx, data, child) {
          return Container(
            height: 150,
            width: double.infinity,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                eggItem(
                    icon: orderIcon ?? "assets/sierad/icon_egg_order.svg",
                    paddingValue:
                        paddingOrderValue ?? EdgeInsets.only(left: 20, top: 32),
                    paddingLabel: EdgeInsets.only(left: 15),
                    label: "${System.data.resource.order}",
                    value: model.vehicleStatusSummary.order),
                eggItem(
                    icon: siagaIcon ?? "assets/sierad/icon_egg_ready.svg",
                    paddingValue:
                        paddingSiagaValue ?? EdgeInsets.only(left: 3, top: 32),
                    paddingLabel: EdgeInsets.only(left: 5),
                    label: "${System.data.resource.standBy}",
                    value: model.vehicleStatusSummary.standby),
                eggItem(
                    icon: istirahatIcon ?? "assets/sierad/icon_egg_rest.svg",
                    paddingValue: paddingIstirahatValue ??
                        EdgeInsets.only(left: 8, top: 32),
                    paddingLabel: EdgeInsets.only(left: 5),
                    label: "${System.data.resource.rest}",
                    iconHeight: 90,
                    value: model.vehicleStatusSummary.rest),
              ],
            ),
          );
        },
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
    EdgeInsetsGeometry paddingLabel,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 80,
        height: 120,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SvgPicture.asset(
                  "${icon ?? "assets/icon_egg_process.svg"}",
                  height: iconHeight ?? 80,
                ),
              ),
            ),
            Align(
              alignment: alignValue ?? Alignment.center,
              child: Padding(
                padding:
                    paddingValue ?? const EdgeInsets.only(top: 16, left: 1),
                child: Text(
                  "${value != null ? value > 99 ? "99+" : value : "0"}",
                  style: System.data.textStyleUtil.mainLabel(
                    color: colorValue ?? Colors.red,
                    fontSize: System.data.fontUtil.xl,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: paddingLabel ?? EdgeInsets.all(0),
                child: Text(
                  "$label",
                  style: System.data.textStyleUtil.mainLabel(),
                ),
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
          textMenu: "${System.data.resource.history}",
          immageAssetUrl: "assets/sierad/icon_riwayat.svg",
          onTap: onHistory,
          icon: FontAwesomeRegular(FontAwesomeId.fa_list)),
      MenuModel(
          textMenu: "${System.data.resource.list}",
          immageAssetUrl: "assets/sierad/icon_list.svg",
          onTap: onTaplistVehicle,
          icon: FontAwesomeRegular(FontAwesomeId.fa_plus)),
      MenuModel(
          textMenu: "${System.data.resource.contact}",
          iconHeight: 30,
          immageAssetUrl: "assets/sierad/icon_contact.svg",
          onTap: openPopupContact,
          icon: FontAwesomeRegular(FontAwesomeId.fa_shipping_fast)),
      MenuModel(
          textMenu: "${System.data.resource.map}",
          iconHeight: 30,
          immageAssetUrl: "assets/sierad/icon_map.svg",
          onTap: onTapMap,
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
              System.data.colorUtil.primaryColor2,
              System.data.colorUtil.primaryColor,
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          )),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: SvgPicture.asset(
                super.image1 ?? "assets/sierad/transporter_egg_3.svg"),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(
                super.image2 ?? "assets/sierad/transporter_egg_4.svg"),
          ),
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
                textMenu: "${System.data.resource.call}",
                backgroundColor: Colors.white,
                colorIcon: Colors.red,
                neonStyle: false,
                menu: Center(
                  child: SvgPicture.asset("assets/sierad/phone.svg"),
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
              textMenu: "${System.data.resource.chat}",
              backgroundColor: Colors.white,
              colorIcon: Colors.red,
              neonStyle: false,
              menu: Center(
                child: SvgPicture.asset("assets/sierad/comment.svg"),
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
}
