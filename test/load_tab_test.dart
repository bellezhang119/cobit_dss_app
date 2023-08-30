import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cobit_dss_app/tabs/load_tab.dart';

void main() {
  testWidgets('LoadTab widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoadTab(
          updateQuarter1Data: (data) {},
          updateQuarter2Data: (data) {},
          updateQuarter3Data: (data) {},
          updateQuarter4Data: (data) {},
          onAuditUpdated: (data) {},
        ),
      ),
    );

    // Initial state checks
    expect(find.text('Q1:'), findsOneWidget);
    expect(find.text('Q2:'), findsOneWidget);
    expect(find.text('Q3:'), findsOneWidget);
    expect(find.text('Q4:'), findsOneWidget);

    // Simulate waiting for stream
    await tester.pump();

    // Verify CircularProgressIndicator is displayed
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Simulate receiving snapshot
    await tester.pump();

    // Verify CircularProgressIndicator is no longer displayed
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // Interact with the dropdown
    await tester.tap(find.text('Q1:'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Q2:'));
    await tester.pumpAndSettle();
  });
}
