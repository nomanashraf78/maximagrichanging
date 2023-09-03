import 'package:flutter/material.dart';
import 'package:maximagri/models/order_controllers_model/item_list_controllers_model.dart';

class StopControllers {
  TextEditingController stopNameController;
  TextEditingController stopContactController;
  List<ItemListControllers> itemListControllers;
  StopControllers({
    required this.stopContactController,
    required this.stopNameController,
    required this.itemListControllers,
  });
  TextEditingController stopTotalController() {
    TextEditingController stopTotalController = TextEditingController();
    double stopTotalAmount = 0;
    for (int i = 0; i < itemListControllers.length; i++) {
      if (itemListControllers[i].productTotalController().text != '') {
        stopTotalAmount = stopTotalAmount +
            double.parse(itemListControllers[i].productTotalController().text);
      }
    }
    stopTotalController.text = stopTotalAmount.toString();
    return stopTotalController;
  }

  TextEditingController stopQuantityController() {
    TextEditingController stopQuantityController = TextEditingController();
    double stopTotalQuantity = 0;
    for (int i = 0; i < itemListControllers.length; i++) {
      if (itemListControllers[i].productQuantityController.text != '') {
        stopTotalQuantity = stopTotalQuantity +
            double.parse(itemListControllers[i].productQuantityController.text);
      }
    }
    stopQuantityController.text = stopTotalQuantity.toString();
    return stopQuantityController;
  }
}
