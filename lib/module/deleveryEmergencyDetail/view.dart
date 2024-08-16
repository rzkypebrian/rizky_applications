import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/HeroComponent.dart';
import 'package:enerren/component/externalLinkComponent.dart';
import 'package:enerren/component/ratingComponent.dart';
import 'package:enerren/util/GeolocatorUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'presenter.dart';
import 'package:enerren/component/custom/circle_avatar_custom.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      title: System.data.resource.emergency,
      context: context,
      actionText: "",
      titleColor: System.data.colorUtil.secondaryColor,
      backButtonColor: System.data.colorUtil.lightTextColor,
      actionTextStyle: System.data.textStyleUtil.mainLabel(),
      actionTextColor: System.data.colorUtil.secondaryColor,
      titleStyle: System.data.textStyleUtil.mainTitle(),
      backgroundColor: System.data.colorUtil.primaryColor,
    );
  }

  Widget body() {
    return Container(
      height: 450,
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          driverInfo(),
          Divider(
            height: 20,
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FutureBuilder(
                  future: GeolocatorUtil.getAddress(
                      widget.emergencyModel.emergencyLat,
                      widget.emergencyModel.emergencyLon),
                  initialData: System.data.resource.loading,
                  builder: (context, snapshoot) {
                    return listItem(
                      label: System.data.resource.location,
                      value: "${snapshoot.data}",
                    );
                  },
                ),
                listItem(
                  label: System.data.resource.reason,
                  value: "${widget.emergencyModel.emergencyNote}",
                ),
                listItem(
                  label: System.data.resource.photo,
                  value: "",
                ),
                GestureDetector(
                  onTap: () {
                    print("tap me");
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return HeroComponent(
                        pathImage: '${widget.emergencyModel.emergencyFile}',
                        tagImage: "belajraHero",
                        backgroundColor: Colors.black,
                      );
                    }));
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "${widget.emergencyModel.emergencyFile}"),
                          fit: BoxFit.cover),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget driverInfo() {
    return Container(
      height: 110,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                onTapProfile(widget.emergencyModel.driverData);
              },
              child: Text(
                "${System.data.resource.profile}",
                style: System.data.textStyleUtil.linkLabel(
                  textDecoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              children: <Widget>[
                CircleAvatarCustom(
                  radius: 25,
                  border: Border.all(
                    width: 2,
                    color: Colors.white,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: System.data.colorUtil.shadowColor.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                  backgroundImage: NetworkImage(
                    "${widget.emergencyModel.driverImageUrl}",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${widget.emergencyModel.driverName}",
                  style: System.data.textStyleUtil.linkLabel(),
                ),
                SizedBox(
                  height: 10,
                ),
                RatingComponent(
                  readOnly: true,
                  height: 18,
                  space: 3,
                  score: widget.emergencyModel.driverRating,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 100,
              child: ExternalLinkComponent.mapPhoneWA(
                mainAxisAlignment: MainAxisAlignment.end,
                showMapLink: true,
                lat: widget.emergencyModel.emergencyLat,
                lon: widget.emergencyModel.emergencyLon,
                phoneNumber: "${widget.emergencyModel.driverData.phoneNumber}",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listItem({
    String label,
    String value,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 150,
            child: Text(
              "$label",
              style: System.data.textStyleUtil.linkLabel(),
            ),
          ),
          Expanded(
            child: Container(
              child: Text(
                "$value",
                style: System.data.textStyleUtil.mainLabel(),
                textAlign: TextAlign.end,
              ),
            ),
          )
        ],
      ),
    );
  }
}
