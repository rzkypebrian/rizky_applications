import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/app/angkut/module/orderDetail/view.dart';

class PeopleTransportView extends View {
  @override
  Widget goods() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(left: 25, bottom: 20, top: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  "${System.data.resource.itemType}",
                  style: System.data.textStyleUtil.mainLabel(
                    color: System.data.colorUtil.blueColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  "${model.shipment.deliveryDescription}",
                  style: System.data.textStyleUtil.mainLabel(),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  "${System.data.resource.extraPeople}",
                  style: System.data.textStyleUtil.mainLabel(
                    color: System.data.colorUtil.blueColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  "${model.shipment.extraHelperCount} ${System.data.resource.person}",
                  style: System.data.textStyleUtil.mainLabel(),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
