import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cobit_dss_app/tabs/individual_barchart.dart';

void main() {
  testWidgets('IndividualBarChart widget test', (WidgetTester tester) async {
    final quarterData = [50, 60, 70, 80, 90];
    final quarterName = 'Q1';
    final color = Colors.blue;

    await tester.pumpWidget(
      MaterialApp(
        home: IndividualBarChart(
          quarter: quarterName,
          quarterData: quarterData,
          tabController: TabController(length: 2, vsync: TestVSync()),
          color: color,
        ),
      ),
    );

    // Verify that the title is displayed
    expect(find.text(quarterName), findsOneWidget);

    // Tap on the share button
    await tester.tap(find.byIcon(Icons.ios_share_sharp));
    await tester.pumpAndSettle(); // Wait for the widget to settle after the tap
  });
}
