import 'package:flutter/material.dart';
import 'dart:math';
import '../data/table_data.dart';

class RAGChartTab extends StatefulWidget {
  final List<int> quarter1Data;
  final List<int> quarter2Data;
  final List<int> quarter3Data;
  final List<int> quarter4Data;

  RAGChartTab(
      {Key? key,
      required this.quarter1Data,
      required this.quarter2Data,
      required this.quarter3Data,
      required this.quarter4Data})
      : super(key: key);

  @override
  _RAGChartTab createState() => _RAGChartTab();
}

class _RAGChartTab extends State<RAGChartTab> {
  List<int> get quarter1Data => widget.quarter1Data;
  List<int> get quarter2Data => widget.quarter2Data;
  List<int> get quarter3Data => widget.quarter3Data;
  List<int> get quarter4Data => widget.quarter4Data;
  List<int> maxDomainScores = TableData.calculateMaxDomainScores();

  List<String> domainNames = [
    'Evaluate',
    'Align',
    'Build',
    'Deliver',
    'Monitor',
  ];

  List<TableRow> buildRows() {
    List<TableRow> rows = [];

    // Build the header row
    rows.add(
      TableRow(
        children: [
          Center(child: Text('Domain')),
          Center(child: Text('Quarter')),
          Center(child: Text('Score')),
          Text(''),
        ],
      ),
    );

    // Build the data rows dynamically using a for loop
    for (int i = 0; i < domainNames.length; i++) {
      rows.add(
        TableRow(
          children: [
            Center(child: Text(domainNames[i])),
            TableCell(
              child: Table(
                border: TableBorder.all(),
                children: [
                  TableRow(
                    children: [Center(child: Text('Q1'))],
                  ),
                  TableRow(
                    children: [Center(child: Text('Q2'))],
                  ),
                  TableRow(
                    children: [Center(child: Text('Q3'))],
                  ),
                  TableRow(
                    children: [Center(child: Text('Q4'))],
                  ),
                ],
              ),
            ),
            TableCell(
              child: Table(
                border: TableBorder.all(),
                children: [
                  TableRow(
                    children: [
                      Center(child: Text(widget.quarter1Data[i].toString())),
                    ],
                  ),
                  TableRow(
                    children: [
                      Center(child: Text(widget.quarter2Data[i].toString())),
                    ],
                  ),
                  TableRow(
                    children: [
                      Center(child: Text(widget.quarter3Data[i].toString())),
                    ],
                  ),
                  TableRow(
                    children: [
                      Center(child: Text(widget.quarter4Data[i].toString())),
                    ],
                  ),
                ],
              ),
            ),
            TableCell(
              child: Table(
                border: TableBorder.all(),
                children: [
                  TableRow(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        color: getTableCellColor(
                            widget.quarter1Data[i], maxDomainScores[i]),
                        child: Text(''),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        color: getTableCellColor(
                            widget.quarter2Data[i], maxDomainScores[i]),
                        child: Text(''),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        color: getTableCellColor(
                            widget.quarter3Data[i], maxDomainScores[i]),
                        child: Text(''),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        color: getTableCellColor(
                            widget.quarter4Data[i], maxDomainScores[i]),
                        child: Text(''),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Table(
        border: TableBorder.all(),
        children: buildRows(),
      ),
    );
  }

  Color getTableCellColor(int score, int maxScore) {
    double percentage = (score / maxScore);

    if (percentage >= 0.75) {
      return Colors.green;
    } else if (percentage >= 0.50) {
      return Colors.amber;
    } else {
      return Colors.red;
    }
  }

  Color _getTextColorForScoreBox(Color backgroundColor) {
    // Determine the appropriate text color for the score box based on the background color
    // You can customize this logic as needed
    // For example, use a contrasting color if the background color is dark, and vice versa
    return Colors.white;
  }
}
