import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cobit_dss_app/tabs/comparative_barchart_tab.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  testWidgets('ComparativeBarChart widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ComparativeBarChart(
          quarter1Data: [70, 50, 30, 20, 40],
          quarter2Data: [40, 20, 50, 70, 30],
          quarter3Data: [60, 40, 20, 50, 10],
          quarter4Data: [70, 50, 30, 20, 40],
          updateQuarter1Data: (data) {},
          updateQuarter2Data: (data) {},
          updateQuarter3Data: (data) {},
          updateQuarter4Data: (data) {},
        ),
      ),
    );

    // Expect to find certain widgets in the widget tree
    expect(find.byType(SfCartesianChart), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Trigger a tap on the ElevatedButton
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(); // Wait for animations to complete
  });
}
