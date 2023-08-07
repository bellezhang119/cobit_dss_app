import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:charts_common/src/common/color.dart' as charts_color;

class IndividualBarChart extends StatefulWidget {
  final String quarter;
  final List<int> quarterData;

  IndividualBarChart(
      {Key? key, required this.quarter, required this.quarterData})
      : super(key: key);

  @override
  _IndividualBarChartState createState() => _IndividualBarChartState();
}

class _IndividualBarChartState extends State<IndividualBarChart> {
  List<int> get quarterData => widget.quarterData;
  List<int> get quarter => widget.quarterData;

  late String quarterName;
  late List<Domain> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    quarterName = widget.quarter;
    data = [
      Domain("Evaluate", quarterData[0]),
      Domain("Align", quarterData[1]),
      Domain("Build", quarterData[2]),
      Domain("Deliver", quarterData[3]),
      Domain("Monitor", quarterData[4])
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
        appBar: AppBar(),
        body: Center(
            child: Container(
                child: Column(children: [
          Expanded(
              child: SfCartesianChart(
                  title: ChartTitle(text: quarterName),
                  primaryXAxis: CategoryAxis(),
                  tooltipBehavior: _tooltip,
                  series: <ChartSeries<Domain, String>>[
                ColumnSeries<Domain, String>(
                  dataSource: data,
                  xValueMapper: (Domain data, _) => data.domain,
                  yValueMapper: (Domain data, _) => data.score,
                )
              ]))
        ]))));
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
}

class Domain {
  final String domain;
  final int score;

  Domain(this.domain, this.score);
}
