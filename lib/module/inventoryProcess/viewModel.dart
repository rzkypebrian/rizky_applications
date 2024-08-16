import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/imagePickerComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/DropDowns.dart';
import 'package:enerren/model/HistoryStockModel.dart';
import 'package:enerren/model/MaintenanceScheduleModel.dart';
import 'package:enerren/model/StockModel.dart';
import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/model/ProductModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/multipleImagePickerComponent.dart';

class ViewModel extends ChangeNotifier {
  void commit() => notifyListeners();

  MaintenanceScheduleModel maintenanceModel;
  set setMaintenanceModel(MaintenanceScheduleModel mm) {
    this.maintenanceModel = mm;
    commit();
  }

  void setMaintenanceModelV(MaintenanceScheduleModel mm) {
    this.maintenanceModel = mm;
    commit();
  }

  int typeProcessStock = 1;

  set setTypeProcessStock(int index) {
    this.typeProcessStock = index;
  }

  int get getTypeProcess => typeProcessStock;

  MaintenanceScheduleModel get getMaintenanceModel => this.maintenanceModel;

  CircularProgressIndicatorController controller =
      CircularProgressIndicatorController();

  InputComponentTextEditingController totalProductController =
      InputComponentTextEditingController();
  InputComponentTextEditingController priceProductController =
      InputComponentTextEditingController();
  InputComponentTextEditingController shopNameController =
      InputComponentTextEditingController();
  InputComponentTextEditingController imageController =
      InputComponentTextEditingController();
  InputComponentTextEditingController imageProofPurchaseController =
      InputComponentTextEditingController();
  InputComponentTextEditingController maintenanceIdController =
      InputComponentTextEditingController();
  InputComponentTextEditingController serviceFeeController =
      InputComponentTextEditingController();

  ImagePickerController imagePickerController = ImagePickerController();
  MultipleImagePickerController imagePickerControllerProofPurchase =
      MultipleImagePickerController();

  List<DropDowns> listProductStatus = [
    DropDowns(
      id: 1,
      name: System.data.resource.stock,
    ),
    DropDowns(
      id: 2,
      name: System.data.resource.immediatelyUseIt,
    ),
  ];

  List<DropDowns> listProductName = [
    DropDowns(
      id: 1,
      name: "oli",
    ),
    DropDowns(
      id: 2,
      name: "ban",
    ),
    DropDowns(
      id: 2,
      name: "busi",
    ),
  ];

  List<DropDowns> listProductSource = [
    DropDowns(
      id: 1,
      name: "${System.data.resource.buy}",
    ),
    DropDowns(
      id: 2,
      name: "${System.data.resource.stock}",
    ),
  ];

  void vAddProductPoModel(ProductModel pm) {
    this.historyStockModel.stocks.first.products.add(pm);
    commit();
  }

  set addProductPoModel(ProductModel pm) {
    this.historyStockModel.stocks.first.products.add(pm);
    commit();
  }

  StockModel get getStock => historyStockModel.stocks.first;

  dynamic getName(dynamic a) {
    if (a.runtimeType.toString() == "ProductModel")
      return a.productName;
    else
      return a.name;
  }

  set setMaintenanceId(String id) {
    this.maintenanceId = id;
    commit();
  }

  void vSetMaintenanceId(String id) {
    this.maintenanceId = id;
    commit();
  }

  String get getMaintenanceId => maintenanceId;

  set removeProduct(ProductModel pm) {
    historyStockModel.stocks.first.products
        .removeWhere((element) => element == pm);
    commit();
  }

  void vRemoveProduct(ProductModel pm) {
    historyStockModel.stocks.first.products
        .removeWhere((element) => element == pm);
    commit();
  }

  List<ProductModel> get getListProduct =>
      this.historyStockModel.stocks.first.products;

  DropDowns selectedProductStatus;
  void onChangeProductStatus(DropDowns downs) {
    this.selectedProductStatus = downs;
    commit();
  }

  DropDowns selectedProductSource;
  void onChangeProductSource(DropDowns downs) {
    this.selectedProductSource = downs;
    commit();
  }

  DropDowns selectedProductName;
  void onChangeProductName(DropDowns downs) {
    this.selectedProductName = downs;
    commit();
  }

  ProductModel selectedProduct;
  void onChangeProduct(ProductModel product) {
    this.selectedProduct = product;
    commit();
  }

