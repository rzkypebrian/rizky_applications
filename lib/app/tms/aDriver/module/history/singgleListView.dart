import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/model/tmsShipmentDestinationModel.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/app/tms/aDriver/module/history/singgleListPresenter.dart';
import 'package:enerren/util/GeolocatorUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';

class SinggleListView<T> extends SinggleListState {
  TmsShipmentModel<T> data;
  ChildReader<T> childReader;

  SinggleListView({
    this.data,
    this.childReader,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
      appBar: appBar(),
      body: home(),
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      title: widget.title ?? System.data.resource.history,
      context: context,
      actionText: "",
      titleColor: System.data.colorUtil.secondaryColor,
      backButtonColor: System.data.colorUtil.scafoldColor,
      actionTextStyle: System.data.textStyleUtil.mainLabel(),
      actionTextColor: System.data.colorUtil.secondaryColor,
      titleStyle: System.data.textStyleUtil.mainTitle(),
      backgroundColor: System.data.colorUtil.primaryColor,
    );
  }

  Widget home() {
    return Container(
      child: ListView(
        children: List.generate(data.tmsShipmentDestinationList.length, (i) {
          var single = TmsShipmentModel.fromJson<T>(data.toJson(),
              childReader: childReader);
          single.tmsShipmentDestinationList = <TmsShipmentDestinationModel<T>>[
            data.tmsShipmentDestinationList[i]
          ];

          GeolocatorUtil.getAddress(
                  single.tmsShipmentDestinationList.first.destinationLat,
                  single.tmsShipmentDestinationList.first.destinationLat)
              .then((onValue) {
            single.tmsShipmentDestinationList.first.destinationAddress =
                onValue;
          });

          return DecorationComponent.listTileDecoretion(
            height: 100,
            widget: DecorationComponent.shipmentContents<T>(
                data: single,
                onTap: widget.onSelected,
                subTitle: DecorationComponent.futureBuilderAdress(
                  lat: single.tmsShipmentDestinationList.first.destinationLat,
                  lon: single.tmsShipmentDestinationList.first.destinationLong,
                )),
          );
        }),
      ),
    );
  }
}
