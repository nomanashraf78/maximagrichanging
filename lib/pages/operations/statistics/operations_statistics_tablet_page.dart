import 'package:flutter/material.dart';
import 'package:maximagri/services/operations_statistics.dart';
import 'package:maximagri/widgets/drawer/operations_drawer.dart';
import 'package:maximagri/widgets/navigation/operations_navigation.dart';

class OperationsStatisticsTabletPage extends StatefulWidget {
  const OperationsStatisticsTabletPage({Key? key}) : super(key: key);

  @override
  State<OperationsStatisticsTabletPage> createState() =>
      _OperationsStatisticsTabletPageState();
}

class _OperationsStatisticsTabletPageState
    extends State<OperationsStatisticsTabletPage> {
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
