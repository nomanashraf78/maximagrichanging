import 'package:json_annotation/json_annotation.dart';

part 'product_prices_model.g.dart';

@JsonSerializable()
class ProvincePrice {
  String provinceName;
  double priceFiler;
  double priceNonFiler;

  ProvincePrice({
    required this.provinceName,
    required this.priceFiler,
    required this.priceNonFiler,
  });

  factory ProvincePrice.fromJson(Map<String, dynamic> json) =>
      _$ProvincePriceFromJson(json);
  Map<String, dynamic> toJson() => _$ProvincePriceToJson(this);

}


