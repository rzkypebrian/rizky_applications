import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'package:enerren/model/StockModel.dart';

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
                children: [
                  body(vm),
                  circularProgressIndicatorDecoration(vm),
                ],
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
      aligment: Alignment.topCenter,
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: System.data.colorUtil.primaryColor,
      title: Text(toBeginningOfSentenceCase(System.data.resource.history),
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
          tabBody(vm),
        ],
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
        indicatorColor: System.data.colorUtil.primaryColor,
        labelStyle:
            System.data.textStyleUtil.titleTable(fontWeight: FontWeight.bold),
        labelColor: System.data.colorUtil.darkTextColor,
        labelPadding: EdgeInsets.only(left: 5, right: 5),
        indicatorSize: TabBarIndicatorSize.label,
        onTap: vm.setVCurrentIndexTab,
        tabs: [
          Tab(text: toBeginningOfSentenceCase(System.data.resource.purchase)),
          Tab(text: toBeginningOfSentenceCase(System.data.resource.stock)),
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
                  vm.addStockModel.length,
                  (i) => item(
                    vm.addStockModel[i],
                  ),
                ),
              ),
            ),
            Container(
              child: ListView(
                children: List.generate(
                  vm.reduceStockModel.length,
                  (i) => item(
                    vm.reduceStockModel[i],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget item(StockModel sm) {
    return GestureDetector(
      onTap: () {
        viewModel.setSelectedHistoryStock = sm;
        onTapDetail(
          viewModel.getSelectedHistoryStockModel,
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 5, top: 5),
        padding: EdgeInsets.all(10),
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
        child: sm.typeProcessIo == 1
            ? Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: System.data.colorUtil.shadowColor))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            toBeginningOfSentenceCase("${sm.prNumber}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${DateFormat('yyyy-MM-dd').format(sm.dateTime)}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    padding: EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.productName} : ${sm.products?.first?.productName}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.price} : Rp ${NumberFormat("#,###.#", System.data.resource.locale).format(sm.products.first?.buyingPrice)}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.total} : ${NumberFormat("#,###.#", System.data.resource.locale).format(sm.products.first?.totalProduct)}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.status} : ${sm.products.first?.status == 1 ? System.data.resource.stock : System.data.resource.immediatelyUseIt}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: System.data.colorUtil.shadowColor))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            toBeginningOfSentenceCase("${sm.prNumber}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${DateFormat('yyyy-MM-dd').format(sm.dateTime)}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            toBeginningOfSentenceCase(
                                "${System.data.resource.productName} : ${sm.products?.first?.productName}"),
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => onTapHeroImage(
                              name: "${sm.products.first?.productName}",
                              path: "${sm.products.first?.image}"),
                          child: Container(
                            height: 40,
                            margin: EdgeInsets.all(5),
                            child: Image.network(
                              "${sm.products.first?.image}",
                              fit: BoxFit.fitHeight,
                              errorBuilder: (bb, o, st) => Container(
                                width: 28,
                                height: 16,
                                child: SvgPicture.asset(
                                    "assets/tms/erroImage.svg"),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      toBeginningOfSentenceCase(
                          "${System.data.resource.total} : ${NumberFormat("#,###.#", System.data.resource.locale).format(sm.products?.first?.totalProduct)}"),
                      textAlign: TextAlign.start,
                      style: System.data.textStyleUtil.mainLabel(
                        color: System.data.colorUtil.darkTextColor,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
