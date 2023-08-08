import 'package:cobit_dss_app/tabs/individual_barchart.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../datas/table_data.dart';

class SummaryBarChart extends StatefulWidget {
  final List<int> quarter1Data;
  final List<int> quarter2Data;
  final List<int> quarter3Data;
  final List<int> quarter4Data;
  final Function(List<int>)? updateQuarter1Data;
  final Function(List<int>)? updateQuarter2Data;
  final Function(List<int>)? updateQuarter3Data;
  final Function(List<int>)? updateQuarter4Data;
  final TabController tabController;

  SummaryBarChart(
      {Key? key,
      required this.quarter1Data,
      required this.quarter2Data,
      required this.quarter3Data,
      required this.quarter4Data,
      required this.updateQuarter1Data,
      required this.updateQuarter2Data,
      required this.updateQuarter3Data,
      required this.updateQuarter4Data,
      required this.tabController})
      : super(key: key);

  @override
  _SummaryBarChartState createState() => _SummaryBarChartState();
}

class _SummaryBarChartState extends State<SummaryBarChart> {
  List<int> get quarter1Data => widget.quarter1Data;
  List<int> get quarter2Data => widget.quarter2Data;
  List<int> get quarter3Data => widget.quarter3Data;
  List<int> get quarter4Data => widget.quarter4Data;
  TabController get tabController => widget.tabController;

  late List<Quarter> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      Quarter("Q1", calculatePercentage(quarter1Data)),
      Quarter("Q2", calculatePercentage(quarter2Data)),
      Quarter("Q3", calculatePercentage(quarter3Data)),
      Quarter("Q4", calculatePercentage(quarter4Data)),
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
              primaryYAxis: NumericAxis(maximum: 100),
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
            )
          ]))
    ]))));
  }

  void navigateToIndividualBarChart(String quarter, List<int> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IndividualBarChart(
          quarter: quarter,
          quarterData: data,
          tabController: tabController,
        ),
      ),
    );
  }
}

int calculatePercentage(List<int> numbers) {
  int sum = numbers.reduce((a, b) => a + b);
  int maxScore = TableData.calculateMaxDomainScores().reduce((a, b) => a + b);

  // Calculate the average and round it to the nearest integer
  int percentage = ((sum / maxScore) * 100).round();
  return percentage;
}

class Quarter {
  final String quarter;
  final int score;

  Quarter(this.quarter, this.score);
}