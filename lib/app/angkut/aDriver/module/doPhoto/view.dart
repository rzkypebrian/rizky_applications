import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';

import '../../../../../util/SystemUtil.dart';
import 'presenter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'HomeViewer.dart';
import 'package:component_icons/font_awesome.dart';
import 'package:flutter_svg/flutter_svg.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewer>(
      create: (BuildContext context) => model,
      child: Consumer<HomeViewer>(
        builder: (ctx, dt, child) {
          return Scaffold(
            backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
            appBar: appBar(dt),
            body: home(dt),
          );
        },
      ),
    );
  }

  PreferredSizeWidget appBar(HomeViewer dt) {
    return BottonComponent.customAppBar1(
        title: System.data.resource.deliveryOrder,
        context: context,
        actionText: "",
        titleColor: System.data.colorUtil.secondaryColor,
        backButtonColor: System.data.colorUtil.lightTextColor,
        actionTextStyle: System.data.textStyleUtil.mainLabel(),
        actionTextColor: System.data.colorUtil.secondaryColor,
        titleStyle: System.data.textStyleUtil.mainTitle(),
        backgroundColor: System.data.colorUtil.primaryColor,
        rightWidget: null);
  }

  Widget home(HomeViewer dt) {
    return Container(
      color: System.data.colorUtil.scaffoldBackgroundColor,
      child: Stack(
        children: <Widget>[
          topContent(dt),
          sumbitData(dt),
          circilarComponent(),
        ],
      ),
    );
  }

  Widget topContent(HomeViewer dt) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              list(
                  pathImg: "assets/angkut/camera.svg",
                  name: widget.podLabel ??
                      "${System.data.resource.photoSenderAndItem}",
                  onTap: widget.onTapPhoto),
              list(
                  pathImg: "assets/angkut/boxss.svg",
                  name: "${System.data.resource.checkFormDo}",
                  onTap: widget.onTapDO),
            ],
          ),
        ),
      ),
    );
  }

  Widget sumbitData(HomeViewer dt) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: nextToMaps,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: System.data.colorUtil.primaryColor,
          ),
          width: double.infinity,
          height: 42,
          margin: EdgeInsets.only(bottom: 37, left: 16, right: 16),
          child: Center(
            child: Text(
              "${System.data.resource.next}",
              style: System.data.textStyleUtil.mainLabel(
                  color: System.data.colorUtil.secondaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget circilarComponent() {
    return DecorationComponent.circularLOadingIndicator(
      controller: model.loadingController,
    );
  }

  Widget list({String pathImg, String name, VoidCallback onTap}) {
    return Container(
      // height: 65,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
           BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        onTap: onTap,
        trailing: Icon(
          FontAwesomeLight(FontAwesomeId.fa_chevron_right),
          color: System.data.colorUtil.primaryColor,
        ),
        title: Container(
          child: Text(
            "$name",
            style: System.data.textStyleUtil.mainLabel(),
          ),
        ),
        leading: Container(
          child: SvgPicture.asset(
            "$pathImg",
            height: 30,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
