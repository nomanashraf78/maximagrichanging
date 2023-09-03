import 'package:flutter/material.dart';

class ItemListControllers {
  TextEditingController productNameController;
  TextEditingController productQuantityController;
  TextEditingController productPriceController;

  ItemListControllers({
    required this.productNameController,
    required this.productQuantityController,
    required this.productPriceController,
  });
  TextEditingController productTotalController() {
    TextEditingController productTotalController = TextEditingController();
    if (productPriceController.text != '' &&
        productQuantityController.text != '') {
      double productPrice = double.parse(productPriceController.text);
      double productQuantity = double.parse(productQuantityController.text);
      double productTotal = productPrice * productQuantity;
      productTotalController.text = productTotal.toString();
    }
    return productTotalController;
  }
}
