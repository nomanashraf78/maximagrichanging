import 'package:flutter/material.dart';

void showMessageDialog(
    {required String message, required BuildContext context}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'NOTIFICATION!\n',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ),
          Text(
            message,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const Text('\n'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('CANCEL')),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OKAY'),
              ),
            ],
          )
        ]),
      );
    },
  );
}
