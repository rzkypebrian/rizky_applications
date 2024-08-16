import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/listDataComponent.dart';
import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/model/tmsNotificationModel.dart';
import 'package:enerren/module/notification/presenter.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:enerren/util/StringExtention.dart';
import 'package:intl/intl.dart';

class View extends PresenerState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      context: context,
      backgroundColor: System.data.colorUtil.primaryColor,
      backButtonColor: System.data.colorUtil.secondaryColor,
      actionText: System.data.resource.back,
      title: System.data.resource.notification,
      titleColor: System.data.colorUtil.secondaryColor,
    );
  }

  Widget body() {
    return ListDataComponent<TmsNotificationModel>(
      controller: listDataController,
      getNewData: getNewNotification,
      getOldData: getOldNotification,
      loadingWidgetBuilder: progressIndicatorComponent,
      itemBuilder: (data, id) {
        return notificationItemView(data);
      },
    );
  }

  Widget progressIndicatorComponent(
      CircularProgressIndicatorController loadingController) {
    return widget.loadingIndicatorDecoration != null
        ? widget.loadingIndicatorDecoration(loadingController)
        : DecorationComponent.circularProgressDecoration(
            controller: loadingController,
            flareAnimation: widget.loadingAnimation,
            flareAssets: widget.loadingAnimationAssets,
          );
  }

  Widget notificationItemView(
    TmsNotificationModel notificationModel,
  ) {
    return GestureDetector(
      onTap: () {
        onTapNotification(notificationModel);
      },
      child: Container(
        height: 180,
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ]),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 10),
              alignment: Alignment.bottomRight,
              child: Text(
                  "${notificationModel?.messageDate == null ? "-" : DateFormat(System.data.resource.dateTimeFormat, System.data.resource.dateLocalFormat).format(notificationModel?.messageDate)}"),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 50,
                    height: double.infinity,
                    margin: EdgeInsets.only(right: 10),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 30,
                          width: 30,
                          margin: EdgeInsets.only(top: 10),
                          child: notificationModel != null
                              ? notificationModel.imageUrl.isNullOrEmpty()
                                  ? SvgPicture.asset(
                                      "assets/icon_notification.svg")
                                  : Image.network(
                                      "${notificationModel?.imageUrl}")
                              : SvgPicture.asset(
                                  "assets/icon_notification.svg"),
                        )),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${notificationModel?.titie ?? "-"}",
                          style: System.data.textStyleUtil.mainTitle(
                              color: System.data.colorUtil.darkTextColor),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${notificationModel?.message ?? "-"} ${notificationModel?.shipmentId}",
                          style: System.data.textStyleUtil.mainLabel(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
