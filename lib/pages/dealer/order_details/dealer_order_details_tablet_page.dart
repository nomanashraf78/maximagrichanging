import 'package:flutter/material.dart';
import 'package:maximagri/models/order_model/single_order_model.dart';
import 'package:maximagri/widgets/display_order_details.dart';
import 'package:maximagri/widgets/drawer/dealer_drawer.dart';
import 'package:maximagri/widgets/navigation/dealer_navigation.dart';
import 'package:maximagri/services/perform_status_update.dart';

class DealerOrderDetailsTabletPage extends StatefulWidget {
  final SingleOrder orderDetails;
  final String orderDocID;

  const DealerOrderDetailsTabletPage(
      {Key? key, required this.orderDetails, required this.orderDocID})
      : super(key: key);

  @override
  State<DealerOrderDetailsTabletPage> createState() =>
      _DealerOrderDetailsTabletPageState();
}

class _DealerOrderDetailsTabletPageState
    extends State<DealerOrderDetailsTabletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dealer Order Details'),
      ),
      drawer: const DealerDrawer(),
      bottomNavigationBar: const DealerNavigation(selectedIndex: 2),
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
