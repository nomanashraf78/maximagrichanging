import 'package:flutter/material.dart';
import 'package:maximagri/models/order_model/single_order_model.dart';
import 'package:maximagri/widgets/display_order_details.dart';
import 'package:maximagri/widgets/drawer/operations_drawer.dart';
import 'package:maximagri/widgets/navigation/operations_navigation.dart';
import 'package:maximagri/services/perform_status_update.dart';

class OperationsOrderDetailsMobilePage extends StatefulWidget {
  final SingleOrder orderDetails;
  final String orderDocID;

  const OperationsOrderDetailsMobilePage(
      {Key? key, required this.orderDetails, required this.orderDocID})
      : super(key: key);

  @override
  State<OperationsOrderDetailsMobilePage> createState() =>
      _OperationsOrderDetailsMobilePageState();
}

class _OperationsOrderDetailsMobilePageState
    extends State<OperationsOrderDetailsMobilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Operations Order Details'),
      ),
      drawer: const OperationsDrawer(),
      bottomNavigationBar: const OperationsNavigation(selectedIndex: 2),
      body: SafeArea(
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
    );
  }
}
