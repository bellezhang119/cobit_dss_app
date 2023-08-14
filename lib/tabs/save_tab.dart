import 'package:flutter/material.dart';

class SaveTab extends StatefulWidget {
  final List<int> quarter1Data;

  SaveTab({Key? key, required this.quarter1Data}) : super(key: key);

  @override
  _SaveTabState createState() => _SaveTabState();
}

class _SaveTabState extends State<SaveTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter save name',
          ),
        ),
        ElevatedButton(onPressed: () {}, child: Text('Save Q1 Data'))
      ],
    );
  }
}
