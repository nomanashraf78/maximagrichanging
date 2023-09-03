import 'package:flutter/material.dart';
import 'package:maximagri/services/operations_statistics.dart';
import 'package:maximagri/widgets/drawer/operations_drawer.dart';
import 'package:maximagri/widgets/navigation/operations_navigation.dart';

class OperationsStatisticsMobilePage extends StatefulWidget {
  const OperationsStatisticsMobilePage({Key? key}) : super(key: key);

  @override
  State<OperationsStatisticsMobilePage> createState() =>
      _OperationsStatisticsMobilePageState();
}

class _OperationsStatisticsMobilePageState
    extends State<OperationsStatisticsMobilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Operations Statistics'),
      ),
      drawer: const OperationsDrawer(),
      bottomNavigationBar: const OperationsNavigation(selectedIndex: 2),
      body: const SafeArea(
        child: OperationsStatistics(),
      ),
    );
  }
}
