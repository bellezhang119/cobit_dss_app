import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:cobit_dss_app/tabs/save_tab.dart';

void main() {
  group('SaveTab tests', () {
    testWidgets('SaveTab should display a TextField and ElevatedButton',
        (WidgetTester tester) async {
      final mockAudits = {'1': 1, '2': 2};

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SaveTab(audits: mockAudits),
        ),
      ));

      expect(find.byType(TextField), findsOneWidget);

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Entering text in TextField updates the value',
        (WidgetTester tester) async {
      final mockAudits = {'1': 1, '2': 2};
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SaveTab(audits: mockAudits),
        ),
      ));

      var textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      await tester.enterText(textField, 'Test Save Name');
      await tester.pump();

      expect(find.text('Test Save Name'), findsOneWidget);
    });
  });
}
