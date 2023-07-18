import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../tabs/barchart_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<double> quarter1Data = [50, 30, 40, 60, 20];
  List<double> quarter2Data = [40, 20, 50, 70, 30];
  List<double> quarter3Data = [60, 40, 20, 50, 10];
  List<double> quarter4Data = [70, 50, 30, 20, 40];

  void updateQuarter1Data(List<double> newData) {
    setState(() {
      quarter1Data = newData;
    });
  }

  void updateQuarter2Data(List<double> newData) {
    setState(() {
      quarter2Data = newData;
    });
  }

  void updateQuarter3Data(List<double> newData) {
    setState(() {
      quarter3Data = newData;
    });
  }

  void updateQuarter4Data(List<double> newData) {
    setState(() {
      quarter4Data = newData;
    });
  }

  late TabController _mainTabController;
  late TabController _graphTabController;

  @override
  void initState() {
    _mainTabController = TabController(length: 3, vsync: this);
    _graphTabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    _graphTabController.dispose();
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
          const Center(child: Text('Table Chart')),
          const Center(child: Text('Save')),
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
            Tab(text: 'Bar Chart'),
            Tab(text: 'RAG Chart'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _graphTabController,
            children: [
              BarChartSample(
                quarter1Data: quarter1Data,
                quarter2Data: quarter2Data,
                quarter3Data: quarter3Data,
                quarter4Data: quarter4Data,
              ),
              Center(child: Text('RAG Chart Content')),
            ],
          ),
        ),
      ],
    );
  }
}
