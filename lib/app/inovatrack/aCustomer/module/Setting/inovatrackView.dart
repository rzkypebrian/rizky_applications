import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/model/menuModel.dart';
import 'package:enerren/module/setting/GeneralView.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/component/ModalComponent.dart' as modal;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'inovatrackPresenter.dart';

class InovatrackView extends GeneralView with InovatrackPresenter {
  final double height = 450;

  VoidCallback language;
  VoidCallback changePassword;
  VoidCallback changePin;
  VoidCallback switchUser;
  VoidCallback refreshData;
  VoidCallback notification;
  VoidCallback logout;

  InovatrackView({
    this.language,
    this.changePassword,
    this.changePin,
    this.switchUser,
    this.refreshData,
    this.notification,
    this.logout,
  });

  List<MenuModel> setMenus() {
    return <MenuModel>[
      MenuModel(
        textMenu: System.data.resource.language,
        onTap: language,
        iconWidget: SvgPicture.asset("assets/inovatrack/arrow.svg"),
      ),
      MenuModel(
        textMenu: System.data.resource.changePassword,
        onTap: changePassword,
        iconWidget: SvgPicture.asset("assets/inovatrack/arrow.svg"),
      ),
      MenuModel(
        textMenu: System.data.resource.changePin,
        onTap: changePin,
        iconWidget: SvgPicture.asset("assets/inovatrack/arrow.svg"),
      ),
      MenuModel(
        textMenu: System.data.resource.switchUser,
        onTap: switchUser,
        iconWidget: SvgPicture.asset("assets/inovatrack/arrow.svg"),
      ),
      MenuModel(
        textMenu: System.data.resource.refreshData,
        onTap: refreshData,
        iconWidget: SvgPicture.asset("assets/inovatrack/arrow.svg"),
      ),
      MenuModel(
        textMenu: System.data.resource.notification,
        onTap: notification,
        iconWidget: SvgPicture.asset("assets/inovatrack/arrow.svg"),
      ),
      MenuModel(
        textMenu: System.data.resource.logout,
        iconWidget: SvgPicture.asset("assets/inovatrack/arrow.svg"),
        onTap: () {
          modal.ModalComponent.bottomModalWithCorner(context,
              height: 200,
              child: Container(
                height: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      System.data.resource.areYouSureToExit,
                      style: System.data.textStyleUtil
                          .linkLabel(fontSize: System.data.fontUtil.l),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 120,
                          height: 40,
                          child: BottonComponent.roundedButton(
                              colorBackground:
                                  System.data.colorUtil.primaryColor,
                              radius: 5,
                              text: System.data.resource.yes,
                              onPressed: () {
                                signOut(logout);
                              }),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: 120,
                          height: 40,
                          child: BottonComponent.roundedButton(
                              colorBackground:
                                  System.data.colorUtil.secondaryColor,
                              radius: 5,
                              border: Border.all(
                                  color: System.data.colorUtil.primaryColor),
                              text: System.data.resource.no,
                              textColor: System.data.colorUtil.primaryColor,
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        ),
                      ],
                    )
                  ],
                ),
              ));
        },
      ),
    ];
  }
}
