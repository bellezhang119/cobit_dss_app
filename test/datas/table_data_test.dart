import 'package:cobit_dss_app/datas/table_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final List<int> testAudits = List<int>.filled(40, 0);

  test('test calculate scores function', () {
    final List<int> expectedValues = List<int>.filled(40, 0);
    expectedValues[0] = 25;
    expectedValues[5] = 52;
    expectedValues[19] = 34;
    expectedValues[30] = 20;
    expectedValues[36] = 10;

    expect(TableData.calculateScores(testAudits), expectedValues);
  });

  test('test calculateMaxDomainScores function', () {
    final List<int> expectedMaxScores = [150, 266, 144, 92, 40];

    expect(TableData.calculateMaxDomainScores(), expectedMaxScores);
  });

  test('test calculateDomainScores function', () {
    expect(TableData.calculateDomainScores(testAudits), [25, 52, 34, 20, 10]);
  });

  test('initialize objectives', () {
    expect(TableData.objectives[0],
        'Ensured governance framework setting and maintenance');
  });
}
