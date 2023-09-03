import 'package:flutter/material.dart';
import 'package:maximagri/services/create_user_by_operations.dart';
import 'package:maximagri/widgets/drawer/operations_drawer.dart';

class OperationsCreateAccountDesktopPage extends StatefulWidget {
  const OperationsCreateAccountDesktopPage({Key? key}) : super(key: key);

  @override
  State<OperationsCreateAccountDesktopPage> createState() =>
      _OperationsCreateAccountDesktopPageState();
}

class _OperationsCreateAccountDesktopPageState
    extends State<OperationsCreateAccountDesktopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Operations Create Account'),
      ),
      body: const Row(
        children: [
          OperationsDrawer(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CreateUserByOperations(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
