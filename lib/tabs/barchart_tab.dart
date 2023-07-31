import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_common/src/common/color.dart' as charts_color;

class BarChartSample extends StatefulWidget {
  final List<int> quarter1Data;
  final List<int> quarter2Data;
  final List<int> quarter3Data;
  final List<int> quarter4Data;
  final Function(List<int>)? updateQuarter1Data;
  final Function(List<int>)? updateQuarter2Data;
  final Function(List<int>)? updateQuarter3Data;
  final Function(List<int>)? updateQuarter4Data;

  BarChartSample({
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
  _BarChartSampleState createState() => _BarChartSampleState();
}

class _BarChartSampleState extends State<BarChartSample> {
  List<int> get quarter1Data => widget.quarter1Data;
  List<int> get quarter2Data => widget.quarter2Data;
  List<int> get quarter3Data => widget.quarter3Data;
  List<int> get quarter4Data => widget.quarter4Data;

  late List<charts.Series> seriesList;

  List<charts.Series<Domains, String>> _createData() {
    final q1 = [
      Domains('Evaluate, Direct and Monitor', quarter1Data[0]),
      Domains('Align, Plan and Organise', quarter1Data[1]),
      Domains('Build, Acquire and Implement', quarter1Data[2]),
      Domains('Deliver, Service and Support', quarter1Data[3]),
      Domains('Monitor, Evaluate and Assess', quarter1Data[4]),
    ];
    final q2 = [
      Domains('Evaluate, Direct and Monitor', quarter2Data[0]),
      Domains('Align, Plan and Organise', quarter2Data[1]),
      Domains('Build, Acquire and Implement', quarter2Data[2]),
      Domains('Deliver, Service and Support', quarter2Data[3]),
      Domains('Monitor, Evaluate and Assess', quarter2Data[4]),
    ];
    final q3 = [
      Domains('Evaluate, Direct and Monitor', quarter3Data[0]),
      Domains('Align, Plan and Organise', quarter3Data[1]),
      Domains('Build, Acquire and Implement', quarter3Data[2]),
      Domains('Deliver, Service and Support', quarter3Data[3]),
      Domains('Monitor, Evaluate and Assess', quarter3Data[4]),
    ];
    final q4 = [
      Domains('Evaluate, Direct and Monitor', quarter4Data[0]),
      Domains('Align, Plan and Organise', quarter4Data[1]),
      Domains('Build, Acquire and Implement', quarter4Data[2]),
      Domains('Deliver, Service and Support', quarter4Data[3]),
      Domains('Monitor, Evaluate and Assess', quarter4Data[4]),
    ];

    return [
      charts.Series<Domains, String>(
          id: 'Domains',
          domainFn: (Domains domains, _) => domains.domain,
          measureFn: (Domains domains, _) => domains.score,
          data: q1,
          fillColorFn: (Domains domains, _) {
            return charts.MaterialPalette.yellow.shadeDefault;
          }),
      charts.Series<Domains, String>(
          id: 'Domains',
          domainFn: (Domains domains, _) => domains.domain,
          measureFn: (Domains domains, _) => domains.score,
          data: q2,
          fillColorFn: (Domains domains, _) {
            return charts.MaterialPalette.deepOrange.shadeDefault;
          }),
      charts.Series<Domains, String>(
          id: 'Domains',
          domainFn: (Domains domains, _) => domains.domain,
          measureFn: (Domains domains, _) => domains.score,
          data: q3,
          fillColorFn: (Domains domains, _) {
            return charts.MaterialPalette.blue.shadeDefault;
          }),
      charts.Series<Domains, String>(
          id: 'Domains',
          domainFn: (Domains domains, _) => domains.domain,
          measureFn: (Domains domains, _) => domains.score,
          data: q4,
          fillColorFn: (Domains domains, _) {
            return charts.MaterialPalette.gray.shadeDefault;
          })
    ];
  }

  barChart() {
    return charts.BarChart(
      _createData(),
      vertical: true,
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(fontSize: 12),
          lineStyle: charts.LineStyleSpec(
            color: charts.ColorUtil.fromDartColor(Colors.transparent),
          ),
        ),
        showAxisLine: false,
        tickProviderSpec: charts.BasicNumericTickProviderSpec(
          desiredTickCount: 10,
        ),
        // Set the maximum value of the y-axis to 270
        viewport: charts.NumericExtents(0, 270),
      ),
      behaviors: [],
      domainAxis: charts.OrdinalAxisSpec(
          renderSpec: charts.SmallTickRendererSpec(
            labelStyle: charts.TextStyleSpec(
              fontSize: 8, 
              
            ),
            labelRotation: 45
          ),
        ),
    );
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
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            customLegend(),
            Expanded(child: barChart()),
          ],
        ),
      ),
    );
  }
}

class Domains {
  final String domain;
  final int score;

  Domains(this.domain, this.score);
}
