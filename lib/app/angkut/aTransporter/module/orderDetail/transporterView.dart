import 'package:enerren/app/angkut/aCustomer/module/orderDetail/main.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'transporterPresenter.dart';

class TransporterView extends HiddenDiscount with TransporterPresenter {
  final ValueChanged<AngkutShipmentModel> onTapAddAllowanceBalance;

  TransporterView({
    this.onTapAddAllowanceBalance,
  });

  @override
  Widget buttom() {
    return model.shipment.shipmentStatusId == 1 ||
            model.shipment.shipmentStatusId == 2 ||
            model.shipment.shipmentStatusId == 13
        ? Container(
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(13),
                    child: BottonComponent.roundedButton(
                        onPressed: onReceive,
                        text: "${System.data.resource.accept}"))
              ],
            ),
          )
        : model.shipment.shipmentStatusId != 10 && widget.showTripReport == true
            ? Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(13),
                      child: BottonComponent.roundedButton(
                          onPressed: () {
                            onTapAddAllowanceBalance(widget.shipment);
                          },
                          text:
                              "${System.data.resource.addBalance} ${System.data.resource.allowance}"),
                    ),
                    Container(
                      margin: EdgeInsets.all(13),
                      child: BottonComponent.roundedButton(
                          onPressed: super.getShipmentReport,
                          text: "${System.data.resource.allowance}"),
                    )
                  ],
                ),
              )
            : model.shipment.shipmentStatusId == 10 &&
                    widget.showTripReport == true
                ? Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.all(13),
                            child: BottonComponent.roundedButton(
                                onPressed: super.getShipmentReport,
                                text: "${System.data.resource.allowance}"))
                      ],
                    ),
                  )
                : Container(
                    width: 0,
                    height: 0,
                  );
  }
}
