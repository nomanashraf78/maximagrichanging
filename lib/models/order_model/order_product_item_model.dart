import 'package:json_annotation/json_annotation.dart';
import 'package:maximagri/models/order_controllers_model/item_list_controllers_model.dart';
part 'order_product_item_model.g.dart';

@JsonSerializable()
class OrderProductItem {
  String productName;
  double productQuantity;
  double productPrice;
  double productTotal;
  OrderProductItem({
    required this.productName,
    required this.productQuantity,
    required this.productPrice,
    required this.productTotal,
  });

  factory OrderProductItem.fromOrderControllers(
          ItemListControllers itemListControllers) =>
      OrderProductItem(
          productName: itemListControllers.productNameController.text,
          productQuantity:
              double.parse(itemListControllers.productQuantityController.text),
          productPrice:
              double.parse(itemListControllers.productPriceController.text),
          productTotal:
              double.parse(itemListControllers.productTotalController().text));

  factory OrderProductItem.fromJson(Map<String, dynamic> json) =>
      _$OrderProductItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderProductItemToJson(this);
}
