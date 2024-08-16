import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      context: context,
      backgroundColor: System.data.colorUtil.primaryColor,
      backButtonColor: System.data.colorUtil.secondaryColor,
      actionText: System.data.resource.back,
      title: System.data.resource.history,
      titleColor: System.data.colorUtil.secondaryColor,
    );
  }


}
