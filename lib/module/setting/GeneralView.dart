import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/ModalComponent.dart' as modal;
import 'package:enerren/model/menuModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'view.dart';
import 'package:flutter/material.dart';

class GeneralView extends View {
  @override
  final double height = 250;

  VoidCallback changePassword;
  VoidCallback language;
  VoidCallback about;
  VoidCallback logout;

  GeneralView({
    this.changePassword,
    this.language,
    this.about,
    this.logout,
  });

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  List<MenuModel> setMenus() {
    return <MenuModel>[
      MenuModel(
        textMenu: System.data.resource.changePassword,
        onTap: changePassword,
      ),
      MenuModel(
        textMenu: System.data.resource.language,
        onTap: language,
      ),
      MenuModel(
        textMenu: System.data.resource.about,
        onTap: about,
      ),
      MenuModel(
        textMenu: System.data.resource.logout,
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
