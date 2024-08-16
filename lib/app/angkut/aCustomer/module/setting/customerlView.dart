import 'package:enerren/app/angkut/aCustomer/LocalData.dart';
import 'package:enerren/app/angkut/aDriver/module/setting/DriverPresenter.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/model/menuModel.dart';
import 'package:enerren/module/setting/view.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

class CustomerView extends View with CustomerPresenter {
  @override
  double height = 200;

  VoidCallback changePassword;
  VoidCallback language;
  VoidCallback logout;

  CustomerView({
    this.changePassword,
    this.language,
    this.logout,
  });

  @override
  void initHeight() {
    height = System.data.getLocal<LocalData>().user != null ? 200 : 150;
  }

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
    var menus = <MenuModel>[
      MenuModel(
        textMenu: System.data.resource.changePassword,
        onTap: changePassword,
      ),
      MenuModel(
        textMenu: System.data.resource.language,
        onTap: language,
      ),
    ];

    if (System.data.getLocal<LocalData>().user != null) {
      menus.add(MenuModel(
        textMenu: System.data.resource.logout,
        onTap: () {
          DecorationComponent.logOutPopUpDecoration(
              context: context, logout: () => signOut(logout));
        },
      ));
    }

    return menus;
  }
}
