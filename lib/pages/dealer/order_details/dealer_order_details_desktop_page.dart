import 'package:flutter/material.dart';
import 'package:maximagri/models/order_model/single_order_model.dart';
import 'package:maximagri/widgets/drawer/dealer_drawer.dart';
import 'package:maximagri/services/perform_status_update.dart';
import 'package:maximagri/widgets/display_order_details.dart';

class DealerOrderDetailsDesktopPage extends StatefulWidget {
  final SingleOrder orderDetails;
  final String orderDocID;

  const DealerOrderDetailsDesktopPage(
      {Key? key, required this.orderDetails, required this.orderDocID})
      : super(key: key);

  @override
  State<DealerOrderDetailsDesktopPage> createState() =>
      _DealerOrderDetailsDesktopPageState();
}

class _DealerOrderDetailsDesktopPageState
    extends State<DealerOrderDetailsDesktopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dealer Order Details'),
      ),
      body: Row(
        children: [
          const DealerDrawer(),
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
