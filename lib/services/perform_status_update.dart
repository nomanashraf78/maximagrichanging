import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maximagri/models/order_model/single_order_model.dart';
import 'package:maximagri/models/products_model/products_list_model.dart';
import 'package:maximagri/widgets/show_dialog_message.dart';

import '../models/order_model/order_status_enum.dart';

class PerformStatusUpdate extends StatefulWidget {
  final SingleOrder orderDetails;
  final String orderDocID;

  const PerformStatusUpdate(
      {Key? key, required this.orderDetails, required this.orderDocID})
      : super(key: key);

  @override
  State<PerformStatusUpdate> createState() => _PerformStatusUpdateState();
}

class _PerformStatusUpdateState extends State<PerformStatusUpdate> {
  final mobileNumberController = TextEditingController();
  final vehicleNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('userProfile')
            .where('userUID', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return const CircularProgressIndicator();
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            final userType = snapshot.data?.docs.first.get('userType');
            if (userType == 'dealer') {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (widget.orderDetails.orderStatus ==
                          OrderStatus.pending) {
                        widget.orderDetails.updateOrderStatus(
                            newOrderStatus: OrderStatus.canceled);
                        firebaseOrderStatusUpdate(
                            orderDetails: widget.orderDetails,
                            orderDocID: widget.orderDocID);
                      } else {
                        showMessageDialog(
                            context: context,
                            message:
                                'Sorry! Your order has been processed already!');
                      }
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: Text('Cancel Order'.toUpperCase()),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.orderDetails.orderStatus ==
                          OrderStatus.dispatched) {
                        widget.orderDetails.updateOrderStatus(
                            newOrderStatus: OrderStatus.delivered);
                        firebaseOrderStatusUpdate(
                            orderDetails: widget.orderDetails,
                            orderDocID: widget.orderDocID);
                      } else {
                        showMessageDialog(
                            context: context,
                            message:
                                'Please wait for the order to dispatch first!');
                      }
                    },
                    child: Text('Mark Delivered'.toUpperCase()),
                  ),
                ],
              );
            } else if (userType == 'salesOfficer') {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (widget.orderDetails.orderStatus ==
                          OrderStatus.pending) {
                        widget.orderDetails.updateOrderStatus(
                            newOrderStatus: OrderStatus.rejected);
                        firebaseOrderStatusUpdate(
                            orderDetails: widget.orderDetails,
                            orderDocID: widget.orderDocID);
                      } else {
                        showMessageDialog(
                            context: context,
                            message:
                                'Sorry! This order has been processed already!');
                      }
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: Text('Reject Order'.toUpperCase()),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.orderDetails.orderStatus ==
                          OrderStatus.pending) {
                        widget.orderDetails.updateOrderStatus(
                            newOrderStatus: OrderStatus.confirmed);
                        firebaseOrderStatusUpdate(
                            orderDetails: widget.orderDetails,
                            orderDocID: widget.orderDocID);
                      } else {
                        showMessageDialog(
                            context: context,
                            message:
                                'Sorry! This order has been processed already!');
                      }
                    },
                    child: Text('Confirm Order'.toUpperCase()),
                  ),
                ],
              );
            } else if (userType == 'salesManager') {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (widget.orderDetails.orderStatus ==
                              OrderStatus.pending ||
                          widget.orderDetails.orderStatus ==
                              OrderStatus.confirmed) {
                        widget.orderDetails.updateOrderStatus(
                            newOrderStatus: OrderStatus.rejected);
                        firebaseOrderStatusUpdate(
                            orderDetails: widget.orderDetails,
                            orderDocID: widget.orderDocID);
                      } else {
                        showMessageDialog(
                            context: context,
                            message:
                                'Sorry! This order has been processed already!');
                      }
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: Text('Reject Order'.toUpperCase()),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.orderDetails.orderStatus ==
                              OrderStatus.pending ||
                          widget.orderDetails.orderStatus ==
                              OrderStatus.confirmed) {
                        widget.orderDetails.updateOrderStatus(
                            newOrderStatus: OrderStatus.forwarded);
                        firebaseOrderStatusUpdate(
                            orderDetails: widget.orderDetails,
                            orderDocID: widget.orderDocID);
                      } else {
                        showMessageDialog(
                            context: context,
                            message:
                                'Sorry! This order has been processed already!');
                      }
                    },
                    child: Text('Forward Order'.toUpperCase()),
                  ),
                ],
              );
            } else if (userType == 'zonalManager') {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (widget.orderDetails.orderStatus ==
                          OrderStatus.forwarded) {
                        widget.orderDetails.updateOrderStatus(
                            newOrderStatus: OrderStatus.rejected);
                        firebaseOrderStatusUpdate(
                            orderDetails: widget.orderDetails,
                            orderDocID: widget.orderDocID);
                      } else {
                        showMessageDialog(
                            context: context,
                            message:
                                'Sorry! This order has been processed already!');
                      }
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: Text('Reject Order'.toUpperCase()),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.orderDetails.orderStatus ==
                          OrderStatus.forwarded) {
                        widget.orderDetails.updateOrderStatus(
                            newOrderStatus: OrderStatus.approved);
                        firebaseOrderStatusUpdate(
                            orderDetails: widget.orderDetails,
                            orderDocID: widget.orderDocID);
                      } else {
                        showMessageDialog(
                            context: context,
                            message:
                                'Sorry! This order has been processed already!');
                      }
                    },
                    child: Text('Approve Order'.toUpperCase()),
                  ),
                ],
              );
            } else if (userType == 'operations') {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (widget.orderDetails.orderStatus ==
                              OrderStatus.approved) {
                            widget.orderDetails.updateOrderStatus(
                                newOrderStatus: OrderStatus.rejected);
                            firebaseOrderStatusUpdate(
                                orderDetails: widget.orderDetails,
                                orderDocID: widget.orderDocID);
                          } else {
                            showMessageDialog(
                                context: context,
                                message:
                                    'Sorry! This order has been processed already!');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: Text('Reject Order'.toUpperCase()),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (widget.orderDetails.orderStatus ==
                              OrderStatus.approved) {
                            widget.orderDetails.updateOrderStatus(
                                newOrderStatus: OrderStatus.processing);
                            firebaseOrderStatusUpdate(
                                orderDetails: widget.orderDetails,
                                orderDocID: widget.orderDocID);
                            updateProductStatistics(
                                orderDetails: widget.orderDetails);
                          } else {
                            showMessageDialog(
                                context: context,
                                message:
                                    'Sorry! This order has been processed already!');
                          }
                        },
                        child: Text('Mark Processing'.toUpperCase()),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: mobileNumberController,
                          decoration: const InputDecoration(
                            labelText: 'ENTER DRIVER NO',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: vehicleNumberController,
                          decoration: const InputDecoration(
                            labelText: 'ENTER VEHICLE NO',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (widget.orderDetails.orderStatus ==
                              OrderStatus.processing) {
                            if (mobileNumberController.text == '' ||
                                mobileNumberController.text.length != 11) {
                              showMessageDialog(
                                  context: context,
                                  message:
                                      'Please Enter 11 digits Driver Contact No!');
                            } else if (vehicleNumberController.text == '') {
                              showMessageDialog(
                                  context: context,
                                  message: 'Please Enter Vehicle No!');
                            } else {
                              widget.orderDetails.updateDispatchInfo(
                                newOrderStatus: OrderStatus.dispatched,
                                newDriverContact: mobileNumberController.text,
                                newVehicleNo: vehicleNumberController.text,
                                newDispatchTime: DateTime.now(),
                              );
                              firebaseOrderStatusUpdate(
                                orderDetails: widget.orderDetails,
                                orderDocID: widget.orderDocID,
                              );
                            }
                          } else {
                            showMessageDialog(
                                context: context,
                                message:
                                    'Sorry! This order has been processed already!');
                          }
                        },
                        child: Text('Dispatch Order'.toUpperCase()),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }
        });
  }

  void firebaseOrderStatusUpdate(
      {required SingleOrder orderDetails, required String orderDocID}) async {
    try {
      // update order status on firebase
      await FirebaseFirestore.instance
          .collection('ordersList')
          .doc(orderDocID)
          .update(orderDetails.toJson())
          .then(
            (value) => showMessageDialog(
                context: context,
                message: 'Order status updated successfully!'),
          );
    } catch (e) {
      showMessageDialog(
          context: context,
          message: 'Order status update failed!\n${e.toString()}');
    }
  }

  void updateProductStatistics({required SingleOrder orderDetails}) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('productsList').get();

    for (int i = 0; i < snapshot.docs.length; i++) {
      final json = snapshot.docs[i].data();
      final productDocID = snapshot.docs[i].id;
      ProductsList product = ProductsList.fromJson(json);

      for (int s = 0; s < orderDetails.orderStops.length; s++) {
        for (int p = 0; p < orderDetails.orderStops[s].itemList.length; p++) {
          if (orderDetails.orderStops[s].itemList[p].productName ==
              product.itemName) {
            product.itemSales +=
                orderDetails.orderStops[s].itemList[p].productQuantity;

            FirebaseFirestore.instance
                .collection('productsList')
                .doc(productDocID)
                .update(product.toJson());
          }
        }
      }
    }
  }
}
