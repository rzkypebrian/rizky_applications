import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/listDataComponent.dart';
import 'package:enerren/model/tmsVehicleCheckDocument.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar(), body: body());
  }

  Widget body() {
    return ListDataComponent<TmsVehicleCheckDocument>(
      controller: absentListController,
      getNewData: getNew,
      getOldData: getOld,
      itemBuilder: (data, index) {
        return content(data);
      },
      loadingWidgetBuilder: (controller) {
        return DecorationComponent.circularLOadingIndicator(
          controller: controller,
        );
      },
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      context: context,
      actionText: "",
      backButtonColor: System.data.colorUtil.lightTextColor,
      backgroundColor: System.data.colorUtil.primaryColor,
      title: System.data.resource.absenteeism,
      titleStyle: System.data.textStyleUtil.mainTitle(
        color: System.data.colorUtil.lightTextColor,
      ),
    );
  }

  Widget content(TmsVehicleCheckDocument data) {
    return GestureDetector(
      onTap: () => onTapAbsent(data),
      child: Container(
        height: 115,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xff008AF6),
              Color(0xff00CDE8),
            ],
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset("assets/angkut/bgAbsen.svg"),
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                              "assets/angkut/bgTransporter.svg"),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                   BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
                                ],
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: System.data.colorUtil.lightTextColor,
                                  width: 2,
                                ),
                                image: DecorationImage(
                                    alignment: Alignment.center,
                                    image: NetworkImage(
                                        "${data.driverImageUrl}"))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(
                        left: 10, right: 10, bottom: 17, top: 17),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text(
                                toBeginningOfSentenceCase(
                                    "${data.driverRegNumber}"),
                                style: System.data.textStyleUtil.mainLabel(
                                    fontSize: System.data.fontUtil.s,
                                    color:
                                        System.data.colorUtil.lightTextColor),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                toBeginningOfSentenceCase(
                                    "${DateFormat('yyyy-MM-dd').format(data.checkTime)}"),
                                style: System.data.textStyleUtil.mainLabel(
                                    fontSize: System.data.fontUtil.s,
                                    color:
                                        System.data.colorUtil.lightTextColor),
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: System.data.colorUtil.lightTextColor,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  toBeginningOfSentenceCase(
                                      "${data.driverName}"),
                                  style: System.data.textStyleUtil.mainLabel(
                                      fontWeight: FontWeight.bold,
                                      fontSize: System.data.fontUtil.m,
                                      color:
                                          System.data.colorUtil.lightTextColor),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  toBeginningOfSentenceCase(
                                      "${data.vehicleName}"),
                                  style: System.data.textStyleUtil.mainLabel(
                                      fontWeight: FontWeight.bold,
                                      fontSize: System.data.fontUtil.m,
                                      color:
                                          System.data.colorUtil.lightTextColor),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  toBeginningOfSentenceCase(
                                      "${data.driverSimType}"),
                                  style: System.data.textStyleUtil.mainLabel(
                                      fontWeight: FontWeight.bold,
                                      fontSize: System.data.fontUtil.m,
                                      color:
                                          System.data.colorUtil.lightTextColor),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  toBeginningOfSentenceCase(
                                      "${data.vehicleNumber}"),
                                  style: System.data.textStyleUtil.mainLabel(
                                      fontWeight: FontWeight.bold,
                                      fontSize: System.data.fontUtil.m,
                                      color:
                                          System.data.colorUtil.lightTextColor),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
