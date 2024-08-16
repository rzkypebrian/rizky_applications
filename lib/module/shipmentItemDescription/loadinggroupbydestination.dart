import 'package:enerren/model/tmsShipmentDestinationModel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'view.dart';
import 'package:flutter/material.dart';
import 'viewModel.dart';

class LoadingGroupByDestination extends View {
  final List<TmsShipmentDestinationModel> destinations;

  LoadingGroupByDestination({
    this.destinations,
  });

  @override
  Widget listItem() {
    return Container(
      child: Consumer<ViewModel>(
        builder: (crx, dt, child) {
          return ListView(
            children: List.generate(destinations.length, (id) {
              return dt.shipmentItemDescriptions
                      .where((e) =>
                          e.podDetailshipmentId ==
                          destinations[id].detailshipmentId)
                      .toList()
                      .isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "${System.data.resource.destination} ${id + 1}",
                            style: System.data.textStyleUtil.linkLabel(
                              fontSize: System.data.fontUtil.l,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            children: List.generate(
                                dt.shipmentItemDescriptions.length, (i) {
                              return dt.shipmentItemDescriptions[i]
                                          .podDetailshipmentId ==
                                      destinations[id].detailshipmentId
                                  ? Container(
                                      color:
                                          System.data.colorUtil.secondaryColor,
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 20, right: 13),
                                            child: SvgPicture.asset(
                                              widget.iconItemAssets ??
                                                  'assets/angkut/boxss.svg',
                                              height: 38,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  right: 10,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      bottom: 10,
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Container(
                                                            child: Text(
                                                                "${dt.shipmentItemDescriptions[i].item}"),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 100,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: <Widget>[
                                                              widget.showQtyField
                                                                  ? Container(
                                                                      child: Text(
                                                                          "${dt.shipmentItemDescriptions[i].qty}"),
                                                                    )
                                                                  : SizedBox(),
                                                              widget.showUnitField
                                                                  ? Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              36),
                                                                      child: Text(
                                                                          "${dt.shipmentItemDescriptions[i].uomName}"),
                                                                    )
                                                                  : SizedBox()
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                      child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Container(
                                                            child: Text(
                                                                "${dt.shipmentItemDescriptions[i].itemDescription}")),
                                                      ),
                                                    ],
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ))
                                  : SizedBox();
                            }),
                          ),
                        )
                      ],
                    )
                  : SizedBox();
            }),
          );
        },
      ),
    );
  }
}
