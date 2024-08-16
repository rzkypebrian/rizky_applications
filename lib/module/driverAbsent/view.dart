import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/HeroComponent.dart';
import 'package:enerren/component/ratingComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'presenter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
      appBar: appBar(),
      body: body(),
    );
  }

  Widget appBar() {
    return BottonComponent.customAppBar1(
      context: context,
      actionText: "",
      backgroundColor: System.data.colorUtil.primaryColor,
      title: System.data.resource.driverAbsent,
      titleStyle: System.data.textStyleUtil.mainLabel(
          color: System.data.colorUtil.lightTextColor,
          fontSize: System.data.fontUtil.xl),
      backButtonColor: System.data.colorUtil.lightTextColor,
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
           BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ]),
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          children: <Widget>[
            driverImage(),
            driverName(),
            driverRating(),
            vehicleType(),
            vehicleTypeName(),
            fuel(),
            Divider(
              color: System.data.colorUtil.blackColor,
            ),
            engineTemperature(),
            Divider(
              color: System.data.colorUtil.blackColor,
            ),
            oil(),
            Divider(
              color: System.data.colorUtil.blackColor,
            ),
            batteryStatus(),
            Divider(
              color: System.data.colorUtil.blackColor,
            ),
            photo(),
            listPhoto(),
          ],
        ),
      ),
    );
  }

  Widget driverImage() {
    return Container(
      child: Center(
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15),
              child: SvgPicture.asset("assets/angkut/Movers.svg"),
            ),
            Container(
              margin: EdgeInsets.only(top: 25, left: 65),
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: Colors.blue, style: BorderStyle.solid, width: 3),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:
                      NetworkImage("${tmsVehicleCheckDocument.driverImageUrl}"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget driverName() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Text(
        "${tmsVehicleCheckDocument.driverName}",
        style: System.data.textStyleUtil.mainLabel(
            color: System.data.colorUtil.blueColor,
            fontSize: System.data.fontUtil.xl),
      ),
    );
  }

  Widget driverRating() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: RatingComponent(
        readOnly: true,
        score: 5,
        space: 5,
        controller: ratingController,
      ),
    );
  }

  Widget vehicleType() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              "${System.data.resource.vehicleType}",
              style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.blueColor,
              ),
            ),
          ),
          Container(
            child: Text(
              "${System.data.resource.vehicleNo}",
              style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.blueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget vehicleTypeName() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              "${tmsVehicleCheckDocument.vehicleTypeName}",
              style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.blackColor,
              ),
            ),
          ),
          Container(
            child: Text(
              "${tmsVehicleCheckDocument.vehicleNumber}",
              style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget fuel() {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              "${System.data.resource.fuel}",
              style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.blueColor,
              ),
            ),
          ),
          Container(
              child: SvgPicture.asset(
            "assets/angkut/checklist.svg",
            color: tmsVehicleCheckDocument.fuelLevel
                ? System.data.colorUtil.greenColor
                : System.data.colorUtil.greyColor,
          )),
        ],
      ),
    );
  }

  Widget engineTemperature() {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              "${System.data.resource.engineTemperature}",
              style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.blueColor,
              ),
            ),
          ),
          Container(
              child: SvgPicture.asset(
            "assets/angkut/checklist.svg",
            color: tmsVehicleCheckDocument.machineTemperature
                ? System.data.colorUtil.greenColor
                : System.data.colorUtil.greyColor,
          )),
        ],
      ),
    );
  }

  Widget oil() {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              "${System.data.resource.oil}",
              style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.blueColor,
              ),
            ),
          ),
          Container(
              child: SvgPicture.asset(
            "assets/angkut/checklist.svg",
            color: tmsVehicleCheckDocument.oilLevel
                ? System.data.colorUtil.greenColor
                : System.data.colorUtil.greyColor,
          )),
        ],
      ),
    );
  }

  Widget batteryStatus() {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              "${System.data.resource.batteryStatus}",
              style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.blueColor,
              ),
            ),
          ),
          Container(
              child: SvgPicture.asset(
            "assets/angkut/checklist.svg",
            color: tmsVehicleCheckDocument.accuStatus
                ? System.data.colorUtil.greenColor
                : System.data.colorUtil.greyColor,
          )),
        ],
      ),
    );
  }

  Widget photo() {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              "${System.data.resource.photo}",
              style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.blueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listPhoto() {
    return Container(
      height: 110,
      padding: EdgeInsets.only(top: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          tmsVehicleCheckDocument.selfiePhoto.length,
          (i) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return HeroComponent(
                    pathImage: '${tmsVehicleCheckDocument.selfiePhoto[i]}',
                    tagImage: "belajraHero",
                  );
                }));
              },
              child: Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "${tmsVehicleCheckDocument.selfiePhoto[i]}"),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
