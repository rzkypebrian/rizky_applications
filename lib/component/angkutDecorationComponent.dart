import 'package:component_icons/font_awesome.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/ratingComponent.dart';
import 'package:enerren/util/FontUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'BottonComponent.dart';

class DecorationComponent {
  ///
  ///design background untuk halaman check user, login dsb
  ///
  static Decoration backGroundDecoration1({
    Color color1,
    Color color2,
  }) {
    return BoxDecoration(
        gradient: LinearGradient(
      colors: <Color>[
        color1 ?? Color(0xff00549E),
        color2 ?? Color(0xff008AF6),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ));
  }

  ///
  ///design background untuk botton dengan decoration
  ///
  static Decoration buttonDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xff008AF6),
            Color(0xff00CDE8),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ));
  }

  static Widget logo({
    Color backgroundColor = Colors.transparent,
    Color logoColor = Colors.white,
    Color waterMarkColor = const Color(
      0xff0375D5,
    ),
    bool logo = true,
    bool waterMaerk = true,
  }) {
    return Container(
      color: backgroundColor,
      child: Stack(
        children: <Widget>[
          waterMaerk == true
              ? SvgPicture.asset(
                  "assets/angkut/backgroud_logo_angkut.svg",
                  color: waterMarkColor,
                  height: double.infinity,
                  width: double.infinity,
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
          logo == true
              ? SvgPicture.asset(
                  System.data.global.companyVerticalLogoAssets ??
                      "assets/angkut/logo_angkut_transparent.svg",
                  color: logoColor,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                )
              : Container(
                  width: 0,
                  height: 0,
                ),
        ],
      ),
    );
  }

  static Widget circularLOadingIndicator({
    @required CircularProgressIndicatorController controller,
    bool lightMode = true,
    EdgeInsetsGeometry margin,
    AlignmentGeometry aligment = Alignment.bottomCenter,
    bool coverScreen,
  }) {
    return Container(
      child: CircularProgressIndicatorComponent(
        aligment: aligment,
        margin: margin ?? EdgeInsets.only(bottom: 40),
        coverScreen: coverScreen,
        controller: controller,
        flareAnimation:
            System.data.global.circularProgressIndicatorAnimation ?? "loading2",
        flareAssets: lightMode == true
            ? System.data.global.circularProgressIndicatorAnimatorLightAssets ??
                "assets/flares/angkut/angkut_circular_indicator_white.flr"
            : System.data.global.circularProgressIndicatorAnimatorAssets ??
                "assets/flares/angkut/angkut_circular_indicator_blue.flr",
        height: 50,
        textStyleError: System.data.textStyleUtil.mainLabel(
          color: System.data.colorUtil.lightTextColor,
        ),
      ),
    );
  }

  //
  //background dengan radial digradient dibagian atas
  //
  static Decoration backGroundDecoration2() {
    return BoxDecoration(
      color: System.data.colorUtil.backgrondColor,
      gradient: new RadialGradient(
        colors: [
          System.data.colorUtil.primaryColor,
          System.data.colorUtil.backgrondColor,
        ],
        center: Alignment(-0.0, -0.65),
        radius: 0.5,
        tileMode: TileMode.clamp,
      ),
    );
  }

  //
  //message top
  //
  static Widget topMessageDecoration({
    Color backgroundColor = Colors.red,
    String message,
    TextStyle messageStyle,
    Widget child,
  }) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 50,
      width: double.infinity,
      color: backgroundColor,
      child: child ??
          Center(
            child: Text(
              "$message",
              style: messageStyle ??
                  System.data.textStyleUtil.mainLabel(
                    color: System.data.colorUtil.lightTextColor,
                  ),
            ),
          ),
    );
  }

  //
  //message top
  //
  static Widget modalMessageDecoration({
    @required CircularProgressIndicatorController loadingController,
    String message,
    TextStyle messageStyle,
    Widget child,
  }) {
    return Container(
      color: Colors.grey.withOpacity(0.3),
      height: MediaQuery.of(loadingController.value.context).size.height,
      width: MediaQuery.of(loadingController.value.context).size.width,
      child: Center(
        child: Container(
            height: MediaQuery.of(loadingController.value.context).size.height *
                70 /
                100,
            width: MediaQuery.of(loadingController.value.context).size.width *
                90 /
                100,
            child: child ??
                Text(
                  message,
                  style: messageStyle ?? System.data.textStyleUtil.mainLabel(),
                )),
      ),
    );
  }

  static Widget listTileDecoretion({
    Widget widget,
    double height = 118,
    double radius = 0,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 7, bottom: 7, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Container(
        height: height,
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/angkut/bg_white.png",
                      ),
                      repeat: ImageRepeat.repeatY),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                color: Colors.transparent,
                height: double.infinity,
                child: SvgPicture.asset(
                  "assets/angkut/bg_node_gray.svg",
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Center(
                child: widget,
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget wizardBar({
    Color routeColor,
    Color serviceColor,
    Color confirmationColor,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      height: 31,
      color: System.data.colorUtil.secondaryColor,
      padding: EdgeInsets.only(left: 23, right: 23),
      child: Row(
        children: <Widget>[
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset("assets/angkut/route_blue.svg"),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "${toBeginningOfSentenceCase(System.data.resource.route)}",
                  style: TextStyle(
                    color: routeColor ?? System.data.colorUtil.primaryColor,
                    fontSize: System.data.fontUtil.s,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                color: serviceColor ?? Colors.grey.shade300,
                height: 2,
                margin: EdgeInsets.only(top: 3, left: 3, right: 3),
              ),
            ),
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  "assets/angkut/service_gray.svg",
                  color: serviceColor,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "${toBeginningOfSentenceCase(System.data.resource.service)}",
                  style: TextStyle(
                    color: serviceColor ?? System.data.colorUtil.disableColor,
                    fontSize: System.data.fontUtil.s,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                color: confirmationColor ?? Colors.grey.shade300,
                height: 2,
                margin: EdgeInsets.only(top: 3, left: 3, right: 3),
              ),
            ),
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  "assets/angkut/box_gray.svg",
                  color: confirmationColor,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "${toBeginningOfSentenceCase(System.data.resource.confirmation)}",
                  // "Pesanan",
                  style: TextStyle(
                    color:
                        confirmationColor ?? System.data.colorUtil.disableColor,
                    fontSize: System.data.fontUtil.s,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //component list vehicle
  static Widget vehicleItem({
    String regNumber = "X-Reg number-X",
    String vehicleType = "X-Pick Up Box-X",
    String vehicleNumber = "X-B 6745 TB-X",
    Color colorCircular = Colors.orange,
    String imageIconUrl = "",
    DateTime regDate,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      height: 113,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: System.data.colorUtil.lightTextColor,
        boxShadow: [
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 85,
            decoration: BoxDecoration(
                // color: Colors.blue,
                borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(15),
              bottomLeft: const Radius.circular(15),
            )),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: SvgPicture.asset(
                      "assets/angkut/bgImageVehicle.svg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: System.data.colorUtil.lightTextColor,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        height: 30,
                        width: 30,
                        child: SvgPicture.network("$imageIconUrl"),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-1.15, -1.15),
                  child: circularIcon(primaryColor: colorCircular),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
                child: Stack(
              children: <Widget>[
                Align(
                  child: Container(
                    child: SvgPicture.asset(
                      "assets/angkut/bgscafold.svg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "No_Reg  $regNumber",
                                  style: System.data.textStyleUtil.mainLabel(
                                    color: System.data.colorUtil.primaryColor,
                                    fontSize: System.data.fontUtil.s,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  DateFormat(System.data.resource.dateFormat,
                                          System.data.resource.locale)
                                      .format(regDate),
                                  style: System.data.textStyleUtil.mainLabel(
                                    color: System.data.colorUtil.primaryColor,
                                    fontSize: System.data.fontUtil.s,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Divider(
                            color: Colors.blue[600],
                            // thickness: 1.0,
                            // indent: 110,
                            // endIndent: 10,
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        "$vehicleType",
                                        style:
                                            System.data.textStyleUtil.mainLabel(
                                          color: System
                                              .data.colorUtil.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "$vehicleNumber", //untuk get data dari data dummy
                                  style: System.data.textStyleUtil.mainLabel(
                                    color: System.data.colorUtil.primaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          )
        ],
      ),
    );
  }

  static Widget circularIcon({
    Color primaryColor = Colors.red,
    Color secondaryColor = Colors.white,
  }) {
    return Container(
      width: 23,
      height: 23,
      decoration: BoxDecoration(
        color: secondaryColor,
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: secondaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget driverItem({
    String noReg = "3178876658",
    String driverName = "Mardigu",
    String driverSim = "SIM A",
    String vehicleNumber = "B XXXX ZZ",
    double driverRate,
    Color colorCircular = Colors.red,
    DateTime regDate,
    String imageUrl,
    bool withStatusColor = true,
    Widget rightContent,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      height: 113,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: System.data.colorUtil.lightTextColor,
        boxShadow: [
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 85,
            decoration: BoxDecoration(
                // color: Colors.blue,
                borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(15),
              bottomLeft: const Radius.circular(15),
            )),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: SvgPicture.asset(
                      "assets/angkut/bgImageVehicle.svg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: System.data.colorUtil.lightTextColor,
                        width: 2,
                      ),
                      image: new DecorationImage(
                        image: NetworkImage('$imageUrl'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-1.15, -1.15),
                  child: withStatusColor
                      ? circularIcon(primaryColor: colorCircular)
                      : null,
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
                child: Stack(
              children: <Widget>[
                Align(
                  child: Container(
                    child: SvgPicture.asset(
                      "assets/angkut/bgscafold.svg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 120,
                                height: 20,
                                child: RatingComponent(
                                  space: 3,
                                  width: 20,
                                  height: 20,
                                  score: driverRate,
                                  readOnly: true,
                                ),
                              ),
                              Container(
                                child: Text(
                                  // registerDate.toString(),
                                  DateFormat(System.data.resource.dateFormat,
                                          System.data.resource.locale)
                                      .format(regDate),
                                  style: System.data.textStyleUtil.mainLabel(
                                    color: System.data.colorUtil.primaryColor,
                                    fontSize: System.data.fontUtil.s,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Divider(
                            color: Colors.blue[600],
                            // thickness: 1.0,
                            // indent: 110,
                            // endIndent: 10,
                          ),
                        ),
                        Container(
                          // margin: EdgeInsets.only(left: 10, top: 0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Text(
                                        "${driverName ?? ""}",
                                        style:
                                            System.data.textStyleUtil.mainLabel(
                                          color: System
                                              .data.colorUtil.primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "${driverSim ?? "-"}", //untuk get data dari data dummy
                                        style:
                                            System.data.textStyleUtil.mainLabel(
                                          color: System
                                              .data.colorUtil.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              rightContent ??
                                  Container(
                                    alignment: Alignment.topRight,
                                    width: 120,
                                    height: 20,
                                    child: Text(
                                      "$vehicleNumber", //untuk get data dari data dummy
                                      textAlign: TextAlign.right,
                                      style:
                                          System.data.textStyleUtil.mainLabel(
                                        color:
                                            System.data.colorUtil.primaryColor,
                                      ),
                                    ),
                                  )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          )
        ],
      ),
    );
  }

  static Widget saldo({
    double saldo = 620000,
  }) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Stack(
        children: <Widget>[
          SvgPicture.asset(
            "assets/angkut/angkut_saldo.svg",
            width: 450,
          ),
          Container(
            margin: EdgeInsets.all(40),
            padding: EdgeInsets.only(top: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 25),
                    child: Text(
                      "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(saldo)}",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: System.data.fontUtil.xxxl,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
          )
        ],
      ),
    );
  }

  static Widget billingView() {
    String billNumber = "XXXXXX";
    double billSum = 2500000;
    double billPPN = 2500;
    double billAmount = 2502500;
    DateTime dueDate = DateTime.now();
    DateTime paymentDate = DateTime.now();

    return Container(
      child: Column(
        children: <Widget>[
          Container(
              height: 30,
              margin: EdgeInsets.only(top: 15, left: 13),
              child: Row(
                children: <Widget>[
                  Text(
                    "${System.data.resource.billNumber} $billNumber",
                    style: System.data.textStyleUtil.mainLabel(
                        fontSize: System.data.fontUtil.m,
                        color: System.data.colorUtil.blueColor),
                  ),
                ],
              )),
          Container(
              margin: EdgeInsets.only(
                top: 12,
                left: 13,
                right: 13,
              ),
              height: 230,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: System.data.colorUtil.shadowColor.withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Align(
                    child: Container(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 8),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      "${System.data.resource.billSum} ",
                                      style: System.data.textStyleUtil
                                          .mainLabel(
                                              fontSize: System.data.fontUtil.m,
                                              color: System
                                                  .data.colorUtil.blueColor),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 18),
                                    child: Text(
                                      "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(billSum)}",
                                      style: System.data.textStyleUtil
                                          .mainLabel(
                                              color: System
                                                  .data.colorUtil.blackColor,
                                              fontSize: System.data.fontUtil.m),
                                    ),
                                  ),
                                ]),
                          ),
                          Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    //margin: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      "${System.data.resource.billPPN} ",
                                      style: System.data.textStyleUtil
                                          .mainLabel(
                                              color: System
                                                  .data.colorUtil.blueColor,
                                              fontSize: System.data.fontUtil.m),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(billPPN)}",
                                      style: System.data.textStyleUtil
                                          .mainLabel(
                                              color: System
                                                  .data.colorUtil.blackColor,
                                              fontSize: System.data.fontUtil.m),
                                    ),
                                  ),
                                ]),
                          ),
                          Container(
                            child: Divider(
                              color: System.data.colorUtil.borderInputColor,
                              indent: 200,
                              endIndent: 0,
                              thickness: 1.0,
                            ),
                          ),
                          Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      "${System.data.resource.billAmount} ",
                                      style: System.data.textStyleUtil
                                          .mainLabel(
                                              color: System
                                                  .data.colorUtil.blueColor,
                                              fontSize: System.data.fontUtil.m),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(billAmount)}",
                                      style: System.data.textStyleUtil
                                          .mainLabel(
                                              color: System
                                                  .data.colorUtil.errorColor,
                                              fontSize: System.data.fontUtil.m),
                                    ),
                                  ),
                                ]),
                          ),
                          Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      "${System.data.resource.duaDate} ",
                                      style: System.data.textStyleUtil
                                          .mainLabel(
                                              color: System
                                                  .data.colorUtil.blueColor,
                                              fontSize: System.data.fontUtil.m),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      child: Text(
                                        DateFormat(
                                                System.data.resource.dateFormat,
                                                System.data.resource.locale)
                                            .format(dueDate),
                                        style:
                                            System.data.textStyleUtil.mainLabel(
                                          color:
                                              System.data.colorUtil.blackColor,
                                          fontSize: System.data.fontUtil.m,
                                        ),
                                      )),
                                ]),
                          ),
                          Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      "${System.data.resource.paymentDate} ",
                                      style:
                                          System.data.textStyleUtil.mainLabel(
                                        color: System.data.colorUtil.blueColor,
                                        fontSize: System.data.fontUtil.m,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      child: Text(
                                        DateFormat(
                                                System.data.resource.dateFormat,
                                                System.data.resource.locale)
                                            .format(paymentDate),
                                        style:
                                            System.data.textStyleUtil.mainLabel(
                                          color:
                                              System.data.colorUtil.blackColor,
                                          fontSize: System.data.fontUtil.m,
                                        ),
                                      )),
                                ]),
                          ),
                          Container(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    child: SvgPicture.asset(
                                      "assets/angkut/notpayed.svg",
                                      width: 126,
                                      height: 40,
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  static Widget detailShipment({
    Widget icon,
    String name,
    String address,
    String detailAddress = "",
    String poinName,
    String phone,
    bool next = false,
    bool guarent = false,
    Widget rightWidget,
    BuildContext context,
    VoidCallback onTapNoteForDriver,
    bool showLinkToPickup = false,
    VoidCallback onTapLinkToPickup,
    bool showLinkToPod = false,
    VoidCallback onTapLinkToPod,
    bool showContactPerson = true,
    bool showStatusInCharge = true,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 30, margin: EdgeInsets.only(right: 5), child: icon),
                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "$poinName",
                          style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.primaryColor,
                              fontFamily: System.data.fontUtil.primary),
                        ),
                      ),
                      rightWidget ??
                          Container(
                            width: 0,
                            height: 0,
                          )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 30,
                    height: 70,
                    margin: EdgeInsets.only(right: 5),
                    child: next
                        ? Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topCenter,
                                child: Icon(
                                  FontAwesomeLight(FontAwesomeId.fa_ellipsis_v),
                                  color: System.data.colorUtil.primaryColor,
                                  size: 40,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Icon(
                                  FontAwesomeLight(FontAwesomeId.fa_ellipsis_v),
                                  color: System.data.colorUtil.primaryColor,
                                  size: 40,
                                ),
                              ),
                            ],
                          )
                        : Container()),
                Expanded(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            address,
                            style: System.data.textStyleUtil.mainLabel(
                                color: System.data.colorUtil.darkTextColor,
                                fontFamily: System.data.fontUtil.primary),
                          ),
                        ),
                        detailAddress.isNotEmpty &&
                                detailAddress != null &&
                                detailAddress != "null"
                            ? Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  detailAddress,
                                  style: System.data.textStyleUtil.mainLabel(
                                      color:
                                          System.data.colorUtil.darkTextColor,
                                      fontFamily: System.data.fontUtil.primary),
                                ),
                              )
                            : SizedBox(),
                        //link to pickup
                        showLinkToPickup
                            ? Container(
                                padding: EdgeInsets.only(
                                  bottom: 3,
                                  top: 3,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        onTapLinkToPickup();
                                      },
                                      child: Text(
                                        "${System.data.resource.loadingDetail}",
                                        style: System.data.textStyleUtil
                                            .linkLabel(),
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      color: System.data.colorUtil.primaryColor,
                                    )
                                  ],
                                ),
                              )
                            : SizedBox(),
                        //link to pod
                        showLinkToPod
                            ? Container(
                                padding: EdgeInsets.only(
                                  bottom: 3,
                                  top: 3,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        onTapLinkToPod();
                                      },
                                      child: Text(
                                        "${System.data.resource.unloadingDetail}",
                                        style: System.data.textStyleUtil
                                            .linkLabel(),
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      color: System.data.colorUtil.primaryColor,
                                    )
                                  ],
                                ),
                              )
                            : SizedBox(),
                        //link to note for driver
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 10,
                          ),
                          padding: EdgeInsets.only(
                            bottom: 3,
                            top: 3,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                style: BorderStyle.solid,
                                color: Colors.grey,
                              ),
                              bottom: BorderSide(
                                style: BorderStyle.solid,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  onTapNoteForDriver();
                                },
                                child: Text(
                                  "${System.data.resource.note}",
                                  style: System.data.textStyleUtil.linkLabel(),
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: System.data.colorUtil.primaryColor,
                              )
                            ],
                          ),
                        ),
                        showContactPerson
                            ? Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: Icon(
                                            FontAwesomeLight(
                                              FontAwesomeId.fa_user,
                                            ),
                                            color: System
                                                .data.colorUtil.primaryColor,
                                          ),
                                        ),
                                        Text("$name")
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          child: SvgPicture.asset(
                                              "assets/angkut/phone.svg"),
                                        ),
                                        Text("$phone")
                                      ],
                                    )
                                  ],
                                ),
                              )
                            : SizedBox(),
                        showStatusInCharge
                            ? guarent
                                ? Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                        "${System.data.resource.personInChargeOfPayment}",
                                        style: System.data.textStyleUtil
                                            .mainLabel(
                                                color:
                                                    System.data.colorUtil
                                                        .primaryColor,
                                                fontFamily: System
                                                    .data.fontUtil.primary)),
                                  )
                                : Container()
                            : SizedBox()
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget detailShipmentIncomePayment(
      {Widget icon,
      String address,
      String poinName,
      bool next = false,
      String dateTime,
      BuildContext context}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 30, margin: EdgeInsets.only(right: 5), child: icon),
                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "$poinName",
                          style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.primaryColor,
                              fontFamily: System.data.fontUtil.primary),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 30,
                    height: 70,
                    margin: EdgeInsets.only(right: 5),
                    child: next
                        ? Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topCenter,
                                child: Icon(
                                  FontAwesomeLight(FontAwesomeId.fa_ellipsis_v),
                                  color: System.data.colorUtil.primaryColor,
                                  size: 40,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Icon(
                                  FontAwesomeLight(FontAwesomeId.fa_ellipsis_v),
                                  color: System.data.colorUtil.primaryColor,
                                  size: 40,
                                ),
                              ),
                            ],
                          )
                        : Container()),
                Expanded(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            address,
                            style: System.data.textStyleUtil.mainLabel(
                                color: System.data.colorUtil.darkTextColor,
                                fontFamily: System.data.fontUtil.primary),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[Text("$dateTime")],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  static logOutPopUpDecoration({
    @required BuildContext context,
    @required VoidCallback logout,
  }) {
    ModalComponent.bottomModalWithCorner(
      context,
      height: 256,
      child: Container(
        height: 240,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 150,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/angkut/angkut_bg_exit.svg",
                  ),
                  Text(
                    System.data.resource.areYouSureToExit,
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.primaryColor,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 40,
                    child: BottonComponent.roundedButton(
                        radius: 0,
                        colorBackground: System.data.colorUtil.primaryColor,
                        text: System.data.resource.yes,
                        onPressed: () {
                          logout();
                        }),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    child: BottonComponent.roundedButton(
                        radius: 0,
                        colorBackground: System.data.colorUtil.secondaryColor,
                        border: Border.all(
                            color: System.data.colorUtil.primaryColor),
                        text: System.data.resource.no,
                        textColor: System.data.colorUtil.primaryColor,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  static Widget listShipmentContent({
    AngkutShipmentModel data,
    ValueChanged<AngkutShipmentModel> onTap,
    double height = 130,
    bool showPaymentStatus = false,
    bool showShipmentNumber = true,
    bool showPrice = true,
    bool showExtraPeople = false,
  }) {
    return GestureDetector(
      onTap: () {
        onTap(data);
      },
      child: Container(
        child: Stack(
          children: <Widget>[
            listTileDecoretion(
              height: data.isInstant ? height : (height + 10),
              widget: Stack(
                children: <Widget>[
                  Container(
                    // color: Colors.red,
                    padding: EdgeInsets.only(left: 25, right: 25, top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: System.data.colorUtil.primaryColor,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                showShipmentNumber == true
                                    ? SelectableText(
                                        toBeginningOfSentenceCase(
                                            "${data.shipmentNumber}"),
                                        style: System.data.textStyleUtil
                                            .mainLabel(
                                                color: System.data.colorUtil
                                                    .primaryColor,
                                                fontFamily: FontUtil().primary),
                                      )
                                    : Container(
                                        padding: EdgeInsets.only(
                                            bottom: 2,
                                            right: 10,
                                            left: 10,
                                            top: 2),
                                        decoration: BoxDecoration(
                                          color: System
                                              .data.colorUtil.primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Text(
                                          System.data.resource.newOrder,
                                          style: System.data.textStyleUtil
                                              .mainLabel(
                                            color: System
                                                .data.colorUtil.lightTextColor,
                                          ),
                                        ),
                                      ),
                                Text(
                                  "${DateFormat('EEEE, yyyy-MM-dd').format(data.shipmentDate)}",
                                  style: System.data.textStyleUtil.mainLabel(
                                    color: System.data.colorUtil.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 20,
                                alignment: Alignment.centerLeft,
                                child: SvgPicture.asset(
                                  "assets/angkut/box_solid.svg",
                                ),
                              ),
                              Text(
                                toBeginningOfSentenceCase(
                                    "${data.deliveryDescription}"),
                                style: System.data.textStyleUtil.mainLabel(
                                    color: System.data.colorUtil.primaryColor),
                              ),
                              Expanded(
                                  child: Container(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${data.tmsShipmentDestinationList.first.driverName ?? ""}",
                                      style:
                                          System.data.textStyleUtil.linkLabel(
                                        fontSize: System.data.fontUtil.m,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                        FontAwesomeRegular(
                                          FontAwesomeId.fa_steering_wheel,
                                        ),
                                        size: 12,
                                        color:
                                            System.data.colorUtil.primaryColor),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 20,
                                alignment: Alignment.centerLeft,
                                child: SvgPicture.asset(
                                  "assets/angkut/icon_delivery.svg",
                                ),
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      toBeginningOfSentenceCase(
                                        "${data.isInstant ? System.data.resource.instantCourier : System.data.resource.scheduled}",
                                      ),
                                      style: System.data.textStyleUtil
                                          .mainLabel(
                                              color: System
                                                  .data.colorUtil.primaryColor),
                                    ),
                                    data.isInstant
                                        ? SizedBox()
                                        : SizedBox(
                                            height: 5,
                                          ),
                                    data.isInstant
                                        ? SizedBox()
                                        : Text(
                                            toBeginningOfSentenceCase(
                                              "${data.isInstant ? System.data.resource.instantCourier : (data.scheduledDate == null ? "" : DateFormat("dd MMMM yyyy HH:mm", System.data.resource.dateLocalFormat).format(data.scheduledDate))}",
                                            ),
                                            style: System.data.textStyleUtil
                                                .mainLabel(
                                              color: System
                                                  .data.colorUtil.darkTextColor,
                                              fontSize: System.data.fontUtil.s,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              data.tmsShipmentDestinationList.length > 1
                                  ? Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        width: 100,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${data.tmsShipmentDestinationList.length} ${System.data.resource.destination}",
                                              style: System.data.textStyleUtil
                                                  .linkLabel(
                                                      fontSize: System
                                                          .data.fontUtil.m),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              FontAwesomeRegular(
                                                  FontAwesomeId.fa_route),
                                              color: System
                                                  .data.colorUtil.primaryColor,
                                              size: 12,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                        showPrice
                            ? Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 20,
                                      alignment: Alignment.centerLeft,
                                      child: SvgPicture.asset(
                                        "assets/angkut/price.svg",
                                      ),
                                    ),
                                    Text(
                                      "Rp ${NumberFormat("#,##0", System.data.resource.locale).format(data.totalPrice)}",
                                      style: System.data.textStyleUtil
                                          .mainLabel(
                                              color: System
                                                  .data.colorUtil.redColor,
                                              fontSize: FontUtil().l),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        showExtraPeople
                            ? Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 20,
                                      alignment: Alignment.centerLeft,
                                      child: SvgPicture.asset(
                                        "assets/angkut/man.svg",
                                        height: 13,
                                      ),
                                    ),
                                    Text(
                                      "${data.extraHelperCount} ${System.data.resource.person}",
                                      style: System.data.textStyleUtil
                                          .mainLabel(
                                              color: System
                                                  .data.colorUtil.primaryColor,
                                              fontSize: System.data.fontUtil.l),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  showPaymentStatus == true && showPrice == true
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: paidStatus(
                            data.shipmentInvoice.paidStatus,
                          ),
                        )
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                ],
              ),
            ),
            data.shipmentStatusId == 13
                ? Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 10,
                        top: 0,
                      ),
                      height: 25,
                      width: 25,
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/angkut/icon_emergency.svg",
                          color: System.data.colorUtil.orangeColor,
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 0,
                    width: 0,
                  ),
          ],
        ),
      ),
    );
  }

  static Widget paidStatus(
    int status, {
    EdgeInsetsGeometry margin,
  }) {
    return Container(
      width: 100,
      height: 30,
      margin: margin ?? EdgeInsets.only(right: 20, bottom: 10),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "assets/angkut/notpayed.svg",
              color: status != null && status == 2
                  ? System.data.colorUtil.primaryColor
                  : Colors.red,
              fit: BoxFit.fitWidth,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "${status != null && status == 2 ? System.data.resource.payed : status != null && status == 3 ? System.data.resource.pending : System.data.resource.notPayed}",
              textAlign: TextAlign.center,
              style: System.data.textStyleUtil.mainLabel(
                color: status != null && status == 2
                    ? System.data.colorUtil.primaryColor
                    : Colors.red,
                fontSize: System.data.fontUtil.xsPlus,
              ),
            ),
          )
        ],
      ),
    );
  }

  static Future<void> detailNote(
    BuildContext context, {
    String noteForDriver,
  }) {
    return ModalComponent.bottomModalWithCorner(
      context,
      height: MediaQuery.of(context).size.height / 2,
      child: Container(
        height: (MediaQuery.of(context).size.height / 2) - 20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 30,
              child: Row(
                children: [
                  Container(
                    child: SvgPicture.asset("assets/angkut/pencil.svg"),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "${System.data.resource.note}",
                    style: System.data.textStyleUtil.linkLabel(
                      fontSize: System.data.fontUtil.l,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  noteForDriver ?? "-",
                  style: System.data.textStyleUtil.mainLabel(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
