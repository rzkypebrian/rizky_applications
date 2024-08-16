import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/externalLinkComponent.dart';
import 'package:enerren/component/vehicleInfoDecoration.dart';
import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:enerren/module/liveMaps/view.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'angkutPresenter.dart';
import 'viewModelLiveMap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:enerren/module/liveMaps/main.dart';

class AngkutView extends View with AngkutPresenter {
  AngkutShipmentModel shipmentModel;
  TmsVehicleModel vehicle;
  ValueChanged<AngkutShipmentModel> onTapChat;

  @override
  void initState() {
    super.bottomSheetHeight = 350;
    super.bottomSheetContentPadding = EdgeInsets.only(top: 15);
    super.initState();
  }

  AngkutView({
    this.shipmentModel,
    this.onTapChat,
  }) {
    super.viewModelLiveMap.shipmentModel = this.shipmentModel;
  }

  Widget floatingActionBotton() {
    return null;
  }

  @override
  List<Widget> listComponent() {
    return <Widget>[
      map(),
      bottomSheet(),
    ];
  }

  @override
  Widget bottomSheetContent() {
    return ChangeNotifierProvider(
      create: (ctx) => super.viewModelLiveMap,
      child: Consumer<ViewModelLiveMap>(
        builder: (ctx, data, child) {
          return Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Container(
                  height: 150,
                  padding: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: System.data.colorUtil.primaryColor,
                    width: 1,
                  ))),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: SvgPicture.asset(
                            "assets/angkut/background_bercak_avatar.svg"),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 70,
                          width: 70,
                          margin: EdgeInsets.only(left: 17, top: 22),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                data.shipmentModel?.tmsShipmentDestinationList
                                        ?.first?.driverImageUrl ??
                                    "",
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: Colors.white,
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 16, top: 10),
                          child: Text(
                            "${data.shipmentModel?.tmsShipmentDestinationList?.first?.driverName}",
                            textAlign: TextAlign.center,
                            style: System.data.textStyleUtil.linkLabel(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  ExternalLinkComponent.openPhone(
                                    data
                                        .shipmentModel
                                        .tmsShipmentDestinationList
                                        .first
                                        .driverPhone,
                                  );
                                },
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  margin: EdgeInsets.only(right: 10),
                                  child: SvgPicture.asset(
                                    "assets/angkut/help_tlp.svg",
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // ExternalLinkComponent.openWA(
                                  //   data
                                  //       .shipmentModel
                                  //       .tmsShipmentDestinationList
                                  //       .first
                                  //       .driverPhone,
                                  // );
                                  if (onTapChat != null) {
                                    onTapChat(shipmentModel);
                                  }
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  margin: EdgeInsets.only(right: 10),
                                  child: SvgPicture.asset(
                                    "assets/angkut/help_chat.svg",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: System.data.colorUtil.primaryColor,
                    width: 1,
                  ))),
                  child: Column(
                    children: <Widget>[
                      detailItem(
                          title: System.data.resource.vehicleType,
                          value: data.shipmentModel?.tmsShipmentDestinationList
                              ?.first?.vehicleType),
                      detailItem(
                          title: System.data.resource.vehicleNumber,
                          value: data.shipmentModel?.tmsShipmentDestinationList
                              ?.first?.vehicleNo),
                      // detailItem(
                      //   title: System.data.resource.vehicleDetail,
                      //   value: data.shipmentModel.tmsShipmentDestinationList.first.vehicleType
                      // ),
                      // detailItem(
                      //   title: System.data.resource.vehicleType,
                      //   value: data.shipmentModel.tmsShipmentDestinationList.first.vehicleType
                      // ),
                      data.shipmentModel.completeDatetime == null
                          ? sensor()
                          : Container(
                              height: 0,
                              width: 0,
                            )
                    ],
                  ),
                ))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget sensor() {
    return Column(
      children: <Widget>[
        detailItem(title: System.data.resource.sensor, value: ""),
        VehicleInfoDecoration.autoGenerateSensorView(
            vtsPositionModel: model.currentPoition,
            dividerColor: Colors.transparent,
            margin: EdgeInsets.only(top: 0, left: 20),
            space: 10)
      ],
    );
  }

  Widget detailItem({
    String title,
    String value,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "$title",
            style: System.data.textStyleUtil.linkLabel(),
          ),
          Text("$value"),
        ],
      ),
    );
  }
}
