import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'package:enerren/model/ProductModel.dart';
import 'package:flutter_svg/svg.dart';

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
      title:
          Text(toBeginningOfSentenceCase(System.data.resource.detailPurchase),
              textAlign: TextAlign.center,
              style: System.data.textStyleUtil.mainTitle(
                color: System.data.colorUtil.lightTextColor,
              )),
    );
  }

  Widget body(ViewModel vm) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            headerStock(vm),
            listProduct(vm),
          ],
        ),
      ),
    );
  }

  Widget headerStock(ViewModel vm) {
    var getStock = vm.getStockModel;
    return Container(
      margin: getStock.typeProcessIo == 1
          ? EdgeInsets.only(bottom: 10)
          : EdgeInsets.only(bottom: 0),
      padding: getStock.typeProcessIo == 1
          ? EdgeInsets.all(10)
          : EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 10),
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
      child: getStock.typeProcessIo == 1
          ? Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: System.data.colorUtil.secondaryColor,
                    border: Border(
                      bottom: BorderSide(
                        color: System.data.colorUtil.shadowColor,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase("${getStock.prNumber}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${DateFormat('yyyy-MM-dd').format(getStock?.dateTime)}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.balance}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "Rp ${NumberFormat("#,##0").format(getStock?.balance)}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                getStock.remainingBalance < 0
                    ? Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                toBeginningOfSentenceCase(
                                    "${System.data.resource.seep}"),
                                style: System.data.textStyleUtil.mainLabel(
                                  color: System.data.colorUtil.darkTextColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                toBeginningOfSentenceCase(
                                    "Rp ${NumberFormat("#,##0").format(getStock?.remainingBalance)}"),
                                textAlign: TextAlign.end,
                                style: System.data.textStyleUtil.mainLabel(
                                  color: System.data.colorUtil.darkTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200,
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.totalPrice}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color:
                                          System.data.colorUtil.shadowColor))),
                          child: Text(
                            toBeginningOfSentenceCase(
                                "Rp ${NumberFormat("#,##0").format(getStock?.totalPrice)}"),
                            textAlign: TextAlign.end,
                            style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.darkTextColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      getStock.images.length,
                      (index) => GestureDetector(
                        onTap: () => onTapHeroImage(
                            name: "$index", path: "${getStock.images[index]}"),
                        child: Container(
                          margin: EdgeInsets.all(5),
                          child: Image.network(
                            "${getStock.images[index]}",
                            fit: BoxFit.fitHeight,
                            errorBuilder: (bb, o, st) => Container(
                              width: 28,
                              height: 16,
                              child:
                                  SvgPicture.asset("assets/erroImage.svg"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: System.data.colorUtil.secondaryColor,
                    border: Border(
                      bottom: BorderSide(
                        color: System.data.colorUtil.shadowColor,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase("${getStock.prNumber}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${DateFormat('yyyy-MM-dd').format(getStock?.dateTime)}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
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

  Widget listProduct(ViewModel vm) {
    var getStock = vm.getStockModel;

    return Container(
      color: System.data.colorUtil.secondaryColor,
      margin: getStock.typeProcessIo == 1
          ? EdgeInsets.only(bottom: 10)
          : EdgeInsets.only(bottom: 0),
      padding: EdgeInsets.all(10),
      child: Column(
        children: List.generate(
          getStock.products.length,
          (index) => itemProduct((getStock.products[index]),
              typeProcess: getStock.typeProcessIo),
        ),
      ),
    );
  }

  Widget itemProduct(ProductModel pm, {int typeProcess = 1}) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      margin: typeProcess == 1
          ? EdgeInsets.only(top: 5, bottom: 5)
          : EdgeInsets.only(
              top: 0,
            ),
      decoration: BoxDecoration(
        color: System.data.colorUtil.secondaryColor,
        border: Border(
          bottom: BorderSide(
            color: System.data.colorUtil.shadowColor,
          ),
        ),
      ),
      child: typeProcess == 1
          ? Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.productName} : ${pm.productName}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.shopName} : ${pm.sallerName}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.total} : ${NumberFormat("#,##0").format(pm.totalProduct)}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.shopName} : ${pm.status == 1 ? System.data.resource.stock : System.data.resource.immediatelyUseIt}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.total} : ${NumberFormat("#,##0").format(pm.buyingPrice)}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () => onTapHeroImage(
                              name: "${pm.productName}", path: "${pm.image}"),
                          child: Container(
                            height: 40,
                            margin: EdgeInsets.all(5),
                            child: Image.network(
                              "${pm.image}",
                              fit: BoxFit.fitHeight,
                              errorBuilder: (bb, o, st) => Container(
                                width: 28,
                                height: 16,
                                child: SvgPicture.asset(
                                    "assets/tms/erroImage.svg"),
                              ),
                            ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.productName} : ${pm.productName}"),
                          style: System.data.textStyleUtil.mainLabel(
                            color: System.data.colorUtil.darkTextColor,
                          ),
                        ),
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () => onTapHeroImage(
                              name: "${pm.productName}", path: "${pm.image}"),
                          child: Container(
                            height: 40,
                            margin: EdgeInsets.all(5),
                            child: Image.network(
                              "${pm.image}",
                              fit: BoxFit.fitHeight,
                              errorBuilder: (bb, o, st) => Container(
                                width: 28,
                                height: 16,
                                child: SvgPicture.asset(
                                    "assets/tms/erroImage.svg"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    toBeginningOfSentenceCase(
                        "${System.data.resource.total} : ${NumberFormat("#,##0").format(pm.buyingPrice)}"),
                    style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
