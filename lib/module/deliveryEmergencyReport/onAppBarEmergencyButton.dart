import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:enerren/util/boolExtention.dart';

import 'view.dart';

class OnAppBarEmergencyButton extends View {
  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      context: context,
      title: toBeginningOfSentenceCase(
          widget.titleLabel ?? System.data.resource.emergency),
      backgroundColor: System.data.colorUtil.primaryColor,
      titleColor: System.data.colorUtil.secondaryColor,
      backButtonColor: System.data.colorUtil.lightTextColor,
      actionText: toBeginningOfSentenceCase(System.data.resource.back),
      rightWidget: GestureDetector(
        onTap: () {
          setState(() {
            isCannotContinue = isCannotContinue.toggle();
          });
        },
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: SvgPicture.asset(
            isCannotContinue
                ? "assets/icon_emergency_on.svg"
                : "assets/icon_emergency.svg",
            color: isCannotContinue ? null : Colors.white,
            width: 30,
            height: 30,
          ),
        ),
      ),
    );
  }

  @override
  Widget confirmationCannotContinue() {
    return Container(
      height: 0,
      width: 0,
    );
  }
}
