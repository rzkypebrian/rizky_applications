import 'package:enerren/model/ProductModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'StockModel.g.dart';

@JsonSerializable(explicitToJson: true)
class StockModel {
  String prNumber;
  double balance;
  double incomeBalance;
  double outcomeBalance;
  List<ProductModel> products;
  List<String> images;
  String image;
  DateTime dateTime;
  int typeProcessIo; // typeProcessIo  1 add 2 reduce
  int flowBalance; // flowBalance 1 income 2 outcome
  int seepStatus; // seepStatus 1 = prosess 2 finish
  double service;
  double discount;

  StockModel({
    this.typeProcessIo,
    this.prNumber,
    this.balance = 0,
    this.seepStatus = 1,
    this.flowBalance = 1,
    this.incomeBalance = 0,
    this.outcomeBalance = 0,
    this.discount = 0,
    this.service = 0,
    this.products,
    this.images,
    this.image,
    this.dateTime,
  });

  set setBalance(double balance) {
    this.balance = balance;
  }

  double get totalPrice =>
      products == null ? 0 : products.fold(0, (p, e) => p + e.buyingPrice);

  double get totalPriceStock => products == null
      ? 0
      : products
          .where((e) => e.productType == 1)
          .fold(0, (p, e) => p + e.buyingPrice);

  double get totalPriceDisposable => products == null
      ? 0
      : products
          .where((e) => e.productType == 2)
          .fold(0, (p, e) => p + e.buyingPrice);

  double get totalProduct =>
      products == null ? 0 : products.fold(0, (p, e) => p + e.totalProduct);

  double get total => (totalPrice + service) - discount;
  double get totalStock => (totalPriceStock + service) - discount;
  double get totalDisposable => (totalPriceDisposable + service) - discount;

  double get remainingBalance => balance - total;
  double get remainingBalanceStock => balance - totalStock;
  double get remainingBalanceDisposable => balance - totalDisposable;

  factory StockModel.fromJson(Map<String, dynamic> json) =>
      _$PoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PoModelToJson(this);

  static List<StockModel> dummy = [
    StockModel(
      typeProcessIo: 1,
      dateTime: DateTime.now(),
      balance: 1000,
      prNumber: "PR00001",
      seepStatus: 1,
      image:
          "https://www.zahir.info/images/Image_Knowledgebase/Faktur_Setengah_Halaman_Z6/Gbr1.png",
      images: [
        "https://www.zahir.info/images/Image_Knowledgebase/Faktur_Setengah_Halaman_Z6/Gbr1.png",
        "https://www.zahir.info/images/Image_Knowledgebase/Faktur_Setengah_Halaman_Z6/Gbr1.png",
      ],
      products: ProductModel.dummy,
    ),
    StockModel(
      typeProcessIo: 1,
      dateTime: DateTime.now(),
      balance: 1000,
      prNumber: "PR00001",
      seepStatus: 1,
      image:
          "https://www.zahir.info/images/Image_Knowledgebase/Faktur_Setengah_Halaman_Z6/Gbr1.png",
      images: [
        "https://www.zahir.info/images/Image_Knowledgebase/Faktur_Setengah_Halaman_Z6/Gbr1.png",
        "https://www.zahir.info/images/Image_Knowledgebase/Faktur_Setengah_Halaman_Z6/Gbr1.png",
      ],
      products: ProductModel.dummy,
    ),
    StockModel(
      typeProcessIo: 2,
      dateTime: DateTime.now(),
      balance: 1000,
      prNumber: "PR00001",
      seepStatus: 1,
      image:
          "https://www.zahir.info/images/Image_Knowledgebase/Faktur_Setengah_Halaman_Z6/Gbr1.png",
      images: [
        "https://www.zahir.info/images/Image_Knowledgebase/Faktur_Setengah_Halaman_Z6/Gbr1.png",
        "https://www.zahir.info/images/Image_Knowledgebase/Faktur_Setengah_Halaman_Z6/Gbr1.png",
      ],
      products: ProductModel.dummy,
    ),
    StockModel(
      typeProcessIo: 2,
      dateTime: DateTime.now(),
      balance: 1000,
      prNumber: "PR00001",
      seepStatus: 1,
      image:
          "https://www.zahir.info/images/Image_Knowledgebase/Faktur_Setengah_Halaman_Z6/Gbr1.png",
      images: [
        "https://www.zahir.info/images/Image_Knowledgebase/Faktur_Setengah_Halaman_Z6/Gbr1.png",
        "https://www.zahir.info/images/Image_Knowledgebase/Faktur_Setengah_Halaman_Z6/Gbr1.png",
      ],
      products: ProductModel.dummy,
    ),
  ];
}
