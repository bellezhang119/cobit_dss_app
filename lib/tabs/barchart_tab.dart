import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChartSample extends StatefulWidget {
  final List<double> quarter1Data;
  final List<double> quarter2Data;
  final List<double> quarter3Data;
  final List<double> quarter4Data;

  BarChartSample({
    Key? key,
    required this.quarter1Data,
    required this.quarter2Data,
    required this.quarter3Data,
    required this.quarter4Data,
  }) : super(key: key);

  @override
  _BarChartSampleState createState() => _BarChartSampleState();
}

class _BarChartSampleState extends State<BarChartSample> {
  List<double> get quarter1Data => widget.quarter1Data;
  List<double> get quarter2Data => widget.quarter2Data;
  List<double> get quarter3Data => widget.quarter3Data;
  List<double> get quarter4Data => widget.quarter4Data;

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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: barChart(),
        ));
  }
}

class Domains {
  final String domain;
  final double score;

  Domains(this.domain, this.score);
}
