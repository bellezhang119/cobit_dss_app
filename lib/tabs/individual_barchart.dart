import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:charts_common/src/common/color.dart' as charts_color;
import '../datas/table_data.dart';

class IndividualBarChart extends StatefulWidget {
  final String quarter;
  final List<int> quarterData;
  final TabController tabController;

  IndividualBarChart(
      {Key? key,
      required this.quarter,
      required this.quarterData,
      required this.tabController})
      : super(key: key);

  @override
  _IndividualBarChartState createState() => _IndividualBarChartState();
}

class _IndividualBarChartState extends State<IndividualBarChart> {
  List<int> get quarterData => widget.quarterData;
  List<int> get quarter => widget.quarterData;
  TabController get tabController => widget.tabController;

  late String quarterName;
  late List<Domain> data;
  late TooltipBehavior _tooltip;

  List<int> maxScore = TableData.calculateMaxDomainScores();

  @override
  void initState() {
    quarterName = widget.quarter;
    data = [
      Domain("Evaluate", calculatePercentage(quarterData[0], maxScore[0])),
      Domain("Align", calculatePercentage(quarterData[1], maxScore[1])),
      Domain("Build", calculatePercentage(quarterData[2], maxScore[2])),
      Domain("Deliver", calculatePercentage(quarterData[3], maxScore[3])),
      Domain("Monitor", calculatePercentage(quarterData[4], maxScore[4]))
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
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
                primaryYAxis: NumericAxis(maximum: 100),
                tooltipBehavior: _tooltip,
                series: <ChartSeries<Domain, String>>[
                  ColumnSeries<Domain, String>(
                    dataSource: data,
                    xValueMapper: (Domain data, _) => data.domain,
                    yValueMapper: (Domain data, _) => data.score,
                  )
                ]),
          ),
          ElevatedButton(
              onPressed: () {
                tabController.animateTo(1);
                Navigator.of(context).pop();
              },
              child: Text('Navigate to Comparative chart'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ))
        ]))));
  }

  int calculatePercentage(int score, int maxScore) {
    return ((score / maxScore) * 100).round();
  }
}

class Domain {
  final String domain;
  final int score;

  Domain(this.domain, this.score);
}
