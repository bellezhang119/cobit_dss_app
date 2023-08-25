import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cobit_dss_app/tabs/summary_barchart_tab.dart'; // Update with your actual import path

void main() {
  testWidgets('SummaryBarChart widget test', (WidgetTester tester) async {
    final quarter1Data = [30, 40, 50];
    final quarter2Data = [20, 10, 30];
    final quarter3Data = [15, 25, 35];
    final quarter4Data = [10, 5, 15];

    await tester.pumpWidget(
      MaterialApp(
        home: SummaryBarChart(
          quarter1Data: quarter1Data,
          quarter2Data: quarter2Data,
          quarter3Data: quarter3Data,
          quarter4Data: quarter4Data,
          updateQuarter1Data: (data) {},
          updateQuarter2Data: (data) {},
          updateQuarter3Data: (data) {},
          updateQuarter4Data: (data) {},
          tabController: TabController(length: 4, vsync: TestVSync()),
        ),
      ),
    );

    // Verify that the chart title is displayed
    expect(find.text('COBIT 6 DSS Annual Summary Bar Chart'), findsOneWidget);

    // Tap on the screenshot button
    await tester.tap(find.byIcon(Icons.ios_share_sharp));
    await tester.pumpAndSettle(); // Wait for the animation to finish

    // You can add more verification steps here based on your app's behavior
  });
}