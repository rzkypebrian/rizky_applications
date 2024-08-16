import 'package:enerren/component/menuComponent.dart';
import 'package:enerren/model/menuModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import "package:enerren/module/menu/main.dart";

class SieradView extends View {
  @override
  Decoration decoration() {
    return BoxDecoration(
      color: Colors.transparent,
    );
  }

  @override
  Container mainMenu(List<MenuModel> listMenus) {
    return Container(
      padding: EdgeInsets.only(top: 0),
      alignment: MediaQuery.of(context).orientation == Orientation.portrait
          ? Alignment.center
          : Alignment.topLeft,
      child: Center(
        child: Wrap(
          spacing: 2,
          alignment: WrapAlignment.start,
          children: List.generate(
            listMenus.length,
            (index) {
              return MenuComponent.circleMenu(
                textMenu: listMenus[index].textMenu,
                onTap: listMenus[index].onTap,
                iconMenu: listMenus[index].icon,
                colorRxtMenu: Colors.black,
                intBedge: listMenus[index].intBadge,
                iconMargin: listMenus[index].iconMargin,
                backgroundColor: System.data.colorUtil.secondaryColor,
                menu: SvgPicture.asset("${listMenus[index].immageAssetUrl}",
                    width: listMenus[index].iconWidht,
                    height: listMenus[index].iconHeight),
                neonStyle: false,
                textMenuStyle: System.data.textStyleUtil.mainLabel(
                  color: System.data.colorUtil.darkTextColor,
                ),
                shadow: <BoxShadow>[
                   BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
