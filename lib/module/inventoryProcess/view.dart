import 'package:component_icons/font_awesome.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'package:enerren/util/InputData.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/multipleImagePickerComponent.dart';

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
      title: Text(
          widget.processTitle ??
              toBeginningOfSentenceCase(System.data.resource.maintenance),
          textAlign: TextAlign.center,
          style: System.data.textStyleUtil.mainTitle(
            color: System.data.colorUtil.lightTextColor,
          )),
    );
  }

  Widget body(ViewModel vm) {
    return SingleChildScrollView(
      child: Container(
        color: System.data.colorUtil.secondaryColor,
        child: Column(
          children: [
            inputDatas(vm),
            listStock(vm),
            sendData(vm),
          ],
        ),
      ),
    );
  }

  List<Widget> addStock(ViewModel vm) {
    List<Widget> inputData = [];

    inputData = List.generate(super.inputDataItem.length, (index) {
      return inputDataSwitch(vm, super.inputDataItem[index]);
    });

    inputData.add(addIcon(vm));

    return inputData;
  }

  Widget inputDataSwitch(ViewModel vm, InputDataField inputDataItem) {
    switch (inputDataItem) {
      case InputDataField.PRnumber:
        return prNumber(vm);
        break;
      case InputDataField.MaintenanceId:
        return maintenanceId(vm);
        break;
      case InputDataField.ProductSource:
        return productSource(vm);
        break;
      case InputDataField.ProductStatus:
        return productStatus(vm);
        break;
      case InputDataField.ProductName:
        return productName(vm);
        break;
      case InputDataField.ProductTotal:
        return productTotal(vm);
        break;
      case InputDataField.ProductPrice:
        return productPrice(vm);
        break;
      case InputDataField.Vendor:
        return vendor(vm);
        break;
      case InputDataField.ProductPhoto:
        return productPhoto(vm);
        break;
      default:
        return SizedBox();
    }
  }

  Widget prNumber(ViewModel vm) {
    return InputData.inputData(
      title: System.data.resource.prNumber,
      typeInput: TypeInput.Strings,
      valueString: vm.getPrNumber,
    );
  }

  Widget maintenanceId(ViewModel vm) {
    return InputData.inputData(
      title: System.data.resource.maintenanceId,
      typeInput: TypeInput.Strings,
      controller: vm.maintenanceIdController,
      valueString: vm.getMaintenanceId ?? "-",
      sufix: GestureDetector(
        onTap: () => getMaintenanceId(),
        child: Container(
          child: Icon(FontAwesomeLight(FontAwesomeId.fa_search),
              color: System.data.colorUtil.primaryColor),
        ),
      ),
    );
  }

  Widget productSource(ViewModel vm) {
    return InputData.inputData(
      title: System.data.resource.productSource,
      typeInput: TypeInput.Dropdown,
      list: vm.listProductSource,
      onChangeds: (v) => vm.onChangeProductSource(v),
      selectedItem: vm.getSelectedProductSource,
    );
  }

  Widget productStatus(ViewModel vm) {
    return InputData.inputData(
      title: System.data.resource.productStatus,
      typeInput: TypeInput.Dropdown,
      onChangeds: (v) => vm.onChangeProductStatus(v),
      selectedItem: vm.getSelectedProductStatus,
      list: vm.listProductStatus,
    );
  }

  Widget productName(ViewModel vm) {
    return InputData.inputData(
      title: System.data.resource.productName,
      typeInput: TypeInput.Dropdown,
      list: vm.listProductName,
      onChangeds: (v) => vm.onChangeProductName(v),
      selectedItem: vm.getSelectedProductName,
    );
  }

  Widget productTotal(ViewModel vm) {
    return InputData.inputData(
      title: System.data.resource.totalProduct,
      controller: vm.totalProductController,
      keyboardType: TextInputType.number,
    );
  }

  Widget productPrice(ViewModel vm) {
    return InputData.inputData(
      title: System.data.resource.priceProduct,
      controller: vm.priceProductController,
      keyboardType: TextInputType.number,
    );
  }

  Widget vendor(ViewModel vm) {
    return InputData.inputData(
      title: System.data.resource.shopName,
      controller: vm.shopNameController,
    );
  }

  Widget productPhoto(ViewModel vm) {
    return InputData.inputData(
      title: System.data.resource.imageProduct,
      controller: vm.imageController,
      sufix: GestureDetector(
        onTap: () {
          vm.imagePickerController
              .getImages(camera: true, imageQuality: 30)
              .then((value) {
            if (value) {
              ModeUtil.debugPrint(
                  " vm.imagePickerController.getFileName() ${vm.imagePickerController.getFileName()}");
              vm.imageController.text = vm.imagePickerController.getFileName();
              vm.commit();
            }
          });
        },
        child: Container(
          child: Icon(
            FontAwesomeSolid(FontAwesomeId.fa_camera_alt),
            color: System.data.colorUtil.primaryColor,
          ),
        ),
      ),
    );
  }

  List<Widget> reduceStock(ViewModel vm) {
    return [
      InputData.inputData(
        title: System.data.resource.prNumber,
        typeInput: TypeInput.Strings,
        valueString: vm.getPrNumber,
      ),
      InputData.inputData(
        title: System.data.resource.productName,
        typeInput: TypeInput.Dropdown,
        list: vm.listProductName,
        onChangeds: (v) => vm.onChangeProductName(v),
        selectedItem: vm.getSelectedProductName,
      ),
      InputData.inputData(
        title: System.data.resource.totalProduct,
        controller: vm.totalProductController,
        keyboardType: TextInputType.number,
      ),
      InputData.inputData(
          title: System.data.resource.maintenanceId,
          typeInput: TypeInput.Text,
          controller: vm.maintenanceIdController,
          valueString: vm.getMaintenanceId,
          sufix: GestureDetector(
            onTap: () => getMaintenanceId(),
            child: Container(
              child: Icon(FontAwesomeLight(FontAwesomeId.fa_search),
                  color: System.data.colorUtil.primaryColor),
            ),
          )),
      InputData.inputData(
          title: System.data.resource.imageProduct,
          controller: vm.imageController,
          sufix: GestureDetector(
              onTap: () {
                vm.imagePickerController
                    .getImages(camera: true, imageQuality: 30)
                    .then((value) {
                  if (value) {
                    ModeUtil.debugPrint(
                        " vm.imagePickerController.getFileName() ${vm.imagePickerController.getFileName()}");
                    vm.imageController.text =
                        vm.imagePickerController.getFileName();
                    vm.commit();
                  }
                });
              },
              child: Container(
                child: Icon(
                  FontAwesomeSolid(FontAwesomeId.fa_camera_alt),
                  color: System.data.colorUtil.primaryColor,
                ),
              ))),
      addIcon(vm),
    ];
  }

  Widget inputDatas(ViewModel vm) {
    return Container(
      margin: EdgeInsets.all(18),
      child: Column(
        children: addStock(vm),
      ),
    );
  }

  Widget addIcon(ViewModel vm) {
    return Container(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: Icon(
          FontAwesomeSolid(FontAwesomeId.fa_plus_circle),
        ),
        onPressed: vm.addStocks,
        color: System.data.colorUtil.primaryColor,
      ),
    );
  }

  Widget sendData(ViewModel vm) {
    return GestureDetector(
      onTap: () {
        showBottom(vm);
      },
      child: Container(
        height: 42,
        margin: EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: System.data.colorUtil.primaryColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: System.data.colorUtil.shadowColor)),
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          toBeginningOfSentenceCase("${System.data.resource.send}"),
          textAlign: TextAlign.center,
          style: System.data.textStyleUtil.mainLabel(
              color: System.data.colorUtil.secondaryColor,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  void showBottom(ViewModel vm) {
    ModalComponent.bottomModalWithCorner(context,
        fromRoute: false,
        height: 500,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 55, bottom: 16),
                child: Text(
                  toBeginningOfSentenceCase(
                      "${System.data.resource.uploadProofOfTransaction}"),
                  textAlign: TextAlign.center,
                  style: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.darkTextColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                height: 300,
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 20),
                child: SingleChildScrollView(
                  child: MultipleImagePickerComponent(
                      galery: false,
                      camera: true,
                      controller: vm.imagePickerControllerProofPurchase),
                ),
              ),
              Container(
                height: 42,
                margin: EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        vm.sendAddStock(
                          onFinishLoading: widget.onSubmitSuccess,
                        );
                        System.data.routes.pop(context);
                      },
                      child: Container(
                        width: 150,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: System.data.colorUtil.primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.send}"),
                          textAlign: TextAlign.center,
                          style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.secondaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => System.data.routes.pop(context),
                      child: Container(
                        width: 150,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: System.data.colorUtil.primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.cancel}"),
                          textAlign: TextAlign.center,
                          style: System.data.textStyleUtil.mainLabel(
                              color: System.data.colorUtil.secondaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void showModalEditServiceFee(ViewModel vm) {
    ModalComponent.bottomModalWithCorner(
      context,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 55, bottom: 16),
              child: Text(
                toBeginningOfSentenceCase(
                    "${System.data.resource.edit} ${System.data.resource.serviceFee}"),
                textAlign: TextAlign.center,
                style: System.data.textStyleUtil.mainLabel(
                  color: System.data.colorUtil.darkTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: InputData.inputData(
                  widTitle: 0,
                  typeInput: TypeInput.Number,
                  controller: vm.serviceFeeController,
                  onChangeds: (bla) {
                    print("masuk sini");
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 42,
              margin: EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: BottonComponent.roundedButton(
                  text: System.data.resource.save,
                  colorBackground: System.data.colorUtil.primaryColor,
                  onPressed: () {
                    System.data.routes.pop(context);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget listStock(ViewModel vm) {
    Map<int, TableColumnWidth> headerTable = {
      0: FlexColumnWidth(),
      1: FlexColumnWidth(0.6),
      2: FlexColumnWidth(0.4),
      3: FlexColumnWidth(),
      4: FlexColumnWidth(0.3),
    };

    List<Widget> titleHeaderTable = [
      Container(
        child: Text(
          toBeginningOfSentenceCase("${System.data.resource.name}"),
          textAlign: TextAlign.center,
          style:
              System.data.textStyleUtil.mainLabel(fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 25),
        child: Text(
          toBeginningOfSentenceCase("${System.data.resource.total}"),
          textAlign: TextAlign.center,
          style:
              System.data.textStyleUtil.mainLabel(fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        child: Text(
          toBeginningOfSentenceCase("${System.data.resource.photo}"),
          textAlign: TextAlign.center,
          style:
              System.data.textStyleUtil.mainLabel(fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        child: Text(
          toBeginningOfSentenceCase("${System.data.resource.price}"),
          textAlign: TextAlign.center,
          style:
              System.data.textStyleUtil.mainLabel(fontWeight: FontWeight.w500),
        ),
      ),
      Container(
        margin: EdgeInsets.only(right: 5),
        child: Text(
          toBeginningOfSentenceCase("${System.data.resource.edit}"),
          textAlign: TextAlign.end,
          style:
              System.data.textStyleUtil.mainLabel(fontWeight: FontWeight.w500),
        ),
      ),
    ];

    if (vm.typeProcessStock == 2) {
      headerTable = {
        0: FlexColumnWidth(),
        1: FlexColumnWidth(0.6),
        2: FlexColumnWidth(0.4),
        3: FlexColumnWidth(0.3),
      };
      titleHeaderTable = [
        Container(
          child: Text(
            toBeginningOfSentenceCase("${System.data.resource.name}"),
            textAlign: TextAlign.center,
            style: System.data.textStyleUtil
                .mainLabel(fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 25),
          child: Text(
            toBeginningOfSentenceCase("${System.data.resource.total}"),
            textAlign: TextAlign.center,
            style: System.data.textStyleUtil
                .mainLabel(fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          child: Text(
            toBeginningOfSentenceCase("${System.data.resource.photo}"),
            textAlign: TextAlign.center,
            style: System.data.textStyleUtil
                .mainLabel(fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 5),
          child: Text(
            toBeginningOfSentenceCase("${System.data.resource.edit}"),
            textAlign: TextAlign.end,
            style: System.data.textStyleUtil
                .mainLabel(fontWeight: FontWeight.w500),
          ),
        ),
      ];
    }

    return Container(
      decoration: BoxDecoration(
        border:
            Border(top: BorderSide(color: System.data.colorUtil.shadowColor)),
      ),
      padding: EdgeInsets.only(bottom: 20),
      child: Container(
        margin: EdgeInsets.all(18),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom:
                      BorderSide(color: System.data.colorUtil.darkTextColor)),
            ),
            padding: EdgeInsets.only(bottom: 12),
            child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: headerTable,
                children: [
                  TableRow(children: titleHeaderTable),
                ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 12, bottom: 12),
            decoration: BoxDecoration(
              border: Border(
                  bottom:
                      BorderSide(color: System.data.colorUtil.darkTextColor)),
            ),
            padding: EdgeInsets.only(bottom: 12),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: headerTable,
              children: List.generate(
                vm.getListProduct?.length ?? 0,
                (index) {
                  if (vm.typeProcessStock == 1) {
                    return TableRow(decoration: BoxDecoration(), children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${vm.getListProduct[index].productName}"),
                          textAlign: TextAlign.start,
                          style: System.data.textStyleUtil.mainLabel(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${NumberFormat("#,###.#", System.data.resource.locale).format(vm.getListProduct[index].totalProduct ?? 0)}"),
                          textAlign: TextAlign.end,
                          style: System.data.textStyleUtil.mainLabel(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        height: 30,
                        child: vm.getListProduct[index].image == null
                            ? Image.network(
                                "${vm.getListProduct[index].image}",
                                fit: BoxFit.fitHeight,
                                errorBuilder: (bb, o, st) => Container(
                                  width: 28,
                                  height: 16,
                                  child: SvgPicture.asset(
                                      "assets/tms/erroImage.svg"),
                                ),
                              )
                            : Image.memory(
                                Uri.parse(vm.getListProduct[index].image)
                                    .data
                                    .contentAsBytes(),
                                errorBuilder: (bb, o, st) => Container(
                                  width: 28,
                                  height: 16,
                                  child: SvgPicture.asset(
                                      "assets/tms/erroImage.svg"),
                                ),
                                fit: BoxFit.fitHeight,
                              ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 12, right: 5),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "Rp ${NumberFormat("#,###.#", System.data.resource.locale).format(vm.getListProduct[index].buyingPrice ?? 0)}"),
                          textAlign: TextAlign.end,
                          style: System.data.textStyleUtil.mainLabel(),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                            bottom: 12,
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                vm.vRemoveProduct(vm.getListProduct[index]),
                            child: Icon(
                              FontAwesomeLight(FontAwesomeId.fa_trash_alt),
                              size: 15,
                            ),
                          )),
                    ]);
                  } else {
                    return TableRow(decoration: BoxDecoration(), children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${vm.getListProduct[index].productName}"),
                          textAlign: TextAlign.start,
                          style: System.data.textStyleUtil.mainLabel(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${NumberFormat("#,###.#", System.data.resource.locale).format(vm.getListProduct[index].totalProduct ?? 0)}"),
                          textAlign: TextAlign.end,
                          style: System.data.textStyleUtil.mainLabel(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        height: 30,
                        child: vm.getListProduct[index].image == null
                            ? Image.network(
                                "${vm.getListProduct[index].image}",
                                fit: BoxFit.fitHeight,
                                errorBuilder: (bb, o, st) => Container(
                                  width: 28,
                                  height: 16,
                                  child: SvgPicture.asset(
                                      "assets/tms/erroImage.svg"),
                                ),
                              )
                            : Image.memory(
                                Uri.parse(vm.getListProduct[index].image)
                                    .data
                                    .contentAsBytes(),
                                errorBuilder: (bb, o, st) => Container(
                                  width: 28,
                                  height: 16,
                                  child: SvgPicture.asset(
                                      "assets/tms/erroImage.svg"),
                                ),
                                fit: BoxFit.fitHeight,
                              ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                            bottom: 12,
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                vm.vRemoveProduct(vm.getListProduct[index]),
                            child: Icon(
                              FontAwesomeLight(FontAwesomeId.fa_trash_alt),
                              size: 15,
                            ),
                          )),
                    ]);
                  }
                },
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.subtotal}"),
                          textAlign: TextAlign.end,
                          style: System.data.textStyleUtil
                              .mainLabel(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 38),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "Rp ${NumberFormat("#,###.#", System.data.resource.locale).format(vm.getStock.totalPrice)}"),
                          textAlign: TextAlign.end,
                          style: System.data.textStyleUtil
                              .mainLabel(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.serviceFee}"),
                          textAlign: TextAlign.end,
                          style: System.data.textStyleUtil
                              .mainLabel(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 0),
                        child: Row(
                          children: [
                            Text(
                              toBeginningOfSentenceCase(
                                "Rp ${NumberFormat("#,###.#", System.data.resource.locale).format(int.parse(vm.serviceFeeController.contentAsInt.toString()))}",
                              ),
                              textAlign: TextAlign.end,
                              style: System.data.textStyleUtil
                                  .mainLabel(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 33,
                              child: GestureDetector(
                                onTap: () {
                                  showModalEditServiceFee(vm);
                                },
                                child: Icon(
                                  Icons.edit_outlined,
                                  size: System.data.fontUtil.s,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          toBeginningOfSentenceCase(
                              "${System.data.resource.total}"),
                          textAlign: TextAlign.end,
                          style: System.data.textStyleUtil
                              .mainLabel(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 38),
                        child: Text(
                          toBeginningOfSentenceCase(
                              "Rp ${NumberFormat("#,###.#", System.data.resource.locale).format(vm.getStock.totalPrice + int.parse(vm.serviceFeeController.contentAsInt.toString()))}"),
                          textAlign: TextAlign.end,
                          style: System.data.textStyleUtil
                              .mainLabel(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                // balance(vm),
                // remainingBalance(vm),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget balance(ViewModel vm) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              toBeginningOfSentenceCase("${System.data.resource.balance}"),
              textAlign: TextAlign.end,
              style: System.data.textStyleUtil.mainLabel(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 38),
            child: Text(
              toBeginningOfSentenceCase(
                  "Rp ${NumberFormat("#,###.#", System.data.resource.locale).format(vm.getStock.balance)}"),
              textAlign: TextAlign.end,
              style: System.data.textStyleUtil.mainLabel(),
            ),
          ),
        ],
      ),
    );
  }

  Widget remainingBalance(ViewModel vm) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              toBeginningOfSentenceCase(
                  "${System.data.resource.remainingBalance}"),
              textAlign: TextAlign.end,
              style: System.data.textStyleUtil.mainLabel(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 38),
            child: Text(
              toBeginningOfSentenceCase(
                  "Rp ${NumberFormat("#,###.#", System.data.resource.locale).format(vm.getStock.remainingBalance)}"),
              textAlign: TextAlign.end,
              style: System.data.textStyleUtil.mainLabel(),
            ),
          ),
        ],
      ),
    );
  }
}
