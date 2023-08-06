// ragchart_tab.dart

import 'package:flutter/material.dart';
import 'dart:math';
import '../datas/table_data.dart';

class RAGChartTab extends StatelessWidget {
  final List<int> domainScores;
  final List<String> domainNames = [
    'Evaluate, Direct and Monitor',
    'Align, Plan and Organise',
    'Build, Acquire and Implement',
    'Deliver, Service and Support',
    'Monitor, Evaluate and Assess',
  ];

  final List<int> domainWeights = [150, 266, 144, 92, 40];

  RAGChartTab({required this.domainScores});

  @override
  Widget build(BuildContext context) {
    return _buildTable();
  }

  Widget _buildTable() {
    int rowCount = min(domainNames.length, domainScores.length);

    List<TableRow> rows = [];
    rows.add(_buildTableRow(['Domain', 'Score Quarter 4', 'Red (0 - 50%), Amber (50-80%), Green (80-100%)'])); // Header row
    for (int i = 0; i < rowCount; i++) {
      int totalWeight = domainWeights[i];
      double totalWeightValue = totalWeight.toDouble();
      double percentage = totalWeightValue != 0 ? (domainScores[i] / totalWeightValue) * 100 : 0;
      Color? backgroundColor = _getScoreBoxColor(percentage);
      rows.add(_buildTableRow([
        domainNames[i],
        '${domainScores[i]} / $totalWeight (${percentage.toStringAsFixed(0)}%)',
        backgroundColor,
      ]));
    }

    return Table(
      border: TableBorder.all(),
      children: rows,
    );
  }

  TableRow _buildTableRow(List<dynamic> rowData) {
    return TableRow(
      children: rowData.map((cellData) => _buildTableCell(cellData)).toList(),
    );
  }

  Widget _buildTableCell(dynamic data) {
    return TableCell(
      child: Container(
        padding: EdgeInsets.all(8.0),
        color: data is Color ? data : null, // Set the background color for the score box cell
        child: data is Color ? SizedBox.shrink() : Text( // Use SizedBox.shrink() for empty cell
          data.toString(),
          style: TextStyle(
            color: data is Color ? _getTextColorForScoreBox(data) : null, // Set the text color for the score box cell
          ),
        ),
      ),
    );
  }

  Color _getScoreBoxColor(double percentage) {
    if (percentage >= 80) {
      return Colors.green;
    } else if (percentage >= 50) {
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
