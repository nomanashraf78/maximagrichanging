import 'package:flutter/material.dart';
import 'package:maximagri/models/order_model/single_order_model.dart';
import 'package:maximagri/widgets/display_order_details.dart';
import 'package:maximagri/widgets/drawer/operations_drawer.dart';
import 'package:maximagri/services/perform_status_update.dart';

class OperationsOrderDetailsDesktopPage extends StatefulWidget {
  final SingleOrder orderDetails;
  final String orderDocID;

  const OperationsOrderDetailsDesktopPage(
      {Key? key, required this.orderDetails, required this.orderDocID})
      : super(key: key);

  @override
  State<OperationsOrderDetailsDesktopPage> createState() =>
      _OperationsOrderDetailsDesktopPageState();
}

class _OperationsOrderDetailsDesktopPageState
    extends State<OperationsOrderDetailsDesktopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Operations Order Details'),
      ),
      body: Row(
        children: [
          const OperationsDrawer(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DisplayOrderDetails(orderDetails: widget.orderDetails),
                  PerformStatusUpdate(
                    orderDetails: widget.orderDetails,
                    orderDocID: widget.orderDocID,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
