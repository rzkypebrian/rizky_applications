import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/menuModel.dart';
import 'package:enerren/util/InternalDataUtil.dart';
import 'package:provider/provider.dart';
import '../../Util/SystemUtil.dart';
import 'presenter.dart';
import 'package:flutter/material.dart';

class View extends PresenterState {
  double height = 150;

  void initHeight() {
    height = height;
  }

  @override
  Widget build(BuildContext context) {
    initHeight();
    return Consumer<InternalDataUtil>(
      builder: (context, data, child) {
        List<MenuModel> menus = setMenus();
        return Scaffold(
          body: Stack(
            children: <Widget>[
              Scaffold(
                backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
                appBar: appBar(),
                body: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                       BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
                    ],
                  ),
                  height: height,
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: ListView(
                    children: List.generate(menus?.length, (i) {
                      return item(menus[i]);
                    }),
                  ),
                ),
              ),
              circularProgressIndicatorDecoration(),
            ],
          ),
        );
      },
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return CircularProgressIndicatorComponent(
      controller: loadingController,
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      title: System.data.resource.setting,
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

  Widget item(MenuModel menuModel) {
    return Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            style: BorderStyle.solid,
            color: Colors.grey,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Container(
          margin: EdgeInsets.all(0),
          child: Text(
            menuModel.textMenu,
            style: System.data.textStyleUtil.mainLabel(),
          ),
        ),
        trailing: menuModel.iconWidget ??
            Icon(
              menuModel.icon,
              color: System.data.colorUtil.primaryColor,
            ),
        onTap: () {
          setState(() {
            menuModel.onTap();
          });
        },
      ),
    );
  }
}
