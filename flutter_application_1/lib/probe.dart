import 'package:flutter/material.dart';

int globalCounter = 0; // top-level variable
final startedAt = DateTime.now(); // top-level final

class Probe extends StatelessWidget {
  const Probe({super.key});

  static int staticCounter = 0; // static field

  @override
  Widget build(BuildContext context) {
    debugPrint('Probe.build');

    return Scaffold(
      appBar: AppBar(title: const Text('Counter Probe')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('staticCounter: ${Probe.staticCounter}'),
            Text('globalCounter: $globalCounter'),
            Text('startedAt: $startedAt'),
            const Text('LABEL v3'),
          ],
        ),
      ),
    );
  }
}