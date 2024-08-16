import 'package:enerren/component/menuComponent.dart';
import 'package:enerren/model/menuModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:enerren/module/menu/view.dart';

class AngkutView extends View {
  @override
  Decoration decoration() {
    return BoxDecoration(
      color: Colors.transparent,
    );
  }

  @override
  Container mainMenu(List<MenuModel> listMenus) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(top: 0),
      alignment: MediaQuery.of(context).orientation == Orientation.portrait
          ? Alignment.center
          : Alignment.topLeft,
      child: Center(
        child: Wrap(
          spacing: 2,
          alignment: WrapAlignment.start,
          children: List.generate(listMenus.length, (index) {
            return MenuComponent.circleMenu(
              textMenu: listMenus[index].textMenu,
              onTap: listMenus[index].onTap,
              textMenuStyle: System.data.textStyleUtil.mainLabel(
                fontSize: System.data.fontUtil.s,
              ),
              intBedge: listMenus[index].intBadge,
              menu: Container(
                child: SvgPicture.asset("${listMenus[index].immageAssetUrl}"),
              ),
            );
          }),
        ),
      ),
    );
  }
}
