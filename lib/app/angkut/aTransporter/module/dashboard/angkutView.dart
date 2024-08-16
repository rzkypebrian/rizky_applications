import 'package:enerren/app/angkut/aTransporter/localData.dart';
import 'package:provider/provider.dart';
import 'angkutPresenter.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/model/menuModel.dart';
import 'package:enerren/model/profileModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:component_icons/font_awesome.dart';
import 'package:enerren/app/angkut/module/menu/main.dart' as menu;
import 'viewModel.dart';

import 'package:enerren/module/dashboard/view.dart';

class AngkutView extends View with AngkutPresenter {
  final FlareControls controls = FlareControls();
  final VoidCallback onTapAbsent;
  final VoidCallback onTapSetting;
  final VoidCallback onTapHistory;
  final VoidCallback onTapListVehicle;
  final VoidCallback onTapMaps;
  final VoidCallback onTapUangJalan;
  final VoidCallback onTapBill;
  final VoidCallback onTapNotification;
  final ValueChanged<int> onTapVehicleStatus;
  String notificationAnimationAsset;

  AngkutView({
    this.onTapAbsent,
    this.onTapHistory,
    this.onTapSetting,
    this.onTapListVehicle,
    this.onTapMaps,
    this.onTapUangJalan,
    this.onTapBill,
    this.onTapNotification,
    this.onTapVehicleStatus,
    this.notificationAnimationAsset,
  });

  @override
  void initState() {
    super.initState();
  }

  void initData() {
    super.profile = new ProfileModel(
      name: System.data.getLocal<LocalData>().user.transporterName,
      email: System.data.getLocal<LocalData>().user.transporterEmail,
      phone: System.data.getLocal<LocalData>().user.transporterMobile,
      urlImmage: System.data.getLocal<LocalData>().user.imageUrl.isEmpty
          ? "https://i.ibb.co/wCf8Wjf/avatar-angkut.png"
          : System.data.getLocal<LocalData>().user.imageUrl,
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
              ranking(
                  width: 250,
                  value: 70,
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
    return Consumer<ViewModel>(
      builder: (ctx, dt, child) {
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              dashboardItem(
                  title: System.data.resource.order,
                  value: (dt.vehicleStatusSummary.order ?? 0).toString(),
                  onTap: () => onTapVehicleStatus(1)),
              SizedBox(
                width: 20,
              ),
              dashboardItem(
                  title: System.data.resource.standBy,
                  value: (dt.vehicleStatusSummary.standby ?? 0).toString(),
                  onTap: () => onTapVehicleStatus(2)),
              SizedBox(
                width: 20,
              ),
              dashboardItem(
                  title: System.data.resource.rest,
                  value: (dt.vehicleStatusSummary.rest ?? 0).toString(),
                  onTap: () => onTapVehicleStatus(3)),
            ],
          ),
        );
      },
    );
  }

  Widget dashboardItem({
    String title,
    String value,
    VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 85,
        width: 80,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              child: SvgPicture.asset(
                "assets/angkut/container_dashboard_item_transporter.svg",
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 10, right: 5),
                child: Text(
                  "${title ?? ""}",
                  style: System.data.textStyleUtil.mainLabel(
                    color: System.data.colorUtil.lightTextColor,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text(
                  "${value ?? ""}",
                  style: System.data.textStyleUtil.mainTitle(
                    color: System.data.colorUtil.yellowColor,
                    fontSize: System.data.fontUtil.xxl,
                  ),
                ),
              ),
            )
          ],
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
                  "assets/angkut/logo_angkut_horizontal.svg",
                  width: 100,
                ),
              ),
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
                          notificationAnimationAsset ??
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
            "${System.data.resource.transporter}",
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
          onTap: onTapMaps,
          icon: FontAwesomeRegular(FontAwesomeId.fa_list)),
      MenuModel(
          textMenu: "${System.data.resource.absenteeism}",
          immageAssetUrl: "assets/angkut/angkut_icon_menu_absensi.svg",
          onTap: onTapAbsent,
          icon: FontAwesomeRegular(FontAwesomeId.fa_plus)),
      MenuModel(
          textMenu: "${System.data.resource.activity}",
          immageAssetUrl: "assets/angkut/angkut_icon_menu_list.svg",
          onTap: onTapListVehicle,
          icon: FontAwesomeRegular(FontAwesomeId.fa_plus)),
      MenuModel(
          textMenu: "${System.data.resource.orderStatus}",
          immageAssetUrl: "assets/angkut/angkut_icon_menu_history.svg",
          onTap: onTapHistory,
          icon: FontAwesomeRegular(FontAwesomeId.fa_plus)),
      MenuModel(
          textMenu: "${System.data.resource.allowance}",
          immageAssetUrl: "assets/angkut/angkut_icon_menu_allowance.svg",
          onTap: onTapUangJalan,
          icon: FontAwesomeRegular(FontAwesomeId.fa_shipping_fast)),
      MenuModel(
          textMenu: "${System.data.resource.bill}",
          onTap: onTapBill,
          immageAssetUrl: "assets/angkut/angkut_icon_menu_tagihan.svg",
          icon: FontAwesomeRegular(FontAwesomeId.fa_money_check_alt),
          iconMargin: EdgeInsets.only(right: 5)),
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
                        onTap: () {},
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
}
