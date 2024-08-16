import 'package:enerren/component/listComponent.dart';
import 'package:enerren/component/ratingComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DriverInfoDecoration {
  static Widget popupMapDriverInfo({
    String driverImageUrl,
    String driverName,
    String nik,
    String phoneNumber,
    String email,
    DateTime birdDate,
    String address,
    Widget topRightWidget,
  }) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: topRightWidget,
                ),
                Center(
                  child: Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: System.data.colorUtil.primaryColor,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      image: DecorationImage(
                        image: NetworkImage("$driverImageUrl"),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Text(
            "$driverName",
            style: System.data.textStyleUtil.mainTitle(
              color: System.data.colorUtil.primaryColor,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          RatingComponent(
            controller: new RatingController(),
            score: 4,
          ),
          SizedBox(
            height: 15,
          ),
          titleValueListItem(
            title: "${System.data.resource.nik}",
            value: "$nik",
          ),
          Divider(
            height: 15,
            color: System.data.colorUtil.greyColor,
          ),
          titleValueListItem(
            title: "${System.data.resource.phoneNumber}",
            value: "$phoneNumber",
          ),
          Divider(
            height: 15,
            color: System.data.colorUtil.greyColor,
          ),
          titleValueListItem(
            title: "${System.data.resource.email}",
            value: "$email",
          ),
          Divider(
            height: 15,
            color: System.data.colorUtil.greyColor,
          ),
          titleValueListItem(
            title: "${System.data.resource.birthday}",
            value:
                "${DateFormat('dd MMMM yyyy', System.data.resource.locale).format(birdDate)}",
          ),
          Divider(
            height: 15,
            color: System.data.colorUtil.greyColor,
          ),
          titleValueListItem(
            title: "${System.data.resource.address}",
            value: "$address",
          ),
          Divider(
            height: 15,
            color: System.data.colorUtil.greyColor,
          )
        ],
      ),
    );
  }
}
