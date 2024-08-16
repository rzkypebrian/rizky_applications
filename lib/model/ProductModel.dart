import 'package:json_annotation/json_annotation.dart';
part 'ProductModel.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductModel {
  int productId;
  String productGuid;
  String productCode;
  String productName;
  String shortDecsription;
  String longDescription;
  String productUom;
  int status;
  bool isDeleted;
  String insertedBy;
  DateTime insertedDate;
  String modifiedBy;
  DateTime modifiedDate;
  double buyingPrice;
  double sellingPrice;
  double totalProduct;
  String image;
  String sallerName;
  String idMaintenance;
  int productType; // 1 stock 2 disposable

  ProductModel({
    this.productType = 1,
    this.idMaintenance,
    this.sallerName,
    this.image,
    this.buyingPrice = 0,
    this.sellingPrice = 0,
    this.totalProduct = 0,
    this.productId,
    this.productGuid,
    this.productCode,
    this.productName,
    this.shortDecsription,
    this.longDescription,
    this.productUom,
    this.status,
    this.isDeleted,
    this.insertedBy,
    this.insertedDate,
    this.modifiedBy,
    this.modifiedDate,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  static List<ProductModel> dummy = [
    ProductModel(
      productId: 1,
      productName: "ban",
      sallerName: "Toko Indah Motor",
      totalProduct: 1,
      buyingPrice: 900,
      status: 1,
      image: "https://img.lovepik.com/element/40028/4927.png_300.png",
      productType: 2,
    ),
    ProductModel(
      productId: 2,
      productName: "ban",
      sallerName: "Toko Indah Motor",
      totalProduct: 1,
      buyingPrice: 900,
      status: 1,
      image: "https://img.lovepik.com/element/40028/4927.png_300.png",
      productType: 2,
    ),
    ProductModel(
      productId: 1,
      productName: "ban",
      sallerName: "Toko Indah Motor",
      totalProduct: 1,
      buyingPrice: 900,
      status: 1,
      image: "https://img.lovepik.com/element/40028/4927.png_300.png",
    ),
    ProductModel(
      productId: 2,
      productName: "ban",
      sallerName: "Toko Indah Motor",
      totalProduct: 1,
      buyingPrice: 900,
      status: 1,
      image: "https://img.lovepik.com/element/40028/4927.png_300.png",
    ),
    ProductModel(
      productId: 1,
      productName: "ban",
      sallerName: "Toko Indah Motor",
      totalProduct: 1,
      buyingPrice: 900,
      status: 1,
      image: "https://img.lovepik.com/element/40028/4927.png_300.png",
      productType: 2,
    ),
    ProductModel(
      productId: 2,
      productName: "ban",
      sallerName: "Toko Indah Motor",
      totalProduct: 1,
      buyingPrice: 900,
      status: 1,
      image: "https://img.lovepik.com/element/40028/4927.png_300.png",
      productType: 2,
    ),
    ProductModel(
      productId: 1,
      productName: "ban",
      sallerName: "Toko Indah Motor",
      totalProduct: 1,
      buyingPrice: 900,
      status: 1,
      image: "https://img.lovepik.com/element/40028/4927.png_300.png",
    ),
    ProductModel(
      productId: 2,
      productName: "ban",
      sallerName: "Toko Indah Motor",
      totalProduct: 1,
      buyingPrice: 900,
      status: 1,
      image: "https://img.lovepik.com/element/40028/4927.png_300.png",
    ),
  ];
}
