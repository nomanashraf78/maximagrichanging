import 'package:flutter/material.dart';
import 'package:maximagri/models/order_model/single_order_model.dart';
import 'package:maximagri/widgets/drawer/sales_manager_drawer.dart';
import 'package:maximagri/services/perform_status_update.dart';
import 'package:maximagri/widgets/display_order_details.dart';

class SalesManagerOrderDetailsDesktopPage extends StatefulWidget {
  final SingleOrder orderDetails;
  final String orderDocID;

  const SalesManagerOrderDetailsDesktopPage(
      {Key? key, required this.orderDetails, required this.orderDocID})
      : super(key: key);

  @override
  State<SalesManagerOrderDetailsDesktopPage> createState() =>
      _SalesManagerOrderDetailsDesktopPageState();
}

class _SalesManagerOrderDetailsDesktopPageState
    extends State<SalesManagerOrderDetailsDesktopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Manager Order Details'),
      ),
      body: Row(
        children: [
          const SalesManagerDrawer(),
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
