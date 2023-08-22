import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:cobit_dss_app/tabs/ragchart_tab.dart';

void main() {
  group('RAGChartTab tests', () {
    testWidgets('RAGChartTab should display a table with rows',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(
        home: RAGChartTab(
          quarter1Data: [1, 2, 3, 4, 5],
          quarter2Data: [1, 2, 3, 4, 5],
          quarter3Data: [1, 2, 3, 4, 5],
          quarter4Data: [1, 2, 3, 4, 5],
        ),
      ));

      // Check if the header row exists
      expect(find.text('Domain'), findsOneWidget);
      expect(find.text('Quarter'), findsOneWidget);
      expect(find.text('Score'), findsOneWidget);

      // Check for the existence of domain names
      expect(find.text('Evaluate'), findsOneWidget);
      expect(find.text('Align'), findsOneWidget);
      expect(find.text('Build'), findsOneWidget);
      expect(find.text('Deliver'), findsOneWidget);
      expect(find.text('Monitor'), findsOneWidget);

      // Check for quarters
      expect(find.text('Q1'), findsNWidgets(5));
      expect(find.text('Q2'), findsNWidgets(5));
      expect(find.text('Q3'), findsNWidgets(5));
      expect(find.text('Q4'), findsNWidgets(5));
    });

    testWidgets('Table cell color should be green if percentage >= 0.75',
        (WidgetTester tester) async {
      // 1. Create and pass mock data. Ensure at least one value is above 75%.
      final List<int> quarter1MockData = [80, 40, 30, 50, 60];
      final List<int> quarter2MockData = [20, 40, 30, 50, 60];
      final List<int> quarter3MockData = [30, 40, 30, 50, 60];
      final List<int> quarter4MockData = [60, 40, 30, 50, 60];
      final List<int> maxScores = [
        100,
        100,
        100,
        100,
        100
      ]; // Assuming all max scores are 100.

      // 2. Render your widget using tester.pumpWidget
      await tester.pumpWidget(MaterialApp(
        home: RAGChartTab(
          quarter1Data: quarter1MockData,
          quarter2Data: quarter2MockData,
          quarter3Data: quarter3MockData,
          quarter4Data: quarter4MockData,
        ),
      ));
      await tester.pumpAndSettle();

      // 3. Calculate the expected count of green-colored cells.
      int expectedGreenCount = 0;
      for (int i = 0; i < quarter1MockData.length; i++) {
        if (quarter1MockData[i] / maxScores[i] >= 0.75) {
          expectedGreenCount++;
        }
        if (quarter2MockData[i] / maxScores[i] >= 0.75) {
          expectedGreenCount++;
        }
        if (quarter3MockData[i] / maxScores[i] >= 0.75) {
          expectedGreenCount++;
        }
        if (quarter4MockData[i] / maxScores[i] >= 0.75) {
          expectedGreenCount++;
        }
      }
      // The multiplication by 4 is no longer necessary as we are already accounting for each quarter separately.
      expectedGreenCount *= 4;
      // 4. Find all Container widgets and count the green ones.
      Iterable<Container> containers =
          tester.widgetList<Container>(find.byType(Container));
      int greenCount = containers
          .where((container) => container.color == Colors.green)
          .length;

      expect(greenCount, expectedGreenCount,
          reason: 'Expected $expectedGreenCount cells to have green color');
    });
  });
}
