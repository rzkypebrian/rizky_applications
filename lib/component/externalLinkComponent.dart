import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ExternalLinkComponent {
  static Widget mapPhoneWA({
    double lat,
    double lon,
    String phoneNumber,
    ValueChanged2Param<double, double> onTapMap,
    bool showMapLink = true,
    MainAxisAlignment mainAxisAlignment,
  }) {
    return Container(
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        children: <Widget>[
          showMapLink
              ? GestureDetector(
                  onTap: () {
                    if (onTapMap != null) {
                      onTapMap(lat, lon);
                    } else {
                      openGooleMap(
                        lat: lat,
                        lon: lon,
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    child: SvgPicture.asset(
                      "assets/sample/icon_arrow_up.svg",
                      color: System.data.colorUtil.primaryColor,
                    ),
                  ),
                )
              : Container(
                  width: 0,
                  height: 0,
                ),
          GestureDetector(
            onTap: () => launch("tel:$phoneNumber"),
            child: Container(
              height: 20,
              width: 20,
              margin: EdgeInsets.only(right: 10),
              child: SvgPicture.asset(
                "assets/sample/phone.svg",
                color: System.data.colorUtil.primaryColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => launch('https://wa.me/$phoneNumber'),
            child: Container(
              child: SvgPicture.asset(
                "assets/sample/comment.svg",
                color: System.data.colorUtil.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> openGooleMap({
    double lat,
    double lon,
  }) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void openPhone(String phoneNumber) {
    launch("tel:$phoneNumber");
  }

  static void openWA(String phoneNumber) {
    launch('https://wa.me/$phoneNumber');
  }

  static void openEmail(String emailAddress) {
    launch("mailto:$emailAddress");
  }

  static Future<void> openUrl({String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
