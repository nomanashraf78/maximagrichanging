// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleOrder _$SingleOrderFromJson(Map<String, dynamic> json) => SingleOrder(
      dealerUID: json['dealerUID'] as String,
      dealerName: json['dealerName'] as String,
      orderSerial: json['orderSerial'] as String,
      orderTotal: (json['orderTotal'] as num).toDouble(),
      orderQuantity: (json['orderQuantity'] as num).toDouble(),
      dateTime: DateTime.parse(json['dateTime'] as String),
      orderStatus: $enumDecode(_$OrderStatusEnumMap, json['orderStatus']),
      orderStops: (json['orderStops'] as List<dynamic>)
          .map((e) => OrderStops.fromJson(e as Map<String, dynamic>))
          .toList(),
      operationsUID: json['operationsUID'] as String,
      zonalManagerUID: json['zonalManagerUID'] as String,
      salesManagerUID: json['salesManagerUID'] as String,
      salesOfficerUID: json['salesOfficerUID'] as String,
      creditPayment: (json['creditPayment'] as num).toDouble(),
      province: json['province'] as String,
      district: json['district'] as String,
      tehsil: json['tehsil'] as String,
      bankReceipt: json['bankReceipt'] as String,
      rentAdjustment: (json['rentAdjustment'] as num).toDouble(),
      bankAmount: (json['bankAmount'] as num).toDouble(),
      bankName: json['bankName'] as String,
      dispatchTime: DateTime.parse(json['dispatchTime'] as String),
      vehicleNo: json['vehicleNo'] as String,
      driverContact: json['driverContact'] as String,
      dealerNumber: json['dealerNumber'] as String,
      franchiseeUID: json['franchiseeUID'] as String,
      isApprovedByZSM: json['isApprovedByZSM'] as String,
    );

Map<String, dynamic> _$SingleOrderToJson(SingleOrder instance) =>
    <String, dynamic>{
      'dealerUID': instance.dealerUID,
      'dealerName': instance.dealerName,
      'orderSerial': instance.orderSerial,
      'orderTotal': instance.orderTotal,
      'orderQuantity': instance.orderQuantity,
      'dateTime': instance.dateTime.toIso8601String(),
      'orderStatus': _$OrderStatusEnumMap[instance.orderStatus]!,
      'dealerNumber': instance.dealerNumber,
      'tehsil': instance.tehsil,
      'district': instance.district,
      'province': instance.province,
      'driverContact': instance.driverContact,
      'vehicleNo': instance.vehicleNo,
      'dispatchTime': instance.dispatchTime.toIso8601String(),
      'bankName': instance.bankName,
      'bankAmount': instance.bankAmount,
      'bankReceipt': instance.bankReceipt,
      'creditPayment': instance.creditPayment,
      'rentAdjustment': instance.rentAdjustment,
      'isApprovedByZSM': instance.isApprovedByZSM,
      'franchiseeUID': instance.franchiseeUID,
      'operationsUID': instance.operationsUID,
      'zonalManagerUID': instance.zonalManagerUID,
      'salesManagerUID': instance.salesManagerUID,
      'salesOfficerUID': instance.salesOfficerUID,
      'orderStops': instance.orderStops,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.canceled: 'canceled',
  OrderStatus.rejected: 'rejected',
  OrderStatus.confirmed: 'confirmed',
  OrderStatus.forwarded: 'forwarded',
  OrderStatus.approved: 'approved',
  OrderStatus.processing: 'processing',
  OrderStatus.dispatched: 'dispatched',
  OrderStatus.delivered: 'delivered',
};
