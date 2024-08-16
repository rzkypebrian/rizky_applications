import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/model/AttendanceModel.dart';
import 'package:enerren/model/CheckStatus.dart';
import 'package:enerren/util/InputData.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'viewModel.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (BuildContext context) => model,
      child: Consumer<ViewModel>(builder: (ctx, vm, child) {
        return Scaffold(
          backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
          appBar: appBar(),
          body: Stack(
            children: <Widget>[
              body(model),
              Container(
                child: circularProgressIndicator(),
              ),
            ],
          ),
        );
      }),
    );
  }

  PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      context: context,
      actionText: "",
      backButtonColor: System.data.colorUtil.lightTextColor,
      backgroundColor: System.data.colorUtil.color009789,
      title: System.data.resource.listAttendance,
      titleStyle: System.data.textStyleUtil.mainTitle(
        color: System.data.colorUtil.lightTextColor,
        fontSize: System.data.fontUtil.lPlus,
      ),
    );
  }

  Widget circularProgressIndicator() {
    return DecorationComponent.circularProgressDecoration(
      controller: model.loadingController,
    );
  }

  Widget body(ViewModel model) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            tabHeader(model),
            Align(
              alignment: Alignment.topLeft,
              child: model.currentIndexTab == 1
                  ? searchAndFilter(model)
                  : search(model),
            ),
            tabBody(model)
          ],
        ),
      ),
    );
  }

  Widget tabHeader(ViewModel vm) {
    return Container(
      decoration: BoxDecoration(
        color: System.data.colorUtil.secondaryColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: System.data.colorUtil.shadowColor.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TabBar(
        controller: vm.tabController,
        indicatorColor: System.data.colorUtil.color009789,
        labelStyle:
            System.data.textStyleUtil.titleTable(fontWeight: FontWeight.bold),
        labelColor: System.data.colorUtil.color009789,
        labelPadding: EdgeInsets.only(left: 5, right: 5),
        indicatorSize: TabBarIndicatorSize.label,
        onTap: vm.setCurrentofIndexTab,
        tabs: [
          Tab(text: toBeginningOfSentenceCase(System.data.resource.listCheck)),
          Tab(
            text: toBeginningOfSentenceCase(System.data.resource.resultCheck),
          ),
        ],
      ),
    );
  }

  Widget tabBody(ViewModel vm) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: TabBarView(
          controller: vm.tabController,
          children: [
            Container(
              child: ListView(
                children: List.generate(
                  vm.listAttendanceModel.length,
                  (i) => item(
                    vm.listAttendanceModel[i],
                  ),
                ),
              ),
            ),
            Container(
              child: ListView(
                children: List.generate(
                  vm.resultAttendanceModel.length,
                  (i) => item(
                    vm.resultAttendanceModel[i],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget item(AttendanceModel am) {
    return GestureDetector(
      onTap: () {
        model.selectedAttendance = am;
        onTapAttendance(model.selectedAttendance);
      },
      child: Container(
        height: 90,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 5, top: 5),
        decoration: BoxDecoration(
          color: System.data.colorUtil.secondaryColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: System.data.colorUtil.shadowColor.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 90,
              width: 90,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  SvgPicture.asset(
                    "assets/triangle.svg",
                    color: am.isPassed == false
                        ? Colors.red
                        : System.data.colorUtil.color009789,
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.transparent, shape: BoxShape.rectangle),
                      child: Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Center(
                            child: SvgPicture.asset(
                                "assets/vehicleAttendance.svg")),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  top: 8,
                  right: 5,
                ),
                height: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "",
                            style: System.data.textStyleUtil.mainLabel(
                                color: System.data.colorUtil.darkTextColor,
                                fontSize: System.data.fontUtil.s),
                          ),
                        ),
                        Container(
                          child: Text(
                              "${am.attDate != null ? DateFormat('d MMMM yyyy').format(am.attDate) : ""}"),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "${am.driverName} ",
                            style: System.data.textStyleUtil.mainLabel(
                                color: System.data.colorUtil.darkTextColor,
                                fontSize: System.data.fontUtil.m),
                          ),
                        ),
                        Container(
                          child: Text(
                            "${am.vehicleNumber}",
                            style: System.data.textStyleUtil.mainLabel(
                                color: System.data.colorUtil.darkTextColor,
                                fontSize: System.data.fontUtil.m),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        "${am.vehicleTypeName}",
                        style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                            fontSize: System.data.fontUtil.m),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchAndFilter(ViewModel model) {
    return Container(
      height: 50,
      padding: EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Container(
            width: 370,
            height: 50,
            decoration: BoxDecoration(
              color: System.data.colorUtil.secondaryColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: System.data.colorUtil.shadowColor.withOpacity(0.2),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: InputData.inputData(
                colorBorder: Colors.transparent,
                hint: "${System.data.resource.search}...",
                borderWidth: 0,
                isBorder: false,
                controller: model.searchController,
                contentPadding: EdgeInsets.only(top: 15),
                prefix: Container(
                    child: GestureDetector(
                  onTap: () => null,
                  child: Container(
                    child: Icon(
                      FontAwesomeLight(FontAwesomeId.fa_search),
                      color: System.data.colorUtil.primaryColor,
                    ),
                  ),
                ))),
          ),
          itemFilter(model)
        ],
      ),
    );
  }

  Widget search(vm) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: System.data.colorUtil.secondaryColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: System.data.colorUtil.shadowColor.withOpacity(0.2),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: InputData.inputData(
                colorBorder: Colors.transparent,
                hint: "${System.data.resource.search}...",
                borderWidth: 0,
                isBorder: false,
                controller: model.searchController,
                contentPadding: EdgeInsets.only(top: 15),
                prefix: Container(
                    child: GestureDetector(
                  onTap: () => null,
                  child: Container(
                    child: Icon(
                      FontAwesomeLight(FontAwesomeId.fa_search),
                      color: System.data.colorUtil.primaryColor,
                    ),
                  ),
                ))),
          ),
        ],
      ),
    );
  }

  Widget itemFilterwithList(CheckStatus cs) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: PopupMenuButton(
          //initialValue: 3,
          padding: EdgeInsets.only(top: 50),
          // onSelected: (CheckStatus cs) {
          //   model.selectStatus = model.attendanceDummy[0];
          // },
          child: Center(
              child: Icon(
            FontAwesomeLight(FontAwesomeId.fa_list_ul),
            color: System.data.colorUtil.primaryColor,
          )),
          itemBuilder: (context) {
            return List.generate(model.listCheckItem.length, (index) {
              return PopupMenuItem(
                value: model.allCheckItem[index],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          //model.selectStatus = model.attendanceDummy[index];
                        },
                        child: Text("${cs.name}")),
                    Divider(
                      height: 2,
                      color: Colors.grey,
                    )
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }

  Widget itemFilter(ViewModel model) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: PopupMenuButton(
            //initialValue: 3,
            offset: Offset(0, 100),
            onSelected: (value) {
              // if (value == 2) {
              //   return Container(
              //     color: Colors.pink,
              //     height: 50,
              //     width: 50,
              //   );
              // } else {}
              print(value);
              // return Container(
              //   child: ListView(
              //       children: value == 2
              //           ? List.generate(
              //               model.listLayakJalan.length,
              //               (i) => item(
              //                 model.listLayakJalan[i],
              //               ),
              //             )
              //           : ListView(
              //               children: List.generate(
              //               model.listTidakLayakJalan.length,
              //               (i) => item(
              //                 model.listTidakLayakJalan[i],
              //               ),
              //             ))),
              // );
            },
            child: Center(
                child: Icon(
              FontAwesomeLight(FontAwesomeId.fa_list_ul),
              color: System.data.colorUtil.primaryColor,
            )),
            itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${System.data.resource.all}"),
                        Divider(
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${System.data.resource.feasible}"),
                        Divider(
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${System.data.resource.unfeasible}"),
                        Divider(
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ]),
      ),
    );
  }
}
