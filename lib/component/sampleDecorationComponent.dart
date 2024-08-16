import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class DecorationComponent {
  static Decoration backgroundDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.3, 9],
        colors: [
          System.data.colorUtil.greenColorBackGround,
          System.data.colorUtil.primaryColor,
        ],
      ),
    );
  } //

  static Widget containerWithDecoration({
    Widget child,
    String image1 = "assets/sample/egg_1.svg",
    String image2 = "assets/sample/egg_2.svg",
    String image3 = "assets/sample/egg_3.svg",
    String image4 = "assets/sample/egg_4.svg",
  }) {
    return Container(
      decoration: backgroundDecoration(),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.bottomLeft,
              child: SvgPicture.asset("$image3")),
          Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset("$image4")),
          Align(
              alignment: Alignment.topLeft, child: SvgPicture.asset("$image1")),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: SvgPicture.asset(
                "$image2",
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: child,
          )
        ],
      ),
    );
  } //

  static Widget listTileDecoretion({
    Widget widget,
    double height = 80,
    double radius = 0,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 7, bottom: 7),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          color: System.data.colorUtil.secondaryColor,
          boxShadow: [
            BoxShadow(
              color: System.data.colorUtil.shadowColor.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
          // gradient: LinearGradient(
          //   begin: Alignment.centerLeft,
          //   end: Alignment.topRight,
          //   stops: [.1, .9],
          //   colors: [
          //     SavedDataUtil.data.colors.greenColorBackGround,
          //     SavedDataUtil.data.colors.primaryColor,
          //   ],
          // ),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                child: SvgPicture.asset(
                  "assets/left_aksen.svg",
                  color: System.data.colorUtil.greenColorBackGround,
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

  static Widget circularProgressDecoration({
    CircularProgressIndicatorController controller,
    Alignment aligment,
    bool coverScreen,
    double width,
    String flareAssets,
    String flareAnimation,
  }) {
    return CircularProgressIndicatorComponent(
      width: width ?? 150,
      aligment: aligment ?? Alignment.bottomCenter,
      controller: controller,
      flareAssets: flareAssets ?? "assets/flares/sample/loading_beton.flr",
      flareAnimation: flareAnimation ?? "loading2",
      coverScreen: coverScreen,
      margin: EdgeInsets.only(
        bottom: 50,
      ),
      messageMargin: EdgeInsets.only(
        bottom: 30,
      ),
      textStyleError: System.data.textStyleUtil.mainLabel(
        color: System.data.colorUtil.lightTextColor,
      ),
      backgroundNonerrorColor: System.data.colorUtil.primaryColor,
      textStyleNonError: System.data.textStyleUtil.mainLabel(
        color: System.data.colorUtil.lightTextColor,
      ),
    );
  }

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

  static Widget shipmentContents({
    TmsShipmentModel data,
    bool withHeader,
    bool showTrailing,
    EdgeInsets margin,
    EdgeInsets padding,
  }) {
    return Container(
      margin: margin ?? EdgeInsets.only(left: 15, right: 15),
      padding: padding ?? EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          withHeader
              ? Container(
                  padding: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        toBeginningOfSentenceCase(
                            "No_order ${data.shipmentNumber}"),
                        style: System.data.textStyleUtil.mainLabel(),
                      ),
                      Text(
                          "${DateFormat("EEEE," + System.data.resource.dateFormat, System.data.resource.dateLocalFormat).format(data.shipmentDate)}",
                          style: System.data.textStyleUtil.mainLabel()),
                    ],
                  ),
                )
              : Container(height: 0, width: 0),
          ListTile(
            // onTap: () {
            //   onTap(data);
            // },
            contentPadding: EdgeInsets.only(top: 0),
            dense: true,
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: System.data.colorUtil.borderInputColor,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              padding: EdgeInsets.all(0),
              // child: SvgPicture.asset(imageSvg(status: 1)),
              child: Image.network(
                "${data.iconUrl}",
                alignment: Alignment.center,
              ),
            ),
            trailing: data.tmsShipmentDestinationList != null &&
                    showTrailing == true
                ? data.tmsShipmentDestinationList.length > 1
                    ? Container(
                        height: 40,
                        width: 40,
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            border: Border.all(
                              color: System.data.colorUtil.primaryColor,
                              style: BorderStyle.solid,
                              width: 2,
                            )),
                        child: Center(
                          child: Text(
                              "${data.tmsShipmentDestinationList?.length}"),
                        ),
                      )
                    : Container(
                        height: 40,
                        width: 40,
                        child: Icon(
                            FontAwesomeLight(FontAwesomeId.fa_chevron_right),
                            size: 15,
                            color: System.data.colorUtil.primaryColor),
                      )
                : Container(
                    height: 0,
                    width: 0,
                  ),
            title: Text(
              ("${data.customerName}"),
              style: System.data.textStyleUtil.mainLabel(),
            ),
            subtitle: Text(
              "${data.shipmentTypeName}",
              style: System.data.textStyleUtil
                  .mainLabel(fontSize: System.data.fontUtil.s),
            ),
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
            "assets/saldo.svg",
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
    EdgeInsetsGeometry padding = const EdgeInsets.only(
      left: 15,
      right: 15,
    ),
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 0),
      // padding: padding,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 30,
                  margin: EdgeInsets.only(right: 5),
                  child: icon,
                ),
                Expanded(
                  child: Container(
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
                                              "assets/phone.svg"),
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
                    child: SvgPicture.asset("assets/pencil.svg"),
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