  double get getTotalProduct {
    if (historyStockModel.stocks.first.products == null) {
      historyStockModel.stocks.first.products = [];
    }
    return historyStockModel.stocks.first.products
        .fold(0, (v, e) => v + e.totalProduct);
  }

  List<DropDowns> get getProductStatus => listProductStatus;
  DropDowns get getSelectedProductStatus =>
      selectedProductStatus ?? listProductStatus.first;

  List<DropDowns> get getProductName => listProductName;

  DropDowns get getSelectedProductName =>
      selectedProductName ?? listProductName.first;

  DropDowns get getSelectedProductSource =>
      selectedProductSource ?? listProductSource.first;

  ProductModel get getSelectedProduct =>
      selectedProduct ?? historyStockModel.stocks.first.products.first;

  String get getPrNumber => getStock.prNumber;

  String maintenanceId;

  HistoryStockModel historyStockModel = HistoryStockModel(
    dateTime: DateTime.now(),
    pokect: 1,
    vehicle: TmsVehicleModel(
      driverName: "mardigu",
      vehicleNumber: "b 1234 ac",
      vehicleTypeName: "box",
    ),
    stocks: [
      StockModel(
        balance: 5000000,
        prNumber: "prxxxx1",
        dateTime: DateTime.now(),
      )
    ],
  );

  void addStocks() {
    ProductModel _productModel = ProductModel(
      buyingPrice: double.parse(priceProductController.text.isEmpty
          ? "0"
          : priceProductController.text.replaceAll(".", "")),
      insertedDate: DateTime.now(),
      insertedBy: "",
      totalProduct: double.parse(totalProductController.text.isEmpty
          ? "0"
          : totalProductController.text.replaceAll(".", "")),
      sallerName: shopNameController.text,
      idMaintenance: maintenanceModel?.maintenanceId ?? "",
      productName: getSelectedProductName.name,
      status: getSelectedProductStatus.id,
      image: imagePickerController.getBase64(),
    );

    priceProductController.text = "";
    totalProductController.text = "";
    imageController.text = "";
    shopNameController.text = "";
    maintenanceIdController.text = "";

    if (historyStockModel.stocks.first.products == null)
      historyStockModel.stocks.first.products = [];

    historyStockModel.stocks.first.typeProcessIo = getTypeProcess;
    historyStockModel.stocks.first.products.add(_productModel);
    commit();
  }

  void reduceStock() {
    ProductModel _productModel = ProductModel(
      modifiedDate: DateTime.now(),
      modifiedBy: "",
      totalProduct: double.parse(totalProductController.text.isEmpty
          ? "0"
          : totalProductController.text.replaceAll(".", "")),
      idMaintenance: maintenanceModel?.maintenanceId ?? "",
      productName: getSelectedProductName.name,
      image: imagePickerController.getBase64(),
    );

    priceProductController.text = "";
    totalProductController.text = "";
    imageController.text = "";
    shopNameController.text = "";
    maintenanceIdController.text = "";

    if (historyStockModel.stocks.first.products == null)
      historyStockModel.stocks.first.products = [];
    historyStockModel.stocks.first.typeProcessIo = getTypeProcess;
    historyStockModel.stocks.first.products.add(_productModel);
    commit();
  }

  void sendAddStock({
    VoidCallback onFinishLoading,
  }) {
    historyStockModel.stocks.first.images =
        imagePickerControllerProofPurchase.getBase64();
    ModeUtil.debugPrint("Stock ${historyStockModel.stocks.first.images}");
    controller.stopLoading(
      message: System.data.resource.dataSentSuccessfully,
      messageAlign: Alignment.topCenter,
      onFinishCallback: onFinishLoading,
      messageWidget: DecorationComponent.topMessageDecoration(
        backgroundColor: System.data.colorUtil.greenColor,
        message: System.data.resource.dataSentSuccessfully,
      ),
    );
  }

  void sendReduceStock() {
    ModeUtil.debugPrint("Stock ${historyStockModel.stocks.first.images}");
    controller.stopLoading(
      message: System.data.resource.dataSentSuccessfully,
      messageAlign: Alignment.topCenter,
      messageWidget: DecorationComponent.topMessageDecoration(
        backgroundColor: System.data.colorUtil.greenColor,
        message: System.data.resource.dataSentSuccessfully,
      ),
    );
  }
}
