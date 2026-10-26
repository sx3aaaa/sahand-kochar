import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/probe.dart';

void main() {
  testWidgets('Probe screen appears', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Probe()));
    expect(find.byType(Probe), findsOneWidget);
  });
}