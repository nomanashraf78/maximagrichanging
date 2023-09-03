// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_prices_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProvincePrice _$ProvincePriceFromJson(Map<String, dynamic> json) =>
    ProvincePrice(
      provinceName: json['provinceName'] as String,
      priceFiler: (json['priceFiler'] as num).toDouble(),
      priceNonFiler: (json['priceNonFiler'] as num).toDouble(),
    );

Map<String, dynamic> _$ProvincePriceToJson(ProvincePrice instance) =>
    <String, dynamic>{
      'provinceName': instance.provinceName,
      'priceFiler': instance.priceFiler,
      'priceNonFiler': instance.priceNonFiler,
    };
