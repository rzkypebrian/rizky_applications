import 'package:component_icons/font_awesome.dart';
import 'package:enerren/app/angkut/aCustomer/module/dashboard/view.dart';
import 'package:enerren/model/menuModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PeopleTransportView extends View {
  @override
  List<MenuModel> menuItem() {
    return [
      MenuModel(
        textMenu: System.data.resource.tackOrder,
        iconWidget: SvgPicture.asset("assets/angkut/track_order.svg",
            color: Colors.white),
        onTap: widget.onTapTrack,
      ),
      MenuModel(
          textMenu: System.data.resource.orderHistory,
          iconWidget: SvgPicture.asset("assets/angkut/History_order.svg",
              color: Colors.white),
          onTap: widget.onTapHistory),
      MenuModel(
          textMenu: System.data.resource.notification,
          iconWidget: Icon(
            FontAwesomeLight(FontAwesomeId.fa_bell),
            color: Colors.white,
            size: 23,
          ),
          onTap: widget.onTapNotification),
      MenuModel(
          textMenu: System.data.resource.help,
          iconWidget: SvgPicture.asset(
            "assets/angkut/help.svg",
            color: Colors.white,
          ),
          onTap: widget.onTapHelp),
      MenuModel(
          textMenu: System.data.resource.setting,
          iconWidget: SvgPicture.asset("assets/angkut/settings.svg",
              color: Colors.white),
          onTap: widget.onTapSetting),
    ];
  }
}
