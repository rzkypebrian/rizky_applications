import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/externalLinkComponent.dart';
import 'package:enerren/component/ratingComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'presenter.dart';
import 'package:component_icons/font_awesome.dart';
import 'viewModel.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => super.model,
      child: Consumer<ViewModel>(
        builder: (ctx, dt, child) {
          return Scaffold(
            backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
            appBar: appBar(context),
            body: SingleChildScrollView(
              child: body(),
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return BottonComponent.customAppBar1(
      context: context,
      actionText: "",
      title: "${System.data.resource.detail}",
      backButtonColor: System.data.colorUtil.lightTextColor,
      titleColor: System.data.colorUtil.lightTextColor,
      backgroundColor: System.data.colorUtil.primaryColor,
    );
  }

  Widget body({List<Widget> listProfile}) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: System.data.colorUtil.lightTextColor,
                boxShadow: [
                   BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
                ]),
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
                boxShadow: [
                   BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
                ]),
            child: detailVehicleType(),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 0,
            width: 0,
          ),
        ],
      ),
    );
  }

  List<Widget> contentList() {
    return [
      externalLink(),
      detailImage(),
      detailName(),
      rating(),
      SizedBox(
        height: 30,
      ),
      Column(
        children: profileItem(),
      )
    ];
  }

  Widget rating() {
    return Container(
      width: 158,
      height: 20,
      child: RatingComponent(
        score: model.score,
        space: 0,
        readOnly: true,
      ),
    );
  }

  Widget detailImage() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
          boxShadow: [
             BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
          ],
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage("${model.urlDriverImmage ?? ""}"),
          ),
        ),
      ),
    );
  }

  Widget detailName() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(
          bottom: 10,
        ),
        child: Text(
          "${model.driverName ?? ""}",
          style: System.data.textStyleUtil.mainLabel(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget detailStarRating() {
    return Container();
  }

  List<Widget> profileItem() {
    return <Widget>[
      detailProfile(System.data.resource.nik, "${model.driverNik}"),
      detailProfile(System.data.resource.phone, "${model.phoneNumber}"),
      detailProfile(System.data.resource.email, "${model.email}"),
      detailProfile(System.data.resource.birthday,
          "${model.birdDate != null ? DateFormat("dd MMM yyyy", System.data.resource.dateLocalFormat).format(model.birdDate) : "-"}"),
      detailProfile(System.data.resource.address, "${model.address}"),
    ];
  }

  Widget detailProfile(String label, String value) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 20,
              right: 20,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 100,
                        child: Text(
                          "$label",
                          style: System.data.textStyleUtil.mainLabel(
                            fontWeight: FontWeight.bold,
                          ),
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
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 20,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget detailVehicleType() {
    return ListTile(
      title: Text(
        "${System.data.resource.vehicleType}",
        style: System.data.textStyleUtil.listTileTitle(
          fontWeight: FontWeight.bold,
          color: System.data.colorUtil.inputTextColor,
        ),
      ),
      subtitle: Text(
        "${model.vehicleType}",
        style: System.data.textStyleUtil.listTileSUbtitile(
          color: System.data.colorUtil.inputTextColor,
        ),
      ),
      trailing: GestureDetector(
        onTap: onTapVehicle,
        child: Container(
          height: 14,
          width: 14,
          child: Icon(
            FontAwesomeRegular(FontAwesomeId.fa_chevron_right),
            size: 15,
            color: System.data.colorUtil.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget externalLink() {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(right: 20, top: 20),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          ExternalLinkComponent.mapPhoneWA(
            phoneNumber: model.phoneNumber,
            showMapLink: false,
          )
        ],
      ),
    );
  }
}
