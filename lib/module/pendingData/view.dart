import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/listDataComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/PendingDataModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presenter.dart';
import 'package:enerren/util/StringExtention.dart';
import 'viewModel.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
      appBar: BottonComponent.customAppBar1(
        context: context,
        actionText: "",
        title: System.data.resource.pendingData,
        backgroundColor: System.data.colorUtil.primaryColor,
        titleStyle: System.data.textStyleUtil.mainTitle(),
        backButtonColor: System.data.colorUtil.lightTextColor,
        rightWidget: GestureDetector(
          onTap: () {
            sendAllItem();
          },
          child: Container(
            padding: EdgeInsets.only(right: 15),
            child: Text(
              System.data.resource.sendAll,
              style: System.data.textStyleUtil.mainLabel(
                color: System.data.colorUtil.lightTextColor,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ChangeNotifierProvider.value(
            value: super.model,
            child: ListDataComponent(
              controller: model.pendingDataModelController,
              getNewData: widget.fromFile
                  ? model.getNewPendingDataFromFile
                  : model.getNewPendingData,
              getOldData: widget.fromFile
                  ? model.getNewPendingDataFromFile
                  : model.getOldPendingData,
              loadingWidgetBuilder: (loadingController) {
                return DecorationComponent.circularProgressDecoration(
                  controller: loadingController,
                );
              },
              itemBuilder: (data, i) {
                return pendingDataItem(data, i);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget actionButton(PendingDataModel pendingDataModel,
      CircularProgressIndicatorController itemController, int index) {
    return itemController.onLoading == false
        ? Center(
            child: pendingDataModel.status == PendingDataStatus.inputNew
                ? sendButton(pendingDataModel, itemController)
                : pendingDataModel.status == PendingDataStatus.failed
                    ? reSendButton(pendingDataModel, itemController)
                    : pendingDataModel.status == PendingDataStatus.sent
                        ? removeButton(pendingDataModel, itemController, index)
                        : Container(
                            height: 0,
                            width: 0,
                          ),
          )
        : Container(
            height: 0,
            width: 0,
          );
  }

  Widget sendButton(PendingDataModel pendingDataModel,
      CircularProgressIndicatorController itemController) {
    return Container(
      height: 25,
      width: 80,
      child: BottonComponent.roundedButton(
          text: System.data.resource.send,
          colorBackground: Colors.transparent,
          border: Border.all(
            color: System.data.colorUtil.primaryColor,
          ),
          textstyle: System.data.textStyleUtil.mainLabel(
            color: System.data.colorUtil.primaryColor,
          ),
          onPressed: () {
            sendItem(
              pendingDataModel,
              itemController,
            );
          }),
    );
  }

  Widget reSendButton(PendingDataModel pendingDataModel,
      CircularProgressIndicatorController itemController) {
    return Container(
      height: 25,
      width: 80,
      child: BottonComponent.roundedButton(
        text: System.data.resource.resend,
        colorBackground: Colors.transparent,
        border: Border.all(
          color: System.data.colorUtil.redColor,
        ),
        textstyle: System.data.textStyleUtil.mainLabel(
          color: System.data.colorUtil.redColor,
        ),
        onPressed: () {
          sendItem(pendingDataModel, itemController);
        },
      ),
    );
  }

  Widget removeButton(
    PendingDataModel pendingDataModel,
    CircularProgressIndicatorController itemController,
    int index,
  ) {
    return Container(
      height: 25,
      width: 80,
      child: BottonComponent.roundedButton(
        text: System.data.resource.remove,
        colorBackground: Colors.transparent,
        border: Border.all(
          color: System.data.colorUtil.greenColor,
        ),
        textstyle: System.data.textStyleUtil.mainLabel(
          color: System.data.colorUtil.greenColor,
        ),
        onPressed: () {
          removeItem(pendingDataModel, itemController, index);
        },
      ),
    );
  }

  Widget pendingDataItem(PendingDataModel pendingDataModel, int index) {
    return Consumer<ViewModel>(
      builder: (c, d, h) {
        return Container(
          height: itemHeight(pendingDataModel),
          width: itemWidth(),
          margin: itemMargin(),
          padding: itemPading(),
          decoration: itemDecoration(),
          child: Column(
            children: <Widget>[
              itemHeader(pendingDataModel),
              Divider(
                color: Colors.grey,
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: itemBody(pendingDataModel),
                            ),
                          ),
                          Container(
                            width: 80,
                            child: actionButton(
                                pendingDataModel,
                                super
                                    .model
                                    .loadingController[pendingDataModel.id],
                                index),
                          ),
                        ],
                      ),
                      itemCircularProgressIndicatorDecoration(
                          super.model.loadingController[pendingDataModel.id])
                    ],
                  ),
                ),
              ),
              messageContainer(pendingDataModel),
            ],
          ),
        );
      },
    );
  }

  BoxDecoration itemDecoration() {
    return BoxDecoration(
      color: Colors.white,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: System.data.colorUtil.shadowColor.withOpacity(0.2),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    );
  }

  Widget messageContainer(PendingDataModel pendingDataModel) {
    return model.messageStatus[pendingDataModel.id].isNullOrEmpty()
        ? Container(
            height: 0,
            width: 0,
          )
        : Container(
            width: double.infinity,
            height: 14.5,
            child: Text(
              "${model.messageStatus[pendingDataModel.id]}",
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: System.data.textStyleUtil.mainLabel(
                color: pendingDataModel.status == PendingDataStatus.failed
                    ? System.data.colorUtil.redColor
                    : System.data.colorUtil.primaryColor,
              ),
            ),
          );
  }

  double itemHeight(PendingDataModel pendingDataModel) {
    return 100;
  }

  double itemWidth() {
    return double.infinity;
  }

  EdgeInsets itemMargin() {
    return EdgeInsets.only(top: 20);
  }

  EdgeInsets itemPading() {
    return EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10);
  }

  Widget itemHeader(PendingDataModel pendingDataModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("#${pendingDataModel.id} ${pendingDataModel.key}"),
        Text(pendingDataModel.dataType)
      ],
    );
  }

  Widget itemBody(PendingDataModel pendingDataModel) {
    return Text(
      "${pendingDataModel.dataType}",
      overflow: TextOverflow.fade,
      softWrap: true,
    );
  }

  Widget itemCircularProgressIndicatorDecoration(
      CircularProgressIndicatorController itemController) {
    return CircularProgressIndicatorComponent(
      coverScreen: false,
      aligment: Alignment.centerRight,
      controller: itemController,
      flareAnimation: "play",
      flareAssets: "assets/flares/sample/loading_beton.flr",
    );
  }
}
