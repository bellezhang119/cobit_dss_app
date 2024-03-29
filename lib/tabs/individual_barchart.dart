import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../data/table_data.dart';

class IndividualBarChart extends StatefulWidget {
  final String quarter;
  final List<int> quarterData;
  final TabController tabController;
  final Color? color;

  IndividualBarChart(
      {Key? key,
      required this.quarter,
      required this.quarterData,
      required this.tabController,
      required this.color})
      : super(key: key);

  @override
  _IndividualBarChartState createState() => _IndividualBarChartState();
}

class _IndividualBarChartState extends State<IndividualBarChart> {
  // Get widget data
  List<int> get quarterData => widget.quarterData;
  List<int> get quarter => widget.quarterData;
  TabController get tabController => widget.tabController;
  Color? get color => widget.color;

  late String quarterName;
  late List<Domain> data;
  late TooltipBehavior _tooltip;

  List<int> maxScore = TableData.calculateMaxDomainScores();
  final _screenshotController = ScreenshotController();

  // Initialise bar chart data
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
              child: Screenshot(
            child: buildGraph(),
            controller: _screenshotController,
          )),
          ElevatedButton(
              onPressed: () {
                tabController.animateTo(1);
                Navigator.of(context).pop();
              },
              child: Text('Navigate to Comparative chart'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              )),
          ElevatedButton(
              onPressed: takeScreenshot, child: Icon(Icons.ios_share_sharp))
        ]))));
  }

  // Calculate score percentage
  int calculatePercentage(int score, int maxScore) {
    return ((score / maxScore) * 100).round();
  }

  // Build bar chart widget
  Widget buildGraph() {
    return SfCartesianChart(
        backgroundColor: Colors.white,
        title: ChartTitle(text: quarterName),
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(maximum: 100),
        tooltipBehavior: _tooltip,
        series: <ChartSeries<Domain, String>>[
          ColumnSeries<Domain, String>(
            dataLabelSettings: DataLabelSettings(isVisible: true),
            dataSource: data,
            xValueMapper: (Domain data, _) => data.domain,
            yValueMapper: (Domain data, _) => data.score,
            color: color,
          )
        ]);
  }

  // Take screenshot of widget and save to local gallery
  void takeScreenshot() async {
    await _screenshotController.capture().then((capturedImage) async {
      ImageGallerySaver.saveImage(capturedImage as Uint8List);
    });
  }
}

class Domain {
  final String domain;
  final int score;

  Domain(this.domain, this.score);
}
