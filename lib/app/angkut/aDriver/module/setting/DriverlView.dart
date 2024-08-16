import 'package:enerren/app/angkut/aDriver/module/setting/DriverPresenter.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/model/menuModel.dart';
import 'package:enerren/module/setting/view.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

class DriverView extends View with CustomerPresenter {
  @override
  final double height = 250;

  VoidCallback changePassword;
  VoidCallback language;
  VoidCallback logout;

  DriverView({
    this.changePassword,
    this.language,
    this.logout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          super.build(context),
          DecorationComponent.circularLOadingIndicator(
              controller: loadingController)
        ],
      ),
    );
  }

  @override
  List<MenuModel> setMenus() {
    return <MenuModel>[
      MenuModel(
        textMenu: System.data.resource.changePassword,
        onTap: changePassword,
      ),
      MenuModel(
          textMenu: System.data.resource.goHome,
          iconWidget: Switch(
            value: statusGoHome,
            onChanged: (status) {
              setStatusGoHome(status);
            },
          )),
      MenuModel(
        textMenu: System.data.resource.language,
        onTap: language,
      ),
      MenuModel(
        textMenu: System.data.resource.logout,
        onTap: () {
          DecorationComponent.logOutPopUpDecoration(
              context: context, logout: () => signOut(logout));
        },
      ),
    ];
  }
}
