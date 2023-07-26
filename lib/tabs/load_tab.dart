import 'package:flutter/material.dart';

class LoadTab extends StatefulWidget {
  final Function(List<int>)? updateQuarter1Data;
  final Function(List<int>)? updateQuarter2Data;
  final Function(List<int>)? updateQuarter3Data;
  final Function(List<int>)? updateQuarter4Data;

  LoadTab({
    Key? key,
    required this.updateQuarter1Data,
    required this.updateQuarter2Data,
    required this.updateQuarter3Data,
    required this.updateQuarter4Data,
  }) : super(key: key);

  @override
  _LoadTabState createState() => _LoadTabState();
}

class _LoadTabState extends State<LoadTab> {
  String q1Value = '';
  String q2Value = '';
  String q3Value = '';
  String q4Value = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDropDown('Q1:', q1Value),
            buildDropDown('Q2:', q2Value),
            buildDropDown('Q3:', q3Value),
            buildDropDown('Q4:', q4Value),
          ],
        ),
      ),
    );
  }

  Widget buildDropDown(String label, String value) {
    return Row(
      children: [
        Text(label),
        SizedBox(width: 10),
        Expanded(
          child: DropdownButton<String>(
            value: value,
            onChanged: (newValue) {
              setState(() {
                switch (label) {
                  case 'Q1:':
                    q1Value = newValue!;
                    break;
                  case 'Q2:':
                    q2Value = newValue!;
                    break;
                  case 'Q3:':
                    q3Value = newValue!;
                    break;
                  case 'Q4:':
                    q4Value = newValue!;
                    break;
                }
              });
            },
            items: <String>[
              // Add your dropdown menu items here
              // For example: 'Option 1', 'Option 2', 'Option 3', etc.
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
