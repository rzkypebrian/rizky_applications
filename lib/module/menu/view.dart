import 'package:enerren/util/InternalDataUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:provider/provider.dart';
import '../../model/menuModel.dart';
import 'package:enerren/component/menuComponent.dart';

import 'presenter.dart';
import 'package:flutter/material.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? EdgeInsets.only(bottom: 40, left: 15, right: 15),
      padding: widget.padding ?? EdgeInsets.all(0),
      width: widget.width,
      height: widget.heigth,
      decoration: decoration(),
      child: ListView(padding: EdgeInsets.only(top: 0), children: <Widget>[
        Consumer<InternalDataUtil>(
          builder: (context, data, child) {
            return mainMenu(
              widget.menus() ?? [],
            );
          },
        ),
      ]),
    );
  }

  Decoration decoration() {
    return BoxDecoration(
      color: System.data.colorUtil.scafoldColor,
      borderRadius: BorderRadius.all(Radius.circular(14)),
      boxShadow: [
         BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
      ],
    );
  }

  Container mainMenu(List<MenuModel> listMenus) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(top: 0),
      alignment: MediaQuery.of(context).orientation == Orientation.portrait
          ? Alignment.center
          : Alignment.topLeft,
      child: Container(
        child: Center(
          child: Wrap(
            spacing: 2,
            alignment: WrapAlignment.start,
            children: List.generate(listMenus.length, (index) {
              return MenuComponent.circleMenu(
                textMenu: listMenus[index].textMenu,
                onTap: listMenus[index].onTap,
                iconMenu: listMenus[index].icon,
                intBedge: listMenus[index].intBadge,
                iconMargin: listMenus[index].iconMargin,
              );
            }),
          ),
        ),
      ),
    );
  }
}
