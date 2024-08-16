import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/util/StringExtention.dart';
import 'package:enerren/app/sierad/module/detailHistory/view.dart';
import 'package:component_icons/font_awesome.dart';

class TransporterView extends View {
  @override
  Widget bottomNavigationBarFinish() {
    return null;
  }

  @override
  Widget user() {
    return Container(
      height: 74,
      margin: EdgeInsets.only(
        top: 8,
      ),
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    right: 16,
                  ),
                  width: 53,
                  height: 53,
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: System.data.colorUtil.primaryColor,
                    ),
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(super
                              .model
                              .shipment
                              .tmsShipmentDestinationList
                              .first
                              .driverImageUrl
                              .isNullOrEmpty()
                          ? "https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
                          : super
                              .model
                              .shipment
                              .tmsShipmentDestinationList
                              .first
                              .driverImageUrl),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "${System.data.resource.driver}",
                          style: System.data.textStyleUtil.mainLabel(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${super.model.shipment.tmsShipmentDestinationList.first.driverName}",
                          style: System.data.textStyleUtil.mainLabel(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${System.data.resource.kernet}",
                        style: System.data.textStyleUtil
                            .mainLabel(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${super.model.shipment.tmsShipmentDestinationList.first.coDriverName}",
                        style: System.data.textStyleUtil.mainLabel(),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      ModalComponent.bottomModalWithCorner(
                        context,
                        height: 350,
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 53,
                                      height: 53,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: System
                                              .data.colorUtil.primaryColor,
                                        ),
                                        image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: new NetworkImage(super
                                                  .model
                                                  .shipment
                                                  .tmsShipmentDestinationList
                                                  .last
                                                  .driverImageUrl
                                                  .isNullOrEmpty()
                                              ? "https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
                                              : super
                                                  .model
                                                  .shipment
                                                  .tmsShipmentDestinationList
                                                  .last
                                                  .driverImageUrl),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${super.model.shipment.tmsShipmentDestinationList.first.driverName}",
                                      style:
                                          System.data.textStyleUtil.linkLabel(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 230,
                                margin: EdgeInsets.only(
                                    top: 20, left: 20, right: 20),
                                padding: EdgeInsets.only(top: 15),
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                  color: Colors.grey,
                                ))),
                                child: ListView(
                                  children: <Widget>[
                                    detailBottomSheet(
                                      leftTitle: System.data.resource.kernet,
                                      leftValue:
                                          "${super.model.shipment.tmsShipmentDestinationList.first.coDriverName}",
                                      rightTitle: System
                                          .data.resource.vendorTransporter,
                                      rightValue:
                                          "${super.model.shipment.tmsShipmentDestinationList.first.transporterName}",
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    detailBottomSheet(
                                      leftTitle:
                                          System.data.resource.vehicleType,
                                      leftValue: super
                                          .model
                                          .shipment
                                          .tmsShipmentDestinationList
                                          .first
                                          .vehicleType,
                                      rightTitle:
                                          System.data.resource.vehicleNo,
                                      rightValue:
                                          System.data.resource.vehicleNo,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    detailBottomSheet(
                                        leftTitle: System.data.resource.sensor,
                                        leftValue:
                                            "${super.model.shipment.tmsShipmentDestinationList.first.vehicleSensor}")
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 30,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          FontAwesomeRegular(FontAwesomeId.fa_chevron_right),
                          size: 15,
                          color: System.data.colorUtil.darkTextColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailBottomSheet({
    String leftTitle = "",
    String leftValue = "",
    String rightTitle = "",
    String rightValue = "",
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "$leftTitle",
              style: System.data.textStyleUtil.linkLabel(),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "$leftValue",
              style: System.data.textStyleUtil.mainLabel(),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              "$rightTitle",
              style: System.data.textStyleUtil.linkLabel(),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "$rightValue",
              style: System.data.textStyleUtil.mainLabel(),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget home() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            order(),
            user(),
            historyDriver(),
            location(),
            customer(),
            truck(),
            products(),
            detailProduct(),
            statusOrder(),
          ],
        ),
      ),
    );
  }

  Widget customer() {
    return Container(
      margin: EdgeInsets.only(top: 11),
      padding: EdgeInsets.only(left: 27, right: 27),
      decoration: BoxDecoration(
        color: System.data.colorUtil.secondaryColor,
        boxShadow: [
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 12, top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "${System.data.resource.customerName}",
                  style: System.data.textStyleUtil.mainLabel(),
                ),
                Text(
                  "${System.data.resource.receiver}",
                  style: System.data.textStyleUtil.mainLabel(),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "${super.model.shipment.customerName}",
                  style: System.data.textStyleUtil.mainLabel(),
                ),
                Text(
                  "${super.model.shipment.tmsShipmentDestinationList.first.receiverName}",
                  style: System.data.textStyleUtil.mainLabel(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
