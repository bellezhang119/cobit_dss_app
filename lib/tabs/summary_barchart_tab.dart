import 'package:cobit_dss_app/tabs/individual_barchart.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:charts_common/src/common/color.dart' as charts_color;

class SummaryBarChart extends StatefulWidget {
  final List<int> quarter1Data;
  final List<int> quarter2Data;
  final List<int> quarter3Data;
  final List<int> quarter4Data;
  final Function(List<int>)? updateQuarter1Data;
  final Function(List<int>)? updateQuarter2Data;
  final Function(List<int>)? updateQuarter3Data;
  final Function(List<int>)? updateQuarter4Data;

  SummaryBarChart({
    Key? key,
    required this.quarter1Data,
    required this.quarter2Data,
    required this.quarter3Data,
    required this.quarter4Data,
    required this.updateQuarter1Data,
    required this.updateQuarter2Data,
    required this.updateQuarter3Data,
    required this.updateQuarter4Data,
  }) : super(key: key);

  @override
  _SummaryBarChartState createState() => _SummaryBarChartState();
}

class _SummaryBarChartState extends State<SummaryBarChart> {
  List<int> get quarter1Data => widget.quarter1Data;
  List<int> get quarter2Data => widget.quarter2Data;
  List<int> get quarter3Data => widget.quarter3Data;
  List<int> get quarter4Data => widget.quarter4Data;

  late List<Quarter> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      Quarter("Q1", calculateAverage(quarter1Data)),
      Quarter("Q2", calculateAverage(quarter2Data)),
      Quarter("Q3", calculateAverage(quarter3Data)),
      Quarter("Q4", calculateAverage(quarter4Data)),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  // Helper function to create a single legend item
  Widget legendItem(String text, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            color: color,
          ),
          SizedBox(width: 4),
          Text(text),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                child: Column(children: [
      Expanded(
          child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              tooltipBehavior: _tooltip,
              series: <ChartSeries<Quarter, String>>[
            ColumnSeries<Quarter, String>(
                onPointTap: (ChartPointDetails details) {
                  print(details.pointIndex);
                  switch (details.pointIndex) {
                    case 0:
                      navigateToIndividualBarChart("Q1", quarter1Data);
                      break;
                    case 1:
                      navigateToIndividualBarChart("Q2", quarter2Data);
                      break;
                    case 2:
                      navigateToIndividualBarChart("Q3", quarter3Data);
                      break;
                    case 3:
                      navigateToIndividualBarChart("Q4", quarter4Data);
                      break;
                  }
                },
                dataSource: data,
                xValueMapper: (Quarter data, _) => data.quarter,
                yValueMapper: (Quarter data, _) => data.score,
                color: Colors.black)
          ]))
    ]))));
  }

  void navigateToIndividualBarChart(String quarter, List<int> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            IndividualBarChart(quarter: quarter, quarterData: data),
      ),
    );
  }
}

int calculateAverage(List<int> numbers) {
  int sum = 0;
  int count = numbers.length;

  // Calculate the sum of all numbers in the list
  for (int number in numbers) {
    sum += number;
  }

  // Calculate the average and round it to the nearest integer
  int average = (sum / count).round();
  return average;
}

class Quarter {
  final String quarter;
  final int score;

  Quarter(this.quarter, this.score);
}
