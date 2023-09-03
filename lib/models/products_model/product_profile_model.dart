import 'package:json_annotation/json_annotation.dart';
import 'package:maximagri/models/products_model/product_prices_model.dart';
part 'product_profile_model.g.dart';

@JsonSerializable()
class ProductProfile {
  String productName;
  String productBrand; // NEW FIELD
  List<ProvincePrice> provincePrices; // NEW FIELD
  String productSKU;
  String productDescription;
  String productCategory;
  String productGroup;
  int productMOQ;
  double productWeight;
  double productPrice;
  ProductProfile({
    required this.productName,
    required this.productSKU,
    required this.productDescription,
    required this.productCategory,
    required this.productGroup,
    required this.productWeight,
    required this.productMOQ,
    required this.productPrice,
    required this.productBrand,
    required this.provincePrices,

  });

  factory ProductProfile.fromJson(Map<String, dynamic> json) =>
      _$ProductProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProductProfileToJson(this);
}
