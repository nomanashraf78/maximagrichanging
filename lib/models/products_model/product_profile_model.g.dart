// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductProfile _$ProductProfileFromJson(Map<String, dynamic> json) =>
    ProductProfile(
      productName: json['productName'] as String,
      productSKU: json['productSKU'] as String,
      productDescription: json['productDescription'] as String,
      productCategory: json['productCategory'] as String,
      productGroup: json['productGroup'] as String,
      productWeight: (json['productWeight'] as num).toDouble(),
      productMOQ: json['productMOQ'] as int,
      productPrice: (json['productPrice'] as num).toDouble(),
      productBrand: json['productBrand'] as String,
      provincePrices: (json['provincePrices'] as List<dynamic>)
          .map((e) => ProvincePrice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductProfileToJson(ProductProfile instance) =>
    <String, dynamic>{
      'productName': instance.productName,
      'productBrand': instance.productBrand,
      'provincePrices': instance.provincePrices,
      'productSKU': instance.productSKU,
      'productDescription': instance.productDescription,
      'productCategory': instance.productCategory,
      'productGroup': instance.productGroup,
      'productMOQ': instance.productMOQ,
      'productWeight': instance.productWeight,
      'productPrice': instance.productPrice,
    };
