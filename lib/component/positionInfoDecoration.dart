import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PositionInfoDecoration {
  static Widget summary(VtsPositionModel data) {
    return Container(
      child: Scrollbar(
        child: ListView(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text(
                      "${System.data.resource.vehicleNumber}",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        "${data.vehicleNumber}",
                        style: System.data.textStyleUtil.mainLabel(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text(
                      "${System.data.resource.vehicleType}",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        "${data.vehicleType}",
                        style: System.data.textStyleUtil.mainLabel(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text(
                      "${System.data.resource.driverName}",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        "${data.driverName}",
                        style: System.data.textStyleUtil.mainLabel(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text(
                      "${System.data.resource.odometer}",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        "${NumberFormat("#,##0", System.data.resource.locale).format(data.odometer)} km",
                        style: System.data.textStyleUtil.mainLabel(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text(
                      "${System.data.resource.engineHour}",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        "${NumberFormat("#,##0", System.data.resource.locale).format(data.engineHourMeter)} hours",
                        style: System.data.textStyleUtil.mainLabel(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  static Widget position(VtsPositionModel data) {
    return Container(
      child: Scrollbar(
        child: ListView(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text(
                      "${System.data.resource.dateTime}",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        "${data.dateTime}",
                        style: System.data.textStyleUtil.mainLabel(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text(
                      "${System.data.resource.location}",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        "${data.kabupaten}\n ${data.kecamatan}\n ${data.streetName}",
                        style: System.data.textStyleUtil.mainLabel(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text(
                      "${System.data.resource.engineStatus}",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        "${data.engine == 1 ? "ON" : "OFF"}",
                        style: System.data.textStyleUtil.mainLabel(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text(
                      "${System.data.resource.speed}",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        "${data.speed} km/h",
                        style: System.data.textStyleUtil.mainLabel(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text(
                      "${System.data.resource.direction}",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        "${data.course}\u00B0",
                        style: System.data.textStyleUtil.mainLabel(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text(
                      "${System.data.resource.latitude}",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        "${data.lat}",
                        style: System.data.textStyleUtil.mainLabel(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text(
                      "${System.data.resource.longitude}",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        "${data.lon}",
                        style: System.data.textStyleUtil.mainLabel(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  static Widget status(VtsPositionModel data) {
    return Container(
      child: Scrollbar(
        child: ListView(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text(
                      "${System.data.resource.dateTime}",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        "${data.dateTime}",
                        style: System.data.textStyleUtil.mainLabel(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text(
                      "${System.data.resource.gps}",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        "${data.gpsValid}",
                        style: System.data.textStyleUtil.mainLabel(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text(
                      "${System.data.resource.engineStatus}",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        "${data.engine == 1 ? "ON" : "OFF"}",
                        style: System.data.textStyleUtil.mainLabel(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text(
                      "${System.data.resource.powerSource}",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        "${data.mainPower} ",
                        style: System.data.textStyleUtil.mainLabel(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text(
                      "${System.data.resource.temperature}",
                      style: System.data.textStyleUtil.mainLabel(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        "${data.temp1}  \u2103",
                        style: System.data.textStyleUtil.mainLabel(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 20,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
