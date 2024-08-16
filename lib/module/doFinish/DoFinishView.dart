import 'package:enerren/module/do/main.dart';
import 'package:enerren/module/doFinish/DoFinish.dart';
import 'package:enerren/module/doFinish/main.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class DoFinishView extends View with DoFinish {
  DoFinishView() {
    model.commit();
  }
  @override
  PreferredSizeWidget appBar(DoHomeViewer dt) {
    return BottonComponent.customAppBar1(
        title: System.data.resource.goodsReceipt,
        context: context,
        actionText: "",
        titleColor: System.data.colorUtil.secondaryColor,
        backButtonColor: System.data.colorUtil.lightTextColor,
        actionTextStyle: System.data.textStyleUtil.mainLabel(),
        actionTextColor: System.data.colorUtil.secondaryColor,
        titleStyle: System.data.textStyleUtil.mainTitle(),
        backgroundColor: System.data.colorUtil.primaryColor,
        rightWidget: null);
  }

  @override
  Widget angkutDecorationComponent() {
    return Container(
      child: DecorationComponent.circularProgressDecoration(
          controller: model.loadingController,
          aligment: Alignment.bottomCenter),
    );
  }

  @override
  Widget listDo(DoHomeViewer dt) {
    return dt.doModelList.length == 0
        ? Container(
            margin: EdgeInsets.only(
              top: 16,
            ),
            color: System.data.colorUtil.secondaryColor,
            height: 213,
            child: Center(
                child: Column(
              children: <Widget>[
                Container(
                  width: 192,
                  height: 90,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          "assets/angkut/bgBox.svg",
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          "assets/angkut/boxs.svg",
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    "${System.data.resource.thereIsNoItemListPleaseClickThePlusSignBelow}",
                    style: System.data.textStyleUtil.mainLabel(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )),
          )
        : Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 50,
                      child: Text(""),
                    ),
                    Container(
                      width: 30,
                      child: Text(
                        "${System.data.resource.number} ",
                        style: System.data.textStyleUtil
                            .linkLabel(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          "${System.data.resource.itemName} ",
                          style: System.data.textStyleUtil
                              .linkLabel(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    widget.showQtyField
                        ? Container(
                            width: 60,
                            child: Text(
                              "${System.data.resource.qty} ",
                              style: System.data.textStyleUtil
                                  .linkLabel(fontWeight: FontWeight.bold),
                            ),
                          )
                        : SizedBox(),
                    widget.showUnitField
                        ? Container(
                            width: 60,
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "${System.data.resource.unit} ",
                              style: System.data.textStyleUtil
                                  .linkLabel(fontWeight: FontWeight.bold),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 100),
                  child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: dt.doModelList.length,
                      controller: dt.scrollController,
                      itemBuilder: (ctx, i) {
                        return Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 50,
                                    height: 50,
                                    child: Container(
                                      child: Checkbox(
                                        value: dt.doModelList[i].isChecked,
                                        onChanged: (f) {
                                          dt.changeSelected(i);
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 30,
                                    child: Text("${i + 1}"),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  child: Text(
                                                    "${toBeginningOfSentenceCase(dt.doModelList[i].item)}",
                                                    style: System
                                                        .data.textStyleUtil
                                                        .linkLabel(
                                                            color: System
                                                                .data
                                                                .colorUtil
                                                                .darkTextColor),
                                                  ),
                                                ),
                                              ),
                                              widget.showQtyField
                                                  ? Container(
                                                      width: 60,
                                                      child: Text(
                                                          "${dt.doModelList[i].qty}",
                                                          style: System.data
                                                              .textStyleUtil
                                                              .linkLabel(
                                                                  color: System
                                                                      .data
                                                                      .colorUtil
                                                                      .darkTextColor)),
                                                    )
                                                  : SizedBox(),
                                              widget.showUnitField
                                                  ? Container(
                                                      width: 60,
                                                      child: Text(
                                                          "${dt.doModelList[i].uomName}",
                                                          style: System.data
                                                              .textStyleUtil
                                                              .linkLabel(
                                                                  color: System
                                                                      .data
                                                                      .colorUtil
                                                                      .darkTextColor)),
                                                    )
                                                  : SizedBox()
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(5),
                                          ),
                                          Container(
                                            child: Text(
                                              "${toBeginningOfSentenceCase(dt.doModelList[i].itemDescription)}",
                                              style: System.data.textStyleUtil
                                                  .linkLabel(
                                                      color: System
                                                          .data
                                                          .colorUtil
                                                          .darkTextColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Divider(
                                color: System.data.colorUtil.disableColor,
                                height: 2,
                              ),
                            )
                          ],
                        );
                      }),
                ),
              ),
            ],
          );
  }

  @override
  Widget add(DoHomeViewer dt) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(left: 33, right: 33, bottom: 29),
        child: BottonComponent.roundedButton(
          textColor: System.data.colorUtil.lightTextColor,
          colorBackground: System.data.colorUtil.primaryColor,
          text: System.data.resource.save,
          onPressed: saveDoFinishItem,
          textstyle: System.data.textStyleUtil.mainLabel(
              color: System.data.colorUtil.lightTextColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
