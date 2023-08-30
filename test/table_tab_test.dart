import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cobit_dss_app/tabs/table_tab.dart';

void main() {
  testWidgets('TableTab displays rows and handles value change',
      (WidgetTester tester) async {
    // Create a mock function for onAuditUpdated
    Map<String, int>? updatedAuditValues;
    void mockOnAuditUpdated(Map<String, int> updatedAudit) {
      updatedAuditValues = updatedAudit;
    }

    // Create a Map of mock audit data
    final mockAudits = {
      'code1': 0,
      'code2': 1,
      // Add more mock data here
    };

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: TableTab(
          audits: mockAudits,
          onAuditUpdated: mockOnAuditUpdated,
        ),
      ),
    );

    // Verify the initial table row content
    expect(find.text('DOMAIN'), findsOneWidget);
    expect(find.text('CODE'), findsOneWidget);
    expect(find.text('AUDIT(0/1)'), findsOneWidget);
    expect(find.text('SCORE'), findsOneWidget);
    expect(find.text('Total'), findsOneWidget);

    // Verify the updated table row content
    expect(find.text('DOMAIN'), findsOneWidget);
    expect(find.text('CODE'), findsOneWidget);
    expect(find.text('AUDIT(0/1)'), findsOneWidget);
    expect(find.text('SCORE'), findsOneWidget);
    expect(find.text('Total'), findsOneWidget);
  });
}
