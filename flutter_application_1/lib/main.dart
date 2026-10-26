import 'package:flutter/material.dart';
import 'probe.dart';

void main() => runApp(const GenTrackApp());

class GenTrackApp extends StatelessWidget {
  const GenTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GenTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF7E7450), // industrial teal
      ),
      home: const Probe(),
    );
  }
}
