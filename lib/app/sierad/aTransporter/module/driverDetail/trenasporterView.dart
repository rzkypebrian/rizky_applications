import 'package:enerren/app/sierad/aTransporter/module/driverDetail/transporterPresenter.dart';
import 'package:enerren/app/sierad/model/SieradShipmentDetailHatcheryModel.dart';
import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/module/detailDriver/view.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

class TransPorterView extends View with TransPorterPresenter {
  final List<TmsShipmentModel> dataShipment;
  final ValueChanged<TmsShipmentModel<SieradShipmentDetailHatcheryModel>>
      onTapDetailShipment;

  TransPorterView({this.dataShipment, this.onTapDetailShipment});

  @override
  Widget body({List<Widget> listProfile}) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: System.data.colorUtil.lightTextColor,
            ),
            child: Column(
              children: contentList(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: System.data.colorUtil.lightTextColor,
            ),
            child: detailVehicleType(),
          ),
          SizedBox(
            height: 20,
          ),
          dataShipment.isNotEmpty
              ? Container(
                  margin: EdgeInsets.only(bottom: 100),
                  child: DecorationComponent.listTileDecoretion(
                    height: 100,
                    widget: contents(
                        data: dataShipment,
                        onTap: (a) {
                          if (onTapDetailShipment != null) {
                            onTapDetailShipment(a);
                          }
                        }),
                  ),
                )
              : Container(
                  width: 0,
                  height: 0,
                ),
        ],
      ),
    );
  }

  static Widget contents(
      {List<TmsShipmentModel> data, ValueChanged<TmsShipmentModel> onTap}) {
    return Column(
      children: List.generate(data.length, (i) {
        return DecorationComponent.shipmentContents(
          data: data[i],
          onTap: onTap,
        );
      }),
    );
  }
}
