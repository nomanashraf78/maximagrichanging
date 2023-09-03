import 'package:flutter/material.dart';
import 'package:maximagri/services/create_dealer_by_sales_officer.dart';
import 'package:maximagri/widgets/drawer/sales_officer_drawer.dart';

class SalesOfficerCreateDealerDesktopPage extends StatefulWidget {
  const SalesOfficerCreateDealerDesktopPage({Key? key}) : super(key: key);

  @override
  State<SalesOfficerCreateDealerDesktopPage> createState() =>
      _SalesOfficerCreateDealerDesktopPageState();
}

class _SalesOfficerCreateDealerDesktopPageState
    extends State<SalesOfficerCreateDealerDesktopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Officer Create Dealer'),
      ),
      body: const Row(
        children: [
          SalesOfficerDrawer(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CreateDealerBySalesOfficer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
