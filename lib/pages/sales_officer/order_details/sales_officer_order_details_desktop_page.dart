import 'package:flutter/material.dart';
import 'package:maximagri/models/order_model/single_order_model.dart';
import 'package:maximagri/widgets/drawer/sales_officer_drawer.dart';
import 'package:maximagri/services/perform_status_update.dart';
import 'package:maximagri/widgets/display_order_details.dart';

class SalesOfficerOrderDetailsDesktopPage extends StatefulWidget {
  final SingleOrder orderDetails;
  final String orderDocID;

  const SalesOfficerOrderDetailsDesktopPage(
      {Key? key, required this.orderDetails, required this.orderDocID})
      : super(key: key);

  @override
  State<SalesOfficerOrderDetailsDesktopPage> createState() =>
      _SalesOfficerOrderDetailsDesktopPageState();
}

class _SalesOfficerOrderDetailsDesktopPageState
    extends State<SalesOfficerOrderDetailsDesktopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Officer Order Details'),
      ),
      body: Row(
        children: [
          const SalesOfficerDrawer(),
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
