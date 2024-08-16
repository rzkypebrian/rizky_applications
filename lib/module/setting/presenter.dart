import 'package:enerren/Util/SystemUtil.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/model/menuModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ResourceUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';

typedef MenuSource = List<MenuModel> Function();

class Presenter extends StatefulWidget {
  final State<Presenter> view;

  ///
  ///jika menu diisi memalui field ini maka menu akan bersifat final
  ///tidak terpengaruh oleh perubahan state apapaun baik state traditional ataupun provider dan bloc
  ///lebih baik gunakan teknik ''overide''
  ///
  final List<MenuModel> menus;

  const Presenter({Key key, this.menus, this.view}) : super(key: key);

  @override
  View createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  @override
  void initState() {
    loadingController.stopLoading();
    super.initState();
  }

  List<MenuModel> setMenus() {
    return widget.menus ??
        <MenuModel>[
          MenuModel(
              textMenu: System.data.resource.setting,
              onTap: () {
                setState(() {
                  System.data.resource = ResourceUtil.ind();
                });
              })
        ];
  }

  void updateState(VoidCallback fn) {
    setState(() {
      fn();
    });
  }

  void signOut(VoidCallback callback) {
    System.data.routes.pop(context);
    loadingController.startLoading();
    AccountModel.logout(
      token: System.data.global.token,
    ).then((onValue) {
      loadingController.stopLoading();
      if (callback != null) {
        callback();
      }
    }).catchError((onError) {
      loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError),
          ));
    });
  }
}
