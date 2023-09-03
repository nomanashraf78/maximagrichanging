import 'package:flutter/material.dart';
import 'package:maximagri/services/operations_statistics.dart';
import 'package:maximagri/widgets/drawer/operations_drawer.dart';

class OperationsStatisticsDesktopPage extends StatefulWidget {
  const OperationsStatisticsDesktopPage({Key? key}) : super(key: key);

  @override
  State<OperationsStatisticsDesktopPage> createState() =>
      _OperationsStatisticsDesktopPageState();
}

class _OperationsStatisticsDesktopPageState
    extends State<OperationsStatisticsDesktopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Operations Statistics'),
      ),
      body: const Row(
        children: [
          OperationsDrawer(),
          Expanded(
            child: OperationsStatistics(),
          ),
        ],
      ),
    );
  }
}
