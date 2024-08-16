import 'dart:ui';

import 'package:enerren/util/ModeUtil.dart';
import 'package:flutter/material.dart';

///
/// model untuk membuat menu
/// [textMenu] label dari menu
/// [onTap] callvack saat menu di tap
/// [icon] icon dari menu bisa menggunakan fontawesome
/// [intBadge] nilai badge seperti nitif berupa angka
/// [iconMargin] nilai margin untuk icon, digunakan untuk pnyesuaian tata letak icon
///
///
class MenuModel {
  String textMenu;
  VoidCallback onTap;
  IconData icon;
  int intBadge;
  EdgeInsets iconMargin;
  String immageAssetUrl;
  double iconHeight;
  double iconWidht;
  Widget iconWidget;

  MenuModel({
    this.textMenu,
    this.onTap,
    this.icon,
    this.intBadge,
    this.iconMargin = const EdgeInsets.all(0),
    this.immageAssetUrl,
    this.iconHeight,
    this.iconWidht,
    this.iconWidget,
  });

  ///
  ///[dummy()] sample penggunaan class
  ///
  static List<MenuModel> dummy() {
    return <MenuModel>[
      MenuModel(
          textMenu: "Menu 1",
          onTap: () => onTapMenu("Menu 1"),
          icon: Icons.add_box),
      MenuModel(
          textMenu: "Menu 2",
          onTap: () => onTapMenu("Menu 2"),
          icon: Icons.add_box),
      MenuModel(
        textMenu: "Menu 3",
        onTap: () => onTapMenu("Menu 3"),
        icon: Icons.add_box,
      ),
      MenuModel(
          textMenu: "Menu 4",
          onTap: () => onTapMenu("Menu 4"),
          icon: Icons.add_box,
          iconMargin: EdgeInsets.only(right: 5)),
      MenuModel(
          textMenu: "Menu 5",
          onTap: () => onTapMenu("Menu 5"),
          icon: Icons.add_box,
          iconMargin: EdgeInsets.only(right: 3)),
      MenuModel(
          textMenu: "Menu 6",
          onTap: () => onTapMenu("Menu 6"),
          icon: Icons.add_box),
      MenuModel(
          textMenu: "Menu 7",
          onTap: () => onTapMenu("Menu 7"),
          icon: Icons.add_box,
          iconMargin: EdgeInsets.only(right: 5)),
      MenuModel(
          textMenu: "Menu 8",
          onTap: () => onTapMenu("Menu 8"),
          icon: Icons.add_box),
      MenuModel(
          textMenu: "Menu 9",
          onTap: () => onTapMenu("Menu 9"),
          icon: Icons.add_box),
    ];
  }

  Map<String, dynamic> toJson() {
    return {
      "textMenu": "$textMenu",
      "onTap": "$onTap",
      "icon": "$Icon",
      "intBadge": "$intBadge",
      "iconMargin": "$iconMargin",
    };
  }

  static void onTapMenu(String menuName) {
    ModeUtil.debugPrint("menu tapped $menuName");
  }
}
