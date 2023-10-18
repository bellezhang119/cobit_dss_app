import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../data/table_data.dart';

class TableTab extends StatefulWidget {
  Map<String, int> audits;

  final Function(Map<String, int> updatedAudit) onAuditUpdated;

  TableTab({required this.audits, required this.onAuditUpdated});

  @override
  _TableTabState createState() => _TableTabState();
}

class _TableTabState extends State<TableTab> {
  Map<String, int> get audits => widget.audits;
  Map<String, int> get weights => TableData.weights;

  void _handleAuditValueChange(int index, int newValue) {
    setState(() {
      // Update the audit value at the specified index
      List<String> codes = audits.keys.toList();
      String code = codes[index];
      widget.audits[code] = newValue;
    });

    // Recalculate the scores and update the parent widget with the updated audits
    List<int> updatedAuditValues = widget.audits.values.toList();
    List<int> totalDomainScores = TableData.calculateScores(updatedAuditValues);

    // Update the parent widget with the updated audit values and total domain scores
    widget.onAuditUpdated(Map.from(widget.audits));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    columns: _buildColumns(),
                    rows: _buildRows(),
                    border: TableBorder.all()))));
  }

  List<DataColumn> _buildColumns() {
    return [
      DataColumn(
          label: Text('DOMAIN', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('CODE', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label:
              Text('AUDIT(0/1)', style: TextStyle(fontWeight: FontWeight.bold)),
          numeric: true),
      DataColumn(
          label: Text('SCORE', style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
    ];
  }

  List<DataRow> _buildRows() {
    List<String> domains = TableData.domains;
    List<int> weightsValue = weights.values.toList();
    List<String> codes = audits.keys.toList();
    List<String> objectives = TableData.objectives;
    List<int> auditValues = audits.values.toList();

    List<int> totalDomainScores =
        TableData.calculateScores(audits.values.toList());

    List<DataRow> rows = [];

    print(totalDomainScores.length);
    for (int i = 0; i < 40; i++) {
      // Loop from 0 to 39
      if (i >= codes.length || i >= objectives.length) {
        break; // Break the loop if either codes or objectives list is exhausted
      }

      rows.add(
        DataRow(cells: <DataCell>[
          DataCell(Text(domains[i])),
          DataCell(Text(codes[i])),
          DataCell(
            DropdownButtonFormField<int>(
              value: auditValues[i],
              items: const [
                DropdownMenuItem<int>(
                  value: 0,
                  child: Text('0'),
                ),
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text('1'),
                ),
              ],
              onChanged: (newValue) {
                _handleAuditValueChange(i, newValue ?? 0);
              },
            ),
          ),
          DataCell(Text((weightsValue[i] * weightsValue[i] * auditValues[i] +
                  weightsValue[i])
              .toString())),
          DataCell(Text(totalDomainScores[i].toString())),
        ]),
      );
    }
    return rows;
  }
}
