import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../tabs/summary_barchart_tab.dart';
import '../tabs/comparative_barchart_tab.dart';
import '../tabs/ragchart_tab.dart';
import '../tabs/table_tab.dart';
import '../datas/table_data.dart';
import '../tabs/load_tab.dart';
import '../tabs/save_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Map<String, int> audits = {
    'EDM01': 1,
    'EDM02': 1,
    'EDM03': 1,
    'EDM04': 1,
    'EDM05': 1,
    'APO01': 1,
    'APO02': 1,
    'APO03': 1,
    'APO04': 1,
    'APO05': 1,
    'APO06': 1,
    'APO07': 1,
    'APO08': 1,
    'APO09': 1,
    'APO10': 1,
    'APO11': 1,
    'APO12': 1,
    'APO13': 1,
    'APO14': 1,
    'BAI01': 1,
    'BAI02': 1,
    'BAI03': 1,
    'BAI04': 1,
    'BAI05': 1,
    'BAI06': 1,
    'BAI07': 1,
    'BAI08': 1,
    'BAI09': 1,
    'BAI10': 1,
    'BAI11': 1,
    'DSS01': 1,
    'DSS02': 1,
    'DSS03': 1,
    'DSS04': 1,
    'DSS05': 1,
    'DSS06': 1,
    'MEA01': 1,
    'MEA02': 1,
    'MEA03': 1,
    'MEA04': 1,
  };

  List<int> quarter1Data = [70, 50, 30, 20, 40];
  List<int> quarter2Data = [40, 20, 50, 70, 30];
  List<int> quarter3Data = [60, 40, 20, 50, 10];
  List<int> quarter4Data = [70, 50, 30, 20, 40];

  void updateQuarter1Data(List<int> newData) {
    setState(() {
      quarter1Data = newData;
    });
  }

  void updateQuarter2Data(List<int> newData) {
    setState(() {
      quarter2Data = newData;
    });
  }

  void updateQuarter3Data(List<int> newData) {
    setState(() {
      quarter3Data = newData;
    });
  }

  void updateQuarter4Data(List<int> newData) {
    setState(() {
      quarter4Data = newData;
    });
  }

  void onAuditUpdated(Map<String, int> updatedAudit) {
    setState(() {
      audits = updatedAudit;
    });

    List<int> domainScores =
        TableData.calculateDomainScores(audits.values.toList());
    updateQuarter4Data(domainScores);
  }

  late TabController _mainTabController;
  late TabController _graphTabController;
  late TabController _saveLoadTabController;

  @override
  void initState() {
    _mainTabController = TabController(length: 3, vsync: this);
    _graphTabController = TabController(length: 3, vsync: this);
    _saveLoadTabController = TabController(length: 2, vsync: this);
    onAuditUpdated(audits);
    super.initState();
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    _graphTabController.dispose();
    _saveLoadTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: false,
        centerTitle: false,
        automaticallyImplyLeading: false,
        titleSpacing: -30,
        bottom: TabBar(
          padding: EdgeInsets.zero,
          controller: _mainTabController,
          tabs: const [
            Tab(icon: Icon(Icons.bar_chart, color: Colors.black)),
            Tab(icon: Icon(Icons.table_chart_outlined, color: Colors.black)),
            Tab(icon: Icon(Icons.save, color: Colors.black)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _mainTabController,
        children: [
          _buildGraphTab(),
          TableTab(audits: audits, onAuditUpdated: onAuditUpdated),
          _buildSaveLoadTab(),
        ],
      ),
    );
  }

  Widget _buildGraphTab() {
    return Column(
      children: [
        TabBar(
          padding: EdgeInsets.zero,
          controller: _graphTabController,
          labelColor: Colors.black,
          tabs: const [
            Tab(text: 'Summary'),
            Tab(text: 'Compare'),
            Tab(text: 'RAG Chart'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _graphTabController,
            children: [
              SummaryBarChart(
                  quarter1Data: quarter1Data,
                  quarter2Data: quarter2Data,
                  quarter3Data: quarter3Data,
                  quarter4Data: quarter4Data,
                  updateQuarter1Data: updateQuarter1Data,
                  updateQuarter2Data: updateQuarter2Data,
                  updateQuarter3Data: updateQuarter3Data,
                  updateQuarter4Data: updateQuarter4Data),
              ComparativeBarChart(
                  quarter1Data: quarter1Data,
                  quarter2Data: quarter2Data,
                  quarter3Data: quarter3Data,
                  quarter4Data: quarter4Data,
                  updateQuarter1Data: updateQuarter1Data,
                  updateQuarter2Data: updateQuarter2Data,
                  updateQuarter3Data: updateQuarter3Data,
                  updateQuarter4Data: updateQuarter4Data),
              RAGChartTab(
                  domainScores: quarter4Data,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSaveLoadTab() {
    return Column(
      children: [
        TabBar(
            controller: _saveLoadTabController,
            labelColor: Colors.black,
            tabs: const [Tab(text: 'Save'), Tab(text: 'Load')]),
        Expanded(
          child: TabBarView(controller: _saveLoadTabController, children: [
            SaveTab(quarter1Data: quarter1Data),
            LoadTab(
              updateQuarter1Data: updateQuarter1Data,
              updateQuarter2Data: updateQuarter2Data,
              updateQuarter3Data: updateQuarter3Data,
              updateQuarter4Data: updateQuarter4Data,
              onAuditUpdated: onAuditUpdated,
            )
          ]),
        )
      ],
    );
  }
}
