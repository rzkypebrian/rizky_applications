import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/menuComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:enerren/util/StringExtention.dart';

import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: boxDecoration(),
      child: Scaffold(
        appBar: appBar(),
        body: body(),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      title: System.data.resource.contact,
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
    return Stack(
      children: <Widget>[
        background(),
        containerContent(),
      ],
    );
  }

  Widget background() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height:
            MediaQuery.of(context).size.height / widget.backgroundHeighScala ??
                3,
        color: Colors.transparent,
        child: SvgPicture.asset(
          "${super.model.headOfficeImage ?? "assets/background_contact.svg"}",
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget containerContent() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height / 1.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.mainContentCorner ?? 30),
            topRight: Radius.circular(widget.mainContentCorner ?? 30),
          ),
        ),
        child: content(),
      ),
    );
  }

  Widget content() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 50,
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  System.data.resource.needHelpContactUsAt,
                  textAlign: TextAlign.start,
                  style: System.data.textStyleUtil.mainLabel(),
                ),
              ),
            ),
            address(),
            SizedBox(
              height: 30,
            ),
            super.model.headOfficeFax.isNullOrEmpty()
                ? Container(
                    height: 0,
                    width: 0,
                  )
                : fax(),
            SizedBox(
              height: 30,
            ),
            externalLink()
          ],
        ),
      ),
    );
  }

  Widget address() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text("${System.data.resource.address}"),
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    openMao();
                  },
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          FontAwesomeSolid(FontAwesomeId.fa_map_marker_alt),
                          size: 20,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          System.data.resource.map,
                          style: System.data.textStyleUtil.linkLabel(
                              textDecoration: TextDecoration.underline),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "${super.model.headOfficeAddress ?? "-"}",
            style: System.data.textStyleUtil.mainLabel(),
          )
        ],
      ),
    );
  }

  Widget fax() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                FontAwesomeSolid(FontAwesomeId.fa_fax),
                size: 20,
                color: Colors.black,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                System.data.resource.fax,
                style: System.data.textStyleUtil.mainLabel(),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "${model.headOfficeFax ?? "-"}",
            style: System.data.textStyleUtil.mainLabel(),
          )
        ],
      ),
    );
  }

  Widget externalLink() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          MenuComponent.circleMenu(
              sizeMenuButton: 95,
              size: 50,
              textMenuSpace: 60,
              textMenu: "${System.data.resource.phone}",
              colorRxtMenu: System.data.colorUtil.darkTextColor,
              textMenuStyle: System.data.textStyleUtil
                  .mainLabel(fontWeight: FontWeight.bold),
              backgroundColor: Colors.white,
              colorIcon: System.data.colorUtil.darkTextColor,
              neonStyle: false,
              menu: Center(
                child: SvgPicture.asset("assets/icon_contact_phone.svg"),
              ),
              shadow: [
                 BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
              ],
              onTap: () {
                openPhome();
              }),
          MenuComponent.circleMenu(
              sizeMenuButton: 120,
              size: 50,
              textMenuSpace: 80,
              textMenu: "${System.data.resource.customerService2Line}",
              colorRxtMenu: System.data.colorUtil.darkTextColor,
              textMenuStyle: System.data.textStyleUtil
                  .mainLabel(fontWeight: FontWeight.bold),
              backgroundColor: Colors.white,
              colorIcon: System.data.colorUtil.darkTextColor,
              neonStyle: false,
              menu: Center(
                child: SvgPicture.asset("assets/icon_contact_headphone.svg"),
              ),
              shadow: [
                 BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
              ],
              onTap: () {
                openWa();
              }),
          MenuComponent.circleMenu(
              sizeMenuButton: 95,
              size: 50,
              textMenuSpace: 60,
              textMenu: "${System.data.resource.email}",
              colorRxtMenu: System.data.colorUtil.darkTextColor,
              textMenuStyle: System.data.textStyleUtil
                  .mainLabel(fontWeight: FontWeight.bold),
              backgroundColor: Colors.white,
              colorIcon: System.data.colorUtil.darkTextColor,
              neonStyle: false,
              menu: Center(
                child: SvgPicture.asset("assets/icon_contact_email.svg"),
              ),
              shadow: [
                 BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
              ],
              onTap: () {
                openEmail();
              }),
        ],
      ),
    );
  }

  Decoration boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
    );
  }
}
