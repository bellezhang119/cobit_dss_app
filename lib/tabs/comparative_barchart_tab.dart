import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../datas/table_data.dart';

class ComparativeBarChart extends StatefulWidget {
  final List<int> quarter1Data;
  final List<int> quarter2Data;
  final List<int> quarter3Data;
  final List<int> quarter4Data;
  final Function(List<int>)? updateQuarter1Data;
  final Function(List<int>)? updateQuarter2Data;
  final Function(List<int>)? updateQuarter3Data;
  final Function(List<int>)? updateQuarter4Data;

  ComparativeBarChart({
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
  _ComparativeBarChartState createState() => _ComparativeBarChartState();
}

class _ComparativeBarChartState extends State<ComparativeBarChart> {
  List<int> get quarter1Data => widget.quarter1Data;
  List<int> get quarter2Data => widget.quarter2Data;
  List<int> get quarter3Data => widget.quarter3Data;
  List<int> get quarter4Data => widget.quarter4Data;

  late List<Domains> data;
  late TooltipBehavior _tooltip;

  List<int> maxScore = TableData.calculateMaxDomainScores();

  @override
  void initState() {
    data = [
      Domains(
          'Evaluate',
          calculatePercentage(quarter1Data[0], maxScore[0]),
          calculatePercentage(quarter2Data[0], maxScore[0]),
          calculatePercentage(quarter3Data[0], maxScore[0]),
          calculatePercentage(quarter4Data[0], maxScore[0])),
      Domains(
          'Align',
          calculatePercentage(quarter1Data[1], maxScore[1]),
          calculatePercentage(quarter2Data[1], maxScore[1]),
          calculatePercentage(quarter3Data[1], maxScore[1]),
          calculatePercentage(quarter4Data[1], maxScore[1])),
      Domains(
          'Build',
          calculatePercentage(quarter1Data[2], maxScore[2]),
          calculatePercentage(quarter2Data[2], maxScore[2]),
          calculatePercentage(quarter3Data[2], maxScore[2]),
          calculatePercentage(quarter4Data[2], maxScore[2])),
      Domains(
          'Deliver',
          calculatePercentage(quarter1Data[3], maxScore[3]),
          calculatePercentage(quarter2Data[3], maxScore[3]),
          calculatePercentage(quarter3Data[3], maxScore[3]),
          calculatePercentage(quarter4Data[3], maxScore[3])),
      Domains(
          'Monitor',
          calculatePercentage(quarter1Data[4], maxScore[4]),
          calculatePercentage(quarter2Data[4], maxScore[4]),
          calculatePercentage(quarter3Data[4], maxScore[4]),
          calculatePercentage(quarter4Data[4], maxScore[4])),
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

  Widget customLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        legendItem('Q1', Colors.yellow as Color),
        legendItem('Q2', Colors.deepOrange as Color),
        legendItem('Q3', Colors.lightBlue as Color),
        legendItem('Q4', Colors.grey as Color),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                child: Column(children: [customLegend(), buildGraph()]))));
  }

  Widget buildGraph() => Expanded(
          child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(maximum: 100),
              tooltipBehavior: _tooltip,
              series: <ChartSeries<Domains, String>>[
            ColumnSeries<Domains, String>(
                dataSource: data,
                xValueMapper: (Domains data, _) => data.domain,
                yValueMapper: (Domains data, _) => data.q1Score,
                color: Colors.yellow,
                name: 'Q1'),
            ColumnSeries<Domains, String>(
                dataSource: data,
                xValueMapper: (Domains data, _) => data.domain,
                yValueMapper: (Domains data, _) => data.q2Score,
                color: Colors.deepOrange,
                name: 'Q2'),
            ColumnSeries<Domains, String>(
                dataSource: data,
                xValueMapper: (Domains data, _) => data.domain,
                yValueMapper: (Domains data, _) => data.q3Score,
                color: Colors.lightBlue,
                name: 'Q3'),
            ColumnSeries<Domains, String>(
                dataSource: data,
                xValueMapper: (Domains data, _) => data.domain,
                yValueMapper: (Domains data, _) => data.q4Score,
                color: Colors.grey,
                name: 'Q4')
          ]));
}

int calculatePercentage(int score, int maxScore) {
  return ((score / maxScore) * 100).round();
}

class Domains {
  final String domain;
  final int q1Score;
  final int q2Score;
  final int q3Score;
  final int q4Score;

  Domains(this.domain, this.q1Score, this.q2Score, this.q3Score, this.q4Score);
}
