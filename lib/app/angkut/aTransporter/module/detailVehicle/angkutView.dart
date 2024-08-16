import 'package:enerren/module/detailVehicle/view.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'angkutPresenter.dart';

class AngkutView extends View with AngkutPresenter {
  @override
  Widget imageItem() {
    return Container(
        child: Stack(
      children: <Widget>[
        super.model.vehicleModel.isSuitable
            ? Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: GestureDetector(
                    onTap: onTapSearch,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 10,
                        top: 10,
                      ),
                      child: SvgPicture.asset(
                        "assets/search_vehicle.svg",
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                height: 0,
                width: 0,
              ),
        Center(
          child: Column(
            children: <Widget>[
              Container(
                width: 200,
                height: 100,
                margin: EdgeInsets.only(top: 20),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: SvgPicture.asset(
                        "assets/angkut/backgroud_angkut_vehicle.svg",
                        alignment: Alignment.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 20, bottom: 11),
                          height: 64,
                          width: 64,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: 43,
                              height: 43,
                              child: SvgPicture.network(
                                "${model.vehicleModel.vehicleTypeIconUrl}",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${model.vehicleModel.vehicleName}",
                textAlign: TextAlign.center,
                style: System.data.textStyleUtil.mainLabel(
                  fontSize: System.data.fontUtil.l,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
