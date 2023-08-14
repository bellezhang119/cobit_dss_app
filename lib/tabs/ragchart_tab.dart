import 'package:flutter/material.dart';
import 'dart:math';
import '../datas/table_data.dart';


class RAGChartTab extends StatelessWidget {
  final List<int> domainScores;

  RAGChartTab({required this.domainScores});

  @override
  Widget build(BuildContext context) {
    return _buildTable();
  }

  Widget _buildTable() {
    List<String> domains = TableData.domains;

    // Ensure both lists have the same length
    int rowCount = min(domains.length, domainScores.length);

    // Filter out the domains with empty names
    List<String> nonEmptyDomains = domains.where((domain) => domain.isNotEmpty).toList();

    return Table(
      border: TableBorder.all(),
      children: [
        _buildTableRow(['Domain', 'Score']), // Header row
        for (int i = 0; i < rowCount; i++)
          _buildTableRow([nonEmptyDomains[i], domainScores[i].toString()]), // Domain row
      ],
    );
  }

  TableRow _buildTableRow(List<String> rowData) {
    return TableRow(
      children: rowData.map((cellData) => _buildTableCell(cellData)).toList(),
    );
  }

  Widget _buildTableCell(String data) {
    return TableCell(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(data),
      ),
    );
  }
}
