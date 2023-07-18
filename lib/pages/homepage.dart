import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
        bottom: TabBar(
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
            children: const [
              Center(child: Text('Bar Chart Content')),
              Center(child: Text('RAG Chart Content')),
            ],
          ),
        ),
      ],
    );
  }
}
