import 'package:flutter/material.dart';
import 'package:maximagri/models/order_controllers_model/stop_controllers_model.dart';

class OrderControllers {
  TextEditingController bankPaymentController;
  TextEditingController creditPaymentController;
  TextEditingController rentAdjustmentController;
  TextEditingController bankPaymentReceiptController;
  TextEditingController bankNameController;
  TextEditingController isApprovedByZSMController;
  List<StopControllers> stopControllers;
  OrderControllers({
    required this.stopControllers,
    required this.bankPaymentController,
    required this.creditPaymentController,
    required this.rentAdjustmentController,
    required this.bankPaymentReceiptController,
    required this.bankNameController,
    required this.isApprovedByZSMController,
  });

  TextEditingController orderTotalController() {
    TextEditingController orderTotalController = TextEditingController();
    double orderTotalAmount = 0;
    for (int i = 0; i < stopControllers.length; i++) {
      if (stopControllers[i].stopTotalController().text != '') {
        orderTotalAmount = orderTotalAmount +
            double.parse(stopControllers[i].stopTotalController().text);
      }
    }
    orderTotalController.text = orderTotalAmount.toString();
    // bankPaymentController.text = orderTotalAmount.toString();
    // creditPaymentController.text = '0';
    // rentAdjustmentController.text = '0';

    return orderTotalController;
  }

  TextEditingController orderQuantityController() {
    TextEditingController orderQuantityController = TextEditingController();
    double orderTotalQuantity = 0;
    for (int i = 0; i < stopControllers.length; i++) {
      if (stopControllers[i].stopQuantityController().text != '') {
        orderTotalQuantity = orderTotalQuantity +
            double.parse(stopControllers[i].stopQuantityController().text);
      }
    }
    orderQuantityController.text = orderTotalQuantity.toString();
    return orderQuantityController;
  }
}
