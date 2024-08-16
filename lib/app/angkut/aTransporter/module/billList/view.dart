import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:component_icons/font_awesome.dart';

import 'main.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
        create: (BuildContext context) => model,
        child: Consumer<ViewModel>(builder: (ctx, vm, child) {
          return Scaffold(
            backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
            appBar: appBar(vm: vm),
            body: body(vm),
          );
        }));
  }

  PreferredSizeWidget appBar({ViewModel vm}) {
    return BottonComponent.customAppBar1(
      backgroundColor: System.data.colorUtil.primaryColor,
      actionText: "",
      context: context,
      backButtonColor: System.data.colorUtil.lightTextColor,
      title: System.data.resource.outCome,
      titleStyle: System.data.textStyleUtil.mainTitle(),
    );
  }

  Widget body(ViewModel vm) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            searchengine(vm),
            listData(model.filteredInvoice),
          ],
        ),
      ),
    );
  }

  Widget searchengine(ViewModel vm) {
    return Container(
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: System.data.colorUtil.lightTextColor,
        boxShadow: <BoxShadow>[
           BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: InputComponent.inputTextWithCorner(
                contentPadding: EdgeInsets.only(
                  top: 0,
                  right: 0,
                  bottom: 0,
                ),
                backgroundColor: System.data.colorUtil.lightTextColor,
                hintText: '',
                autoFocus: true,
                borderInputGray: System.data.colorUtil.primaryColor,
                controller: model.searchController,
                textInputAction: TextInputAction.done,
                prefixIcon: GestureDetector(
                  onTap: searchButton,
                  child: Icon(
                    FontAwesomeLight(FontAwesomeId.fa_search),
                    color: System.data.colorUtil.primaryColor,
                  ),
                ),
                onSubmited: (val) {},
                corner: 5,
                keyboardType: TextInputType.phone,
                onChanged: (str) {
                  super.model.filter();
                }),
          ),
          Container(
            margin: EdgeInsets.only(left: 5, right: 5, top: 13),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: InputComponent.inputTextWithCorner(
                        contentPadding: EdgeInsets.only(
                            top: 0, right: 0, bottom: 0, left: 10),
                        backgroundColor: System.data.colorUtil.lightTextColor,
                        hintText: '',
                        autoFocus: true,
                        borderInputGray: System.data.colorUtil.greyColor,
                        controller: model.dateController,
                        textInputAction: TextInputAction.done,
                        suffixIcon: GestureDetector(
                          onTap: () => selectDate(context),
                          child: Container(
                            decoration: BoxDecoration(
                              color: System.data.colorUtil.primaryColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                            child: Icon(
                              FontAwesomeLight(FontAwesomeId.fa_calendar_alt),
                              color: System.data.colorUtil.lightTextColor,
                            ),
                          ),
                        ),
                        onSubmited: (val) {},
                        corner: 5,
                        keyboardType: TextInputType.text),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  padding:
                      EdgeInsets.only(top: 0, right: 0, bottom: 0, left: 5),
                  decoration: BoxDecoration(
                    color: System.data.colorUtil.lightTextColor,
                    border: Border.all(color: System.data.colorUtil.greyColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      style: System.data.textStyleUtil
                          .mainLabel(fontSize: System.data.fontUtil.m),
                      icon: Container(
                        height: 47,
                        width: 37,
                        decoration: BoxDecoration(
                          color: System.data.colorUtil.primaryColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                        child: Icon(
                          FontAwesomeSolid(FontAwesomeId.fa_caret_down),
                          color: System.data.colorUtil.lightTextColor,
                        ),
                      ),
                      items: List.generate(vm.statusPayments.length, (i) {
                        return DropdownMenuItem<int>(
                          child:
                              Text("${vm.statusPayments.values.toList()[i]}"),
                          value: model.statusPayments.keys.toList()[i],
                        );
                      }),
                      onChanged: vm.setStatusPayment,
                      value: vm.statusPayment,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  padding:
                      EdgeInsets.only(top: 0, right: 0, bottom: 0, left: 5),
                  decoration: BoxDecoration(
                    color: System.data.colorUtil.lightTextColor,
                    border: Border.all(color: System.data.colorUtil.greyColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<bool>(
                      style: System.data.textStyleUtil
                          .mainLabel(fontSize: System.data.fontUtil.m),
                      icon: Container(
                        height: 47,
                        width: 37,
                        decoration: BoxDecoration(
                          color: System.data.colorUtil.primaryColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                        child: Icon(
                          FontAwesomeSolid(FontAwesomeId.fa_caret_down),
                          color: System.data.colorUtil.lightTextColor,
                        ),
                      ),
                      items: List.generate(vm.couriers.length, (i) {
                        return DropdownMenuItem<bool>(
                          child: Text("${model.couriers.values.toList()[i]}"),
                          value: model.couriers.keys.toList()[i],
                        );
                      }),
                      onChanged: vm.setCourier,
                      value: vm.courier,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listData(List<AngkutShipmentModel> data) {
    return Container(
      child: Column(
        children: List.generate(model.filteredInvoice.length, (i) {
          return GestureDetector(
            onTap: () {
              onTapBill(model.filteredInvoice[i]);
            },
            child: Container(
              height: 150,
              margin: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
              child: Stack(
                children: <Widget>[
                  Align(
                    child: SvgPicture.asset("assets/angkut/bg_node_gray.svg"),
                  ),
                  Align(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 30, right: 30, top: 4, bottom: 4),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                child: Text(
                                  "${model.filteredInvoice[i].shipmentNumber}",
                                  style: System.data.textStyleUtil.mainLabel(
                                      color:
                                          System.data.colorUtil.primaryColor),
                                ),
                              )),
                              Expanded(
                                  child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "${DateFormat(System.data.resource.dateFormat, System.data.resource.dateLocalFormat).format(model.filteredInvoice[i].shipmentDate)}",
                                  style: System.data.textStyleUtil.mainLabel(
                                      color:
                                          System.data.colorUtil.primaryColor),
                                ),
                              )),
                            ],
                          ),
                          Divider(
                            color: System.data.colorUtil.primaryColor,
                            thickness: 1,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${model.filteredInvoice[i].tmsShipmentDestinationList.first.driverName}",
                                    style: System.data.textStyleUtil.mainLabel(
                                        color:
                                            System.data.colorUtil.primaryColor),
                                  ),
                                )),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "${model.filteredInvoice[i].isInstant ? System.data.resource.instantCourier : System.data.resource.scheduled}",
                                      style: System.data.textStyleUtil
                                          .mainLabel(
                                              color: System
                                                  .data.colorUtil.primaryColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          inOutCome(model.filteredInvoice[i])
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget inOutCome(AngkutShipmentModel data) {
    return totalInOutCome(
      amount: data.takeHomePayTransporter,
      status: data.shipmentInvoice.billPayStatus,
    );
  }

  Widget totalInOutCome({
    int status,
    double amount,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Text(
                "Rp. ${NumberFormat("#,##0", System.data.resource.locale).format(amount ?? 0)}",
                style: System.data.textStyleUtil.mainLabel(
                  color: System.data.colorUtil.primaryColor,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            child: DecorationComponent.paidStatus(status,
                margin: EdgeInsets.only(
                  right: 0,
                )),
          ),
        ],
      ),
    );
  }
}
