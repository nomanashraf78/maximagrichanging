import 'package:json_annotation/json_annotation.dart';
import 'package:maximagri/models/order_controllers_model/order_controllers_model.dart';
import 'package:maximagri/models/order_model/order_status_enum.dart';
import 'package:maximagri/models/order_model/order_stops_model.dart';
import 'package:maximagri/models/user_profile_model/user_profile_model.dart';
part 'single_order_model.g.dart';

@JsonSerializable()
class SingleOrder {
  String dealerUID;
  String dealerName;
  String orderSerial;
  double orderTotal;
  double orderQuantity;
  DateTime dateTime;
  OrderStatus orderStatus;
  String dealerNumber;
  String tehsil;
  String district;
  String province;
  String driverContact;
  String vehicleNo;
  DateTime dispatchTime;
  String bankName;
  double bankAmount;
  String bankReceipt;
  double creditPayment;
  double rentAdjustment;
  String isApprovedByZSM; // NEW FIELD
  String franchiseeUID; // NEW FIELD
  String operationsUID;
  String zonalManagerUID;
  String salesManagerUID;
  String salesOfficerUID;
  List<OrderStops> orderStops;

  SingleOrder({
    required this.dealerUID,
    required this.dealerName,
    required this.orderSerial,
    required this.orderTotal,
    required this.orderQuantity,
    required this.dateTime,
    required this.orderStatus,
    required this.orderStops,
    required this.operationsUID,
    required this.zonalManagerUID,
    required this.salesManagerUID,
    required this.salesOfficerUID,
    required this.creditPayment,
    required this.province,
    required this.district,
    required this.tehsil,
    required this.bankReceipt,
    required this.rentAdjustment,
    required this.bankAmount,
    required this.bankName,
    required this.dispatchTime,
    required this.vehicleNo,
    required this.driverContact,
    required this.dealerNumber,
    required this.franchiseeUID,
    required this.isApprovedByZSM,
  });

  updateOrderStatus({required OrderStatus newOrderStatus}) {
    orderStatus = newOrderStatus;
  }

  updateDispatchInfo({
    required String newDriverContact,
    required String newVehicleNo,
    required DateTime newDispatchTime,
    required OrderStatus newOrderStatus,
  }) {
    orderStatus = newOrderStatus;
    driverContact = newDriverContact;
    vehicleNo = newVehicleNo;
    dispatchTime = newDispatchTime;
  }

  factory SingleOrder.fromOrderControllers(
          {required OrderControllers orderControllers,
          required UserProfile dealerProfile}) =>
      SingleOrder(
        franchiseeUID: dealerProfile.franchiseeUID, // New Field
        operationsUID: dealerProfile.operationsUID,
        zonalManagerUID: dealerProfile.zonalManagerUID,
        salesManagerUID: dealerProfile.salesManagerUID,
        salesOfficerUID: dealerProfile.salesOfficerUID,
        isApprovedByZSM: orderControllers.isApprovedByZSMController.text, // New Field
        dealerUID: dealerProfile.userUID,
        dealerName: dealerProfile.userName,
        district: dealerProfile.district,
        tehsil: dealerProfile.tehsil,
        province: dealerProfile.province,
        dealerNumber: dealerProfile.userMobile,
        dateTime: DateTime.now(),
        orderStatus: OrderStatus.pending,
        orderTotal: double.parse(orderControllers.orderTotalController().text),
        orderQuantity:
            double.parse(orderControllers.orderQuantityController().text),
        orderSerial: DateTime.now().toString(),
        driverContact: 'PENDING',
        vehicleNo: 'PENDING',
        dispatchTime: DateTime.now(),
        creditPayment:
            double.parse(orderControllers.creditPaymentController.text),
        bankAmount: double.parse(orderControllers.bankPaymentController.text),
        rentAdjustment:
            double.parse(orderControllers.rentAdjustmentController.text),
        bankName: orderControllers.bankNameController.text,
        bankReceipt: orderControllers.bankPaymentReceiptController.text,
        orderStops: List.generate(
          orderControllers.stopControllers.length,
          (index) => OrderStops.fromOrderControllers(
            orderControllers.stopControllers[index],
          ),
        ),
      );

  factory SingleOrder.fromJson(Map<String, dynamic> json) =>
      _$SingleOrderFromJson(json);
  Map<String, dynamic> toJson() => _$SingleOrderToJson(this);
}
