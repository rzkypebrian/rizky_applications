import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/GeolocatorUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'InputComponent.dart';

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
        flareAnimation: "loading2",
        flareAssets: lightMode == true
            ? "assets/flares/tms/tms_circular_indicator_white.flr"
            : "assets/flares/tms/tms_circular_indicator_blue.flr",
        height: 50,
        textStyleError: System.data.textStyleUtil.mainLabel(
          color: System.data.colorUtil.lightTextColor,
        ),
      ),
    );
  }

  static Widget containerWithDecoration({
    Widget child,
    String image1 = "",
    String image2 = "",
    String image3 = "",
    String image4 = "",
  }) {
    return Container(
      decoration: backgroundDecoration(),
      child: Stack(
        children: <Widget>[
          image3.isNotEmpty
              ? Align(
                  alignment: Alignment.bottomLeft,
                  child: SvgPicture.asset("$image3"))
              : Container(
                  height: 0,
                  width: 0,
                ),
          image4.isNotEmpty
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset("$image4"))
              : Container(
                  height: 0,
                  width: 0,
                ),
          image1.isNotEmpty
              ? Align(
                  alignment: Alignment.topLeft,
                  child: SvgPicture.asset("$image1"))
              : Container(
                  height: 0,
                  width: 0,
                ),
          image2.isNotEmpty
              ? Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: SvgPicture.asset(
                      "$image2",
                    ),
                  ),
                )
              : Container(
                  height: 0,
                  width: 0,
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
      margin: EdgeInsets.only(
        top: 7,
        bottom: 7,
      ),
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
        ),
        child: Stack(
          children: <Widget>[
            // Align(
            //   alignment: Alignment.bottomLeft,
            //   child: Container(
            //     child: SvgPicture.asset(
            //       "assets/left_aksen.svg",
            //       color: System.data.colorUtil.primaryColor,
            //     ),
            //   ),
            // ),
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
  }) {
    return CircularProgressIndicatorComponent(
      width: 50,
      controller: controller,
      flareAssets: "assets/flares/tms/loading_tms.flr",
      flareAnimation: "play",
      margin: EdgeInsets.only(
        bottom: 30,
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

  static Widget shipmentContents<T>({
    TmsShipmentModel<T> data,
    ValueChanged<TmsShipmentModel<T>> onTap,
    Widget subTitle,
    bool withHeader = true,
    bool showTrailing = true,
    EdgeInsets margin,
    EdgeInsets padding,
  }) {
    return GestureDetector(
      onTap: () {
        onTap(data);
      },
      child: Container(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 90,
                height: double.infinity,
                color: System.data.colorUtil.backgroundListItemColor,
                child: Center(
                  child: Container(
                    height: 65,
                    width: 65,
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: System.data.colorUtil.scaffoldBgColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: Image.network(data.iconUrl),
                          ),
                        ),
                        data.tmsShipmentDestinationList
                                    .where((e) => e.emergencyData.length > 0)
                                    .toList()
                                    .length >
                                0
                            ? Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  child: SvgPicture.asset(
                                    "assets/icon_emergency_on.svg",
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            : SizedBox()
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      withHeader
                          ? Container(
                              padding: EdgeInsets.only(
                                  bottom: 5, left: 5, right: 5, top: 5),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    toBeginningOfSentenceCase(
                                        "${data.shipmentNumber}"),
                                    style: System.data.textStyleUtil.mainLabel(
                                        fontSize: System.data.fontUtil.xsPlus),
                                  ),
                                  Text(
                                      "${DateFormat("EEEE," + System.data.resource.dateFormat, System.data.resource.dateLocalFormat).format(data.shipmentDate)}",
                                      style: System.data.textStyleUtil
                                          .mainLabel(
                                              fontSize:
                                                  System.data.fontUtil.xsPlus)),
                                ],
                              ),
                            )
                          : Container(
                              height: 0,
                              width: 0,
                            ),
                      Expanded(
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 5, top: 10, right: 5, bottom: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        toBeginningOfSentenceCase(
                                            "${data.customerName}"),
                                        style: System.data.textStyleUtil
                                            .mainLabel(),
                                      ),
                                      Text(
                                        toBeginningOfSentenceCase(
                                            "${data.shipmentTypeName}"),
                                        style: System.data.textStyleUtil
                                            .mainLabel(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                width: 40,
                                child: data.tmsShipmentDestinationList !=
                                            null &&
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
                                                  color: System.data.colorUtil
                                                      .primaryColor,
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
                                                FontAwesomeLight(FontAwesomeId
                                                    .fa_chevron_right),
                                                size: 15,
                                                color: System.data.colorUtil
                                                    .primaryColor),
                                          )
                                    : Container(
                                        height: 0,
                                        width: 0,
                                      ),
                              )
                            ],
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
      ),
    );
  }

  static Widget futureBuilderAdress({
    @required double lat,
    @required double lon,
  }) {
    return FutureBuilder(
      future: GeolocatorUtil.getAddress(lat, lon),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Text(
          "${(snapshot.data as String).substring(0, (snapshot.data as String).length > 100 ? 100 : (snapshot.data as String).length)} ${(snapshot.data as String).length > 100 ? ". . ." : ""}",
          // overflow: TextOverflow.ellipsis,
          style: System.data.textStyleUtil
              .mainLabel(fontSize: System.data.fontUtil.s),
        );
      },
      initialData: "${System.data.resource.loading}...",
    );
  }

  static Widget serachHistoryDecoration({
    @required InputComponentTextEditingController controller,
    ValueChanged<String> onChange,
    Color colorBackground = Colors.white,
    EdgeInsets padding,
    EdgeInsets margin,
  }) {
    return Container(
      color: colorBackground,
      child: Container(
        color: colorBackground,
        padding: padding ??
            EdgeInsets.only(
              left: 15,
              right: 15,
            ),
        margin: margin ??
            EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
        width: double.infinity,
        child: InputComponent.inputTextWithCorner(
          backgroundColor: Colors.white,
          borderInputGray: Colors.grey.shade400,
          controller: controller,
          onChanged: onChange,
          maxLines: 1,
          hintText: System.data.resource.search,
          contentPadding: EdgeInsets.only(
            top: 2,
            bottom: 2,
            left: 15,
            right: 15,
          ),
          corner: 15,
        ),
      ),
    );
  }
}
