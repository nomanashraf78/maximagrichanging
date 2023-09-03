// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dealer_credit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DealersCredit _$DealersCreditFromJson(Map<String, dynamic> json) =>
    DealersCredit(
      dealerUID: json['dealerUID'] as String,
      creditLimit: (json['creditLimit'] as num).toDouble(),
      availableCredit: (json['availableCredit'] as num).toDouble(),
    );

Map<String, dynamic> _$DealersCreditToJson(DealersCredit instance) =>
    <String, dynamic>{
      'dealerUID': instance.dealerUID,
      'creditLimit': instance.creditLimit,
      'availableCredit': instance.availableCredit,
    };
