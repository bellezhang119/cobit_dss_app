import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 3,
        child: Scaffold(
            body: Column(children: [
          TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.bar_chart, color: Colors.black),
              ),
              Tab(
                icon: Icon(Icons.table_chart_outlined, color: Colors.black),
              ),
              Tab(
                icon: Icon(
                  Icons.save,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ])));
  }
}
