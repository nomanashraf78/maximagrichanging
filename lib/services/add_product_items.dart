import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maximagri/models/order_controllers_model/item_list_controllers_model.dart';
import 'package:maximagri/models/order_controllers_model/order_controllers_model.dart';
import 'package:maximagri/models/products_model/products_list_model.dart';
import 'package:maximagri/widgets/show_dialog_message.dart';

class AddProductItems extends StatefulWidget {
  final OrderControllers orderControllers;
  final Function() notifyParent;
  final int stopIndex;
  final List<ProductsList> productsList;
  const AddProductItems(
      {Key? key,
      required this.stopIndex,
      required this.notifyParent,
      required this.productsList,
      required this.orderControllers})
      : super(key: key);

  @override
  State<AddProductItems> createState() => _AddProductItemsState();
}

class _AddProductItemsState extends State<AddProductItems> {
  String dropdownValue = '-SELECT PRODUCT-';
  List<String> productNamesList = ['-SELECT PRODUCT-'];

  addProductNamesToList() {
    for (int i = 0; i < widget.productsList.length; i++) {
      productNamesList.add(widget.productsList[i].itemName);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    addProductNamesToList();
    super.initState();
  }

  int productItemCounter = 1;
  int stopProductsQuantity = 0;

  addMoreProducts() => setState(() => productItemCounter++);

  removeProducts() => setState(
      () => productItemCounter > 1 ? productItemCounter-- : productItemCounter);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: productItemCounter,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      value: dropdownValue,
                      onChanged: (String? newValue) {
                        for (int i = 0; i < widget.productsList.length; i++) {
                          if (newValue == widget.productsList[i].itemName) {
                            widget
                                .orderControllers
                                .stopControllers[widget.stopIndex]
                                .itemListControllers[index]
                                .productNameController
                                .text = widget.productsList[i].itemName;
                            widget
                                    .orderControllers
                                    .stopControllers[widget.stopIndex]
                                    .itemListControllers[index]
                                    .productPriceController
                                    .text =
                                widget.productsList[i].itemPrice.toString();
                            widget
                                .orderControllers
                                .stopControllers[widget.stopIndex]
                                .itemListControllers[index]
                                .productQuantityController
                                .text = '1';
                          }
                        }

                        if (newValue == '-SELECT PRODUCT-') {
                          widget
                              .orderControllers
                              .stopControllers[widget.stopIndex]
                              .itemListControllers[index]
                              .productNameController
                              .text = '00.00';
                          widget
                              .orderControllers
                              .stopControllers[widget.stopIndex]
                              .itemListControllers[index]
                              .productPriceController
                              .text = '00.00';
                          widget
                              .orderControllers
                              .stopControllers[widget.stopIndex]
                              .itemListControllers[index]
                              .productQuantityController
                              .text = '00';
                        }
                        setState(() {
                          //   dropdownValue = newValue!;
                          widget.notifyParent();
                        });
                      },
                      items: productNamesList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: widget
                          .orderControllers
                          .stopControllers[widget.stopIndex]
                          .itemListControllers[index]
                          .productQuantityController,
                      decoration: const InputDecoration(hintText: '00'),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ], // Only numbers can be entered,
                      onChanged: (x) {
                        setState(() {});
                        widget.notifyParent();
                      },
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      enabled: false,
                      controller: widget
                          .orderControllers
                          .stopControllers[widget.stopIndex]
                          .itemListControllers[index]
                          .productPriceController,
                      decoration: const InputDecoration(hintText: '00.00'),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (x) {
                        setState(() {});
                        widget.notifyParent();
                      }, // Only numbers can be entered,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      enabled: false,
                      controller: widget
                          .orderControllers
                          .stopControllers[widget.stopIndex]
                          .itemListControllers[index]
                          .productTotalController(),
                      decoration: const InputDecoration(hintText: '00.00'),
                      textAlign: TextAlign.end,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ], // Only numbers can be entered,
                      onChanged: (x) {
                        setState(() {});
                        widget.notifyParent();
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  productItemCounter == index + 1 && productItemCounter != 1
                      ? OutlinedButton(
                          onPressed: () {
                            widget
                                .orderControllers
                                .stopControllers[widget.stopIndex]
                                .itemListControllers
                                .removeLast();
                            removeProducts();
                            widget.notifyParent();
                          },
                          child: const Text('REMOVE PRODUCT'),
                        )
                      : const SizedBox(),
                  productItemCounter == index + 1
                      ? ElevatedButton(
                          onPressed: () {
                            if (widget
                                        .orderControllers
                                        .stopControllers[widget.stopIndex]
                                        .itemListControllers[index]
                                        .productTotalController()
                                        .text ==
                                    '' ||
                                widget
                                        .orderControllers
                                        .stopControllers[widget.stopIndex]
                                        .itemListControllers[index]
                                        .productTotalController()
                                        .text ==
                                    '0' ||
                                widget
                                        .orderControllers
                                        .stopControllers[widget.stopIndex]
                                        .itemListControllers[index]
                                        .productNameController
                                        .text ==
                                    '-SELECT PRODUCT-') {
                              showMessageDialog(
                                  message:
                                      'Please add product to the current row first!',
                                  context: context);
                            } else {
                              widget
                                  .orderControllers
                                  .stopControllers[widget.stopIndex]
                                  .itemListControllers
                                  .add(
                                ItemListControllers(
                                  productNameController:
                                      TextEditingController(),
                                  productQuantityController:
                                      TextEditingController(),
                                  productPriceController:
                                      TextEditingController(),
                                ),
                              );
                              addMoreProducts();
                            }
                          },
                          child: const Text('ADD PRODUCT'),
                        )
                      : const SizedBox(),
                ],
              )
            ],
          );
        });
  }
}
