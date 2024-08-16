import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/vehicleInfoDecoration.dart';
import 'package:enerren/module/detailVehicle/presenter.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presenter.dart';
import 'package:component_icons/font_awesome.dart';
import 'package:flutter_svg/flutter_svg.dart';

class View extends PresenterState {
  @override 
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (contet) => model,
      child: Scaffold(
        backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
        appBar: appBar(context),
        body: body(),
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return BottonComponent.customAppBar1(
      backgroundColor: System.data.colorUtil.primaryColor,
      actionText: "",
      context: context,
      backButtonColor: System.data.colorUtil.lightTextColor,
      title: System.data.resource.detailVehicleTitle,
      titleStyle: System.data.textStyleUtil.mainTitle(),
    );
  }

  Widget body() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          listDetailVehicle(),
          detailDriver(),
          detailStatus(),
        ],
      ),
    );
  }

  Widget listDetailVehicle() {
    return Container(
      decoration: BoxDecoration(
          color: System.data.colorUtil.lightTextColor,
          boxShadow: [
             BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
          ]),
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        children: <Widget>[
          imageItem(),
          detailVehicleTitle(),
          SizedBox(height: 10),
          detailVehicle(),
          detailSensor(),
        ],
      ),
    );
  }

  Widget imageItem() {
    return Container(
        child: Stack(
      children: <Widget>[
        model.vehicleModel.isSuitable
            ? Align(
                alignment: Alignment.topRight,
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
              )
            : Container(
                height: 0,
                width: 0,
              ),
        Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 11),
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  border: Border.all(
                    color: System.data.colorUtil.primaryColor,
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

  Widget detailVehicleTitle() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              "${System.data.resource.vehicleType}",
              style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.inputTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: Text(
                "${System.data.resource.vehicleNumber}",
                textAlign: TextAlign.end,
                style: System.data.textStyleUtil.mainLabel(
                  color: System.data.colorUtil.inputTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget detailVehicle() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              "${model.vehicleModel.vehicleTypeName}",
              style: System.data.textStyleUtil.listTileSUbtitile(
                color: System.data.colorUtil.darkTextColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: Text(
                "${model.vehicleModel.vehicleNumber}",
                textAlign: TextAlign.end,
                style: System.data.textStyleUtil.listTileSUbtitile(
                  color: System.data.colorUtil.darkTextColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget detailSensor() {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${System.data.resource.sensor}",
            style: System.data.textStyleUtil.mainLabel(
              color: System.data.colorUtil.inputTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          // Text(
          //   "${model.vehicleModel.sensor}",
          //   style: System.data.textStyleUtil.listTileSUbtitile(
          //     color: System.data.colorUtil.darkTextColor,
          //   ),
          // ),
          model.vehicleModel.isSuitable
              ? Container(
                  margin: EdgeInsets.only(right: 20, left: 15),
                  child: VehicleInfoDecoration.autoGenerateSensorView(
                    vtsPositionModel: model.vtsPositionModel,
                    dividerColor: Colors.white,
                  ),
                )
              : Container(
                  child: Text("Unsuitable Vehicle"),
                )
        ],
      ),
    );
  }

  Widget detailDriver() {
    return Container(
      decoration: BoxDecoration(
          color: System.data.colorUtil.lightTextColor,
          boxShadow: [
             BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
          ]),
      margin: EdgeInsets.only(top: 10),
      child: ListTile(
        title: Text(
          "${System.data.resource.driver}",
          style: System.data.textStyleUtil.mainLabel(
            color: System.data.colorUtil.inputTextColor,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.start,
        ),
        subtitle: Text(
          "${model.vehicleModel.driverName}",
          style: System.data.textStyleUtil.listTileSUbtitile(
            color: System.data.colorUtil.darkTextColor,
          ),
        ),
        trailing: IconButton(
          icon: Container(
            margin: EdgeInsets.only(
              left: 20,
            ),
            child: Icon(
              FontAwesomeRegular(FontAwesomeId.fa_chevron_right),
              size: 15,
              color: System.data.colorUtil.primaryColor,
            ),
            height: 15,
            width: 15,
          ),
          onPressed: () {
            gotoDriver();
          },
        ),
      ),
    );
  }

  Widget detailStatus() {
    return Container(
      decoration: BoxDecoration(
          color: System.data.colorUtil.lightTextColor,
          boxShadow: [
             BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
          ]),
      margin: EdgeInsets.only(top: 14),
      child: ListTile(
        title: Text(
          "${System.data.resource.status}",
          style: System.data.textStyleUtil.mainLabel(
            color: System.data.colorUtil.inputTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          "${model.vehicleModel.vehicleStatusName}",
          style: System.data.textStyleUtil.listTileSUbtitile(
            color: System.data.colorUtil.statusColor,
          ),
        ),
      ),
    );
  }
}
