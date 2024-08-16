import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/model/menuModel.dart';
import 'package:enerren/util/ResourceUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/app/tms/util/ResourceUtil.dart';

import 'view.dart';

class LanguageView extends View {
  final VoidCallback onTapId;
  final VoidCallback onTapEn;

  LanguageView({
    this.onTapId,
    this.onTapEn,
  });

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      title: System.data.resource.language,
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

  @override
  List<MenuModel> setMenus() {
    return <MenuModel>[
      MenuModel(
        textMenu: System.data.resource.english,
        icon: System.data.resource.lang == "en-US" ? Icons.check : null,
        onTap: () {
          if (onTapEn != null) {
            onTapEn();
          } else {
            System.data.resource = ResourceUtil();
            System.commit();
          }
        },
      ),
      MenuModel(
        icon: System.data.resource.lang == "id-ID" ? Icons.check : null,
        textMenu: System.data.resource.bahasaIndonesia,
        onTap: () {
          if (onTapId != null) {
            onTapId();
          } else {
            System.data.resource = ResourceUtil.ind().tmsId();
            System.commit();
          }
        },
      ),
    ];
  }
}
