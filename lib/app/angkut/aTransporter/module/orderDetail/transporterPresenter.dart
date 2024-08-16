import 'package:component_icons/font_awesome.dart';
import 'package:enerren/app/angkut/aTransporter/module/orderDetail/viewModel.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/app/angkut/module/orderDetail/presenter.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

mixin TransporterPresenter on PresenterState {
  SelectDriverController selectDriverController = SelectDriverController();

  @override
  void onReceive() {
    showDriver();
  }

  void onReceiveByTRansporter() {
    super.driverId = selectDriverController.driver.driverId;
    super.vehicleId = selectDriverController.driver.vehicleId;
    super.vehicleIdVts = selectDriverController.driver.vtsVehicleId;
    super.onReceive();
  }

  showDriver() {
    loadingController.startLoading(
      coverScreen: true,
    );
    TmsVehicleModel.getAll<AngkutShipmentModel>(
      childReader: (data) => AngkutShipmentModel.fromJson(data),
      token: System.data.global.token,
      vehicleStatus: 1,
    ).then((onValue) {
      loadingController.stopLoading();
      if (onValue.length > 0) {
        showModalAllDriver(onValue);
      } else {
        loadingController.stopLoading(
            messageAlign: Alignment.topCenter,
            messageWidget: DecorationComponent.topMessageDecoration(
                message: "${System.data.resource.noMoreVehicleAndDriver}"));
      }
    }).catchError((onError) {
      loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
              message: ErrorHandlingUtil.handleApiError(onError)));
    });
  }

  showModalAllDriver(List<TmsVehicleModel> drivers) {
    if (selectDriverController.value.selectedDriver == null) {
      selectDriverController.driver = drivers.first;
    }

    return ModalComponent.bottomModalWithCorner(
      context,
      height: 300,
      child: ValueListenableBuilder<SelectedDriver>(
        valueListenable: selectDriverController,
        builder: (ctx, value, child) {
          return Container(
            height: 284,
            child: Stack(
              children: <Widget>[
                Container(
                  child: ListView(
                    children: List.generate(drivers.length, (i) {
                      return GestureDetector(
                        onTap: () {
                          selectDriverController.driver = drivers[i];
                        },
                        child: Container(
                          height: 60,
                          padding: EdgeInsets.only(bottom: 10, top: 10),
                          margin: EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.shade300,
                                  style: BorderStyle.solid,
                                  width: 1),
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              drivers[i].vehicleId ==
                                      value.selectedDriver.vehicleId
                                  ? Container(
                                      width: 30,
                                      margin: EdgeInsets.only(right: 5),
                                      height: double.infinity,
                                      child: Center(
                                        child: Icon(FontAwesomeSolid(
                                            FontAwesomeId.fa_caret_right)),
                                      ),
                                    )
                                  : Container(
                                      height: 0,
                                      margin: EdgeInsets.only(right: 5),
                                      width: 30,
                                    ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "${drivers[i].driverImageUrl}"))),
                              ),
                              Expanded(
                                  child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "${drivers[i].driverName}",
                                          style: System.data.textStyleUtil
                                              .mainLabel(
                                            color: System
                                                .data.colorUtil.primaryColor,
                                          ),
                                        ),
                                        Container(
                                          height: 15,
                                          width: 15,
                                          child: SvgPicture.network(
                                              "${drivers[i].vehicleTypeIconUrl}"),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Jakarta",
                                          style: System.data.textStyleUtil
                                              .mainLabel(),
                                        ),
                                        Text("${drivers[i].vehicleTypeName}"),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Align(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 50,
                      child: BottonComponent.roundedButton(
                        radius: 0,
                        text: "${System.data.resource.confirmation}",
                        onPressed: () {
                          System.data.routes.pop(context);
                          onReceiveByTRansporter();
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class SelectDriverController extends ValueNotifier<SelectedDriver> {
  SelectDriverController({
    SelectedDriver value,
  }) : super(value == null ? SelectedDriver() : value);

  set driver(TmsVehicleModel driver) {
    value.selectedDriver = driver;
    notifyListeners();
  }

  TmsVehicleModel get driver => value.selectedDriver;
}
