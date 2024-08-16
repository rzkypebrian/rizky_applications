import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/tmsShipmentDestinationModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:component_icons/font_awesome.dart';
import 'package:enerren/module/do/DoHomeViewer.dart';
import 'presenter.dart';
import 'package:enerren/model/ShipmentItemDescriptionViewModel.dart';
import 'package:enerren/model/UomModel.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DoHomeViewer>(
      create: (BuildContext context) => model,
      child: Consumer<DoHomeViewer>(
        builder: (ctx, dt, child) {
          return Scaffold(
            backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
            appBar: appBar(dt),
            body: home(dt),
          );
        },
      ),
    );
  }

  PreferredSizeWidget appBar(DoHomeViewer dt) {
    return BottonComponent.customAppBar1(
      title: System.data.resource.checkingGoods,
      context: context,
      actionText: "",
      titleColor: System.data.colorUtil.secondaryColor,
      backButtonColor: System.data.colorUtil.lightTextColor,
      actionTextStyle: System.data.textStyleUtil.mainLabel(),
      actionTextColor: System.data.colorUtil.secondaryColor,
      titleStyle: System.data.textStyleUtil.mainTitle(),
      backgroundColor: System.data.colorUtil.primaryColor,
      rightWidget: model.doModelList.length == 0
          ? null
          : GestureDetector(
              onTap: dt.choises,
              child: Container(
                margin: EdgeInsets.only(right: 5),
                child: Text(
                  dt.choise
                      ? "${System.data.resource.cancel}"
                      : "${System.data.resource.select}",
                  style: System.data.textStyleUtil.titleTable(
                    fontWeight: FontWeight.bold,
                    fontSize: System.data.fontUtil.l,
                    color: System.data.colorUtil.secondaryColor,
                  ),
                ),
              ),
            ),
    );
  }

  Widget angkutDecorationComponent() {
    return DecorationComponent.circularProgressDecoration(
      controller: model.loadingController,
    );
  }

  Widget home(DoHomeViewer dt) {
    return Container(
      color: System.data.colorUtil.scaffoldBackgroundColor,
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          listDo(dt),
          add(dt),
          angkutDecorationComponent(),
        ],
      ),
    );
  }

  Widget listDo(DoHomeViewer dt) {
    return dt.doModelList.length == 0
        ? Container(
            margin: EdgeInsets.only(top: 16),
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
                          "assets/bgBox.svg",
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          widget.iconGoodsAssets ?? "assets/boxs.svg",
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                description(),
              ],
            )),
          )
        : Column(
            children: <Widget>[
              dt.choise
                  ? Container(
                      padding: EdgeInsets.only(right: 7),
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                "${System.data.resource.totalSelected} ${dt.getTotalCheck != 0 ? dt.getTotalCheck : ""}",
                                style: System.data.textStyleUtil
                                    .linkLabel(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Text(
                            "${System.data.resource.selectAll}",
                            style: System.data.textStyleUtil
                                .linkLabel(fontWeight: FontWeight.bold),
                          ),
                          Checkbox(
                              value: dt.checkAll,
                              onChanged: (f) => dt.checkAlls())
                        ],
                      ),
                    )
                  : Container(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: dt.choise ? 40 : 0),
                  child: ListView(
                    children: List.generate(
                        doModelController.destinations.length, (id) {
                      return dt.doModelList
                              .where((e) =>
                                  e.podDetailshipmentId ==
                                  doModelController
                                      .destinations[id].detailshipmentId)
                              .toList()
                              .isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "${System.data.resource.destination} ${id + 1}",
                                    style: System.data.textStyleUtil.linkLabel(
                                      fontSize: System.data.fontUtil.l,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: List.generate(
                                        dt.doModelList.length, (i) {
                                      return dt.doModelList[i]
                                                  .podDetailshipmentId ==
                                              doModelController.destinations[id]
                                                  .detailshipmentId
                                          ? Container(
                                              color: System.data.colorUtil
                                                  .secondaryColor,
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20, right: 13),
                                                    child: SvgPicture.asset(
                                                      widget.iconGoodsAssets ??
                                                          'assets/boxs.svg',
                                                      height: 38,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          right: 10,
                                                          top: 10,
                                                          bottom: 10),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                              bottom: 10,
                                                            ),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    child: Text(
                                                                        "${dt.doModelList[i].item}"),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 100,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: <
                                                                        Widget>[
                                                                      widget.showQtyField
                                                                          ? Container(
                                                                              child: Text("${dt.doModelList[i].qty}"),
                                                                            )
                                                                          : SizedBox(),
                                                                      widget.showUnitField
                                                                          ? Container(
                                                                              margin: EdgeInsets.only(right: 36),
                                                                              child: Text("${dt.doModelList[i].uomName}"),
                                                                            )
                                                                          : SizedBox()
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                              child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: Container(
                                                                    child: Text(
                                                                        "${dt.doModelList[i].itemDescription}")),
                                                              ),
                                                              dt.choise
                                                                  ? Container(
                                                                      width: 40,
                                                                      height:
                                                                          40,
                                                                      child: Checkbox(
                                                                          value: dt
                                                                              .doModelList[
                                                                                  i]
                                                                              .isChecked,
                                                                          onChanged: (f) =>
                                                                              dt.changeSelected(i)),
                                                                    )
                                                                  : Container(),
                                                            ],
                                                          )),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ))
                                          : SizedBox();
                                    }),
                                  ),
                                )
                              ],
                            )
                          : SizedBox();
                    }),
                  ),
                ),
              ),
            ],
          );
  }

  Widget add(DoHomeViewer dt) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: dt.choise && dt.doModelList.length > 0
          ? Container(
              color: System.data.colorUtil.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  dt.getTotalCheck > 1
                      ? Container(
                          margin: EdgeInsets.only(right: 7, left: 12),
                          child:
                              SvgPicture.asset("assets/angkut/notdelete.svg"))
                      : IconButton(
                          color: System.data.colorUtil.secondaryColor,
                          icon: Icon(FontAwesomeLight(FontAwesomeId.fa_edit)),
                          onPressed: () {
                            if (dt.getTotalCheck == 1) {
                              updateData(dt);
                            }
                          },
                        ),
                  IconButton(
                      color: System.data.colorUtil.secondaryColor,
                      icon: Icon(FontAwesomeLight(FontAwesomeId.fa_trash_alt)),
                      onPressed: () {
                        if (dt.getTotalCheck != 0) {
                          removePopUp(dt);
                        }
                      }),
                ],
              ),
            )
          : Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: System.data.colorUtil.shadowColor.withOpacity(0.2),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ]),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      iconSize: 41,
                      color: System.data.colorUtil.primaryColor,
                      icon: Icon(Icons.add_circle),
                      onPressed: () => showUp(dt),
                    ),
                  ),
                  model.doModelList.length > 0
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    next();
                                  },
                                  child: Text(
                                    System.data.resource.next,
                                    style: System.data.textStyleUtil.mainLabel(
                                      color: System.data.colorUtil.primaryColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    next();
                                  },
                                  child: Icon(
                                    FontAwesomeLight(
                                        FontAwesomeId.fa_arrow_right),
                                    size: 15,
                                    color: System.data.colorUtil.primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          height: 0,
                          width: 0,
                        )
                ],
              ),
            ),
    );
  }

  void removePopUp(DoHomeViewer dt) {
    ModalComponent.bottomModalWithCorner(context,
        height: MediaQuery.of(context).size.height - 290,
        child: Container(
          height: MediaQuery.of(context).size.height - 290 - 16,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            color: System.data.colorUtil.primaryColor,
                            child: Center(
                                child: Text(
                              "${System.data.resource.yes}",
                              style: System.data.textStyleUtil.mainLabel(
                                  fontWeight: FontWeight.bold,
                                  color: System.data.colorUtil.secondaryColor),
                            )),
                          ),
                          onTap: () {
                            // dt.delete();
                            deleteDo();
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            color: System.data.colorUtil.greyColor,
                            child: Center(
                                child: Text(
                              "${System.data.resource.no}",
                              style: System.data.textStyleUtil.mainLabel(
                                  fontWeight: FontWeight.bold,
                                  color: System.data.colorUtil.secondaryColor),
                            )),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: 31,
                        height: 31,
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: System.data.colorUtil.greyColor
                                        .withOpacity(.5)),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: System.data.colorUtil.greyColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: SvgPicture.asset("assets/angkut/delete_bg.svg"),
                      ),
                      Container(
                        child: Text(
                          "${System.data.resource.areYouSureWantToDeleteThisData}",
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void showUp(DoHomeViewer dt) {
    doModelController.value.podDetailshipmentId = null;
    doModelController.commit();
    ModalComponent.bottomModalWithCorner(
      context,
      height: MediaQuery.of(context).size.height - 290,
      child: Container(
        height: MediaQuery.of(context).size.height - 290 - 16,
        child: ValueListenableBuilder<ShipmentItemDescriptionViewModel>(
          valueListenable: doModelController,
          builder: (context, value, child) {
            return Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 30,
                    width: 45,
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(FontAwesomeLight(
                                  FontAwesomeId.fa_grip_lines))),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Icon(FontAwesomeLight(
                                  FontAwesomeId.fa_grip_lines))),
                        ],
                      ),
                    ),
                  ),
                ),
                contenBottomSheet(value: value),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: System.data.colorUtil.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: IconButton(
                        iconSize: 20,
                        color: System.data.colorUtil.secondaryColor,
                        icon: Icon(FontAwesomeLight(FontAwesomeId.fa_save)),
                        onPressed: () {
                          addDo();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void updateData(
    DoHomeViewer dt,
  ) {
    doModelController.setDoModel(dt.selectedDoModel);
    doModelController.value.qtyItemCOntroller.text =
        dt.selectedDoModel.qty.toString();
    doModelController.value.itemNameContoller.text = dt.selectedDoModel.item;
    doModelController.value.itemDescController.text =
        dt.selectedDoModel.itemDescription;
    ModalComponent.bottomModalWithCorner(
      context,
      height: MediaQuery.of(context).size.height - 290,
      child: Container(
        height: MediaQuery.of(context).size.height - 290 - 16,
        child: ValueListenableBuilder<ShipmentItemDescriptionViewModel>(
          valueListenable: doModelController,
          builder: (context, value, child) {
            return Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 30,
                    width: 45,
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(FontAwesomeLight(
                                  FontAwesomeId.fa_grip_lines))),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Icon(FontAwesomeLight(
                                  FontAwesomeId.fa_grip_lines))),
                        ],
                      ),
                    ),
                  ),
                ),
                contenBottomSheet(value: value),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: System.data.colorUtil.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: IconButton(
                        iconSize: 20,
                        color: System.data.colorUtil.secondaryColor,
                        icon: Icon(FontAwesomeLight(FontAwesomeId.fa_save)),
                        onPressed: () {
                          Navigator.of(context).pop();
                          updateDo();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget contenBottomSheet({
    ShipmentItemDescriptionViewModel value,
  }) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: 25),
        padding: EdgeInsets.all(20),
        height: 365,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "${System.data.resource.itemName}",
                              style: System.data.textStyleUtil.titleTable(
                                  color: System.data.colorUtil.primaryColor),
                            ),
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.only(top: 10, right: 10),
                            child: InputComponent.inputTextWithCorner(
                              onChanged: (s) {
                                value.item = s;
                              },
                              contentPadding:
                                  EdgeInsets.only(left: 10, right: 10),
                              borderInputGray: doModelController
                                          .value.itemNameContoller.stateInput ==
                                      StateInput.Error
                                  ? System.data.colorUtil.redColor
                                  : System.data.colorUtil.darkTextColor,
                              borderWidth: 1,
                              controller:
                                  doModelController.value.itemNameContoller,
                              corner: 5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  widget.showQtyField
                      ? Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "${System.data.resource.qty}",
                                    style: System.data.textStyleUtil.titleTable(
                                        color:
                                            System.data.colorUtil.primaryColor),
                                  ),
                                ),
                                qtyFreeText(value),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  widget.showUnitField
                      ? Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "${System.data.resource.unit}",
                                    style: System.data.textStyleUtil.titleTable(
                                        color:
                                            System.data.colorUtil.primaryColor),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: System
                                              .data.colorUtil.darkTextColor),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<UomModel>(
                                        hint: Text(
                                            "${System.data.resource.select}"),
                                        value: doModelController
                                            .getDefaultUomModel(
                                                uomCode: value.uomCode),
                                        items: doModelController.units.map((f) {
                                          return DropdownMenuItem<UomModel>(
                                              child: Text(f.uomName), value: f);
                                        }).toList(),
                                        onChanged: doModelController.changeUnit,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      "${System.data.resource.destination}",
                      style: System.data.textStyleUtil.titleTable(
                          color: System.data.colorUtil.primaryColor),
                    ),
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: System.data.colorUtil.darkTextColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<TmsShipmentDestinationModel>(
                          hint: Container(
                            width: MediaQuery.of(context).size.width - 90,
                            child: Text("${System.data.resource.select}"),
                          ),
                          value: doModelController.getDefaultDestinationModel(
                              destinationid: value.podDetailshipmentId),
                          items: List.generate(
                            doModelController.destinations.length,
                            (i) {
                              return DropdownMenuItem<
                                  TmsShipmentDestinationModel>(
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 90,
                                  child: Row(
                                    children: [
                                      Text(
                                          "${System.data.resource.destination} ${i + 1}" ??
                                              ""),
                                      Text(" - "),
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            "${doModelController.destinations[i].destinationAddress ?? "-"}" ??
                                                "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                value: doModelController.destinations[i],
                              );
                            },
                          ),
                          onChanged: doModelController.changeDestination,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      "${System.data.resource.description}",
                      style: System.data.textStyleUtil.titleTable(
                          color: System.data.colorUtil.primaryColor),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: InputComponent.inputTextWithCorner(
                        contentPadding:
                            EdgeInsets.only(left: 10, right: 10, top: 20),
                        borderInputGray: doModelController
                                    .value.itemDescController.stateInput ==
                                StateInput.Error
                            ? System.data.colorUtil.redColor
                            : System.data.colorUtil.darkTextColor,
                        borderWidth: 1,
                        maxLines: 6,
                        onChanged: (s) {
                          value.itemDescription = s;
                        },
                        controller: doModelController.value.itemDescController,
                        corner: 5),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget description() {
    return Container(
      child: Text(
        "${System.data.resource.thereIsNoItemListPleaseClickThePlusSignBelow}",
        style: System.data.textStyleUtil.mainLabel(),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget qtySpinner(ShipmentItemDescriptionViewModel value) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(top: 10),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 30,
              height: 50,
              decoration: BoxDecoration(
                color: System.data.colorUtil.primaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: () {
                        doModelController.changeTotal(true);
                      },
                      child: Container(
                        height: 24,
                        child: Center(
                          child: Icon(
                            FontAwesomeSolid(FontAwesomeId.fa_sort_up),
                            color: System.data.colorUtil.secondaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        doModelController.changeTotal(false);
                      },
                      child: Container(
                        height: 25,
                        child: Center(
                          child: Icon(
                            FontAwesomeSolid(FontAwesomeId.fa_sort_down),
                            color: System.data.colorUtil.secondaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 70,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: doModelController
                                  .value.qtyItemCOntroller.stateInput ==
                              StateInput.Error
                          ? System.data.colorUtil.redAppBarColor
                          : System.data.colorUtil.darkTextColor),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))),
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  "${value.qty}",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget qtyFreeText(ShipmentItemDescriptionViewModel value) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 10),
      child: InputComponent.inputTextWithCorner(
          controller: doModelController.value.qtyItemCOntroller,
          textAlign: TextAlign.start,
          keyboardType: TextInputType.number,
          fontSize: System.data.fontUtil.xl,
          numberOnly: true,
          contentPadding: EdgeInsets.only(bottom: 10, left: 10),
          onChanged: (v) {
            value.qty =
                int.parse(doModelController.value.qtyItemCOntroller.content);
          }),
    );
  }
}
