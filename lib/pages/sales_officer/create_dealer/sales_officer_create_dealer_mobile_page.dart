import 'package:flutter/material.dart';
import 'package:maximagri/widgets/drawer/sales_officer_drawer.dart';
import 'package:maximagri/widgets/navigation/sales_officer_navigation.dart';
import 'package:maximagri/services/create_dealer_by_sales_officer.dart';

class SalesOfficerCreateDealerMobilePage extends StatefulWidget {
  const SalesOfficerCreateDealerMobilePage({Key? key}) : super(key: key);

  @override
  State<SalesOfficerCreateDealerMobilePage> createState() =>
      _SalesOfficerCreateDealerMobilePageState();
}

class _SalesOfficerCreateDealerMobilePageState
    extends State<SalesOfficerCreateDealerMobilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Officer Create Dealer'),
      ),
      drawer: const SalesOfficerDrawer(),
      bottomNavigationBar: const SalesOfficerNavigation(selectedIndex: 3),
      body: const SafeArea(
        child: SingleChildScrollView(child: CreateDealerBySalesOfficer()),
      ),
    );
  }
}
