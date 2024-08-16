import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/model/MaintenanceScheduleModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => viewModel,
      child: Consumer<ViewModel>(
        builder: (ctx, vm, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: System.data.colorUtil.scaffoldBackgroundColor,
              appBar: appBar(),
              body: Stack(
                children: [body(vm), circularProgressIndicatorDecoration(vm)],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget circularProgressIndicatorDecoration(ViewModel vm) {
    return DecorationComponent.circularLOadingIndicator(
      controller: vm.controller,
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: System.data.colorUtil.primaryColor,
      title: Text(toBeginningOfSentenceCase(System.data.resource.maintenance),
          textAlign: TextAlign.center,
          style: System.data.textStyleUtil.mainTitle(
            color: System.data.colorUtil.lightTextColor,
          )),
    );
  }

  Widget body(ViewModel vm) {
    return Container(
      child: Column(
        children: [
          tabHeader(vm),
          tabContent(vm),
        ],
      ),
    );
  }

  Widget tabHeader(ViewModel vm) {
    return Container(
      width: double.infinity,
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
        indicatorColor: System.data.colorUtil.primaryColor,
        labelStyle:
            System.data.textStyleUtil.titleTable(fontWeight: FontWeight.bold),
        labelColor: System.data.colorUtil.darkTextColor,
        labelPadding: EdgeInsets.only(left: 5, right: 5),
        indicatorSize: TabBarIndicatorSize.label,
        onTap: vm.setVCurrentIndexTab,
        tabs: List.generate(
          widget.tabs.length,
          (index) {
            return Tab(
              text: toBeginningOfSentenceCase(
                getTabLabel(widget.tabs[index]),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget tabContent(ViewModel vm) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: TabBarView(
          controller: vm.tabController,
          children: List.generate(widget.tabs.length, (index) {
            switch (widget.tabs[index]) {
              case MaintenanceTab.WillOverdue:
                return tabWillOverDue();
                break;
              case MaintenanceTab.Overdue:
                return tabOverDue();
                break;
              case MaintenanceTab.Finish:
                return tabFinish();
                break;
              default:
                return tabFinish();
            }
          }),
        ),
      ),
    );
  }

  Widget tabWillOverDue() {
    return ListView(
      children: List.generate(
          viewModel.getWillDue.length, (i) => item(viewModel.getWillDue[i])),
    );
  }

  Widget tabOverDue() {
    return ListView(
      children: List.generate(
          viewModel.getDue.length, (i) => item(viewModel.getDue[i])),
    );
  }

  Widget tabFinish() {
    return ListView(
      children: List.generate(viewModel.getAlreadyFinish.length,
          (i) => item(viewModel.getAlreadyFinish[i])),
    );
  }

  Widget item(MaintenanceScheduleModel mm) {
    return GestureDetector(
      onTap: () {
        onSelectedData(mm);
      },
      child: Container(
        height: 102,
        margin: EdgeInsets.only(bottom: 5, top: 5),
        padding: EdgeInsets.only(bottom: 5, top: 10, left: 16, right: 16),
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
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase("${mm.maintenanceId}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${DateFormat('dd/MM/yyyy').format(mm.dateTime)}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 15),
                    color: System.data.colorUtil.shadowColor,
                    height: 1,
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      toBeginningOfSentenceCase("${mm.desc}"),
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                      ),
                    ),
                  ),
                  Container(
                    width: 165,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: mm.typeMissing == 1
                          ? System.data.colorUtil.yellowColor
                          : mm.typeMissing == 2
                              ? System.data.colorUtil.redColor
                              : System.data.colorUtil.primaryColor,
                    ),
                    padding:
                        EdgeInsets.only(left: 2, top: 1, bottom: 1, right: 1),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          child: SvgPicture.asset("${mm.pathIcon}"),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5),
                            color: System.data.colorUtil.secondaryColor,
                            child: Text(
                              toBeginningOfSentenceCase(
                                mm.typeMaintenance == 3
                                    ? System.data.resource.finish
                                    : mm.typeMaintenance == 1
                                        ? mm.typeMissing == 2
                                            ? "${System.data.resource.missed} ${mm.total} ${System.data.resource.day}"
                                            : "${System.data.resource.missed} ${mm.total} Km"
                                        : mm.typeMissing == 2
                                            ? "${mm.total} ${System.data.resource.day} ${System.data.resource.toGo}"
                                            : "${mm.total} Km ${System.data.resource.toGo}",
                              ),
                              style: System.data.textStyleUtil.mainLabel(
                                color: System.data.colorUtil.darkTextColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
