import 'package:component_icons/font_awesome.dart';
import 'package:enerren/app/sierad/model/SieradShipmentDetailHatcheryModel.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/GeolocatorUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TextStyleUtil.dart';
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

  static Widget containerWithDecoration({
    Widget child,
    String image1 = "assets/sierad/egg_1.svg",
    String image2 = "assets/sierad/egg_2.svg",
    String image3 = "assets/sierad/egg_3.svg",
    String image4 = "assets/sierad/egg_4.svg",
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
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                child: SvgPicture.asset(
                  "assets/left_aksen.svg",
                  color: System.data.colorUtil.primaryColor,
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
    String flareAssets,
    String flareAnimation,
    double width,
  }) {
    return CircularProgressIndicatorComponent(
      width: width ?? 100,
      controller: controller,
      flareAssets: flareAssets ?? "assets/flares/sierad/loading_sierad.flr",
      flareAnimation: flareAnimation ?? "loading2",
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
    TextStyleUtil messageStyle,
    Widget child,
  }) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
      // height: 50,
      width: double.infinity,
      color: backgroundColor,
      child: child ??
          Text(
            "$message",
            style: messageStyle ??
                System.data.textStyleUtil.mainLabel(
                  color: System.data.colorUtil.lightTextColor,
                ),
            textAlign: TextAlign.center,
          ),
    );
  }

  static Widget shipmentContents({
    TmsShipmentModel<SieradShipmentDetailHatcheryModel> data,
    ValueChanged<TmsShipmentModel<SieradShipmentDetailHatcheryModel>> onTap,
    Widget subTitle,
    bool withHeader = true,
    bool showTrailing = true,
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
                        toBeginningOfSentenceCase("${data.shipmentNumber}"),
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
            onTap: () {
              onTap(data);
            },
            contentPadding: EdgeInsets.only(top: 0),
            dense: true,
            leading: Container(
              height: 65,
              width: 55,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: System.data.colorUtil.borderInputColor,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      padding: EdgeInsets.only(top: 5),
                      // child: SvgPicture.asset(imageSvg(status: 1)),
                      child: Center(
                        child: Image.network(
                          "${data.iconUrl}",
                          alignment: Alignment.center,
                        ),
                      ),
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
                              "assets/sierad/icon_emergency.svg",
                              color: Colors.red,
                            ),
                          ),
                        )
                      : SizedBox()
                ],
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
            subtitle: subTitle ??
                Text(
                  "${data.shipmentTypeName}",
                  style: System.data.textStyleUtil
                      .mainLabel(fontSize: System.data.fontUtil.s),
                ),
          )
        ],
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
