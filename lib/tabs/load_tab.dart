import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../datas/table_data.dart';

class LoadTab extends StatefulWidget {
  final Function(List<int>) updateQuarter1Data;
  final Function(List<int>) updateQuarter2Data;
  final Function(List<int>) updateQuarter3Data;
  final Function(List<int>) updateQuarter4Data;
  final Function(Map<String, int> updatedAudit) onAuditUpdated;

  LoadTab(
      {Key? key,
      required this.updateQuarter1Data,
      required this.updateQuarter2Data,
      required this.updateQuarter3Data,
      required this.updateQuarter4Data,
      required this.onAuditUpdated})
      : super(key: key);

  @override
  _LoadTabState createState() => _LoadTabState();
}

class _LoadTabState extends State<LoadTab>
    with AutomaticKeepAliveClientMixin<LoadTab> {
  @override
  bool get wantKeepAlive => true;

  String? q1Value;
  String? q2Value;
  String? q3Value;
  String? q4Value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('audits').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error fetching audit data'),
              );
            }

            final documents = snapshot.data?.docs ?? [];
            final documentIds = documents.map((doc) => doc.id).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDropDown('Q1:', q1Value, documentIds),
                buildDropDown('Q2:', q2Value, documentIds),
                buildDropDown('Q3:', q3Value, documentIds),
                buildDropDown('Q4:', q4Value, documentIds),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildDropDown(
      String label, String? selectedValue, List<String> items) {
    // If the selectedValue is null (not selected yet), set it to the corresponding state variable
    selectedValue ??= _getSelectedValue(label);

    return Row(
      children: [
        Text(label),
        SizedBox(width: 10),
        Expanded(
          child: DropdownButton<String>(
            value: selectedValue,
            onChanged: (newValue) {
              setState(() {
                switch (label) {
                  case 'Q1:':
                    getDocumentById("Q1", newValue as String);
                    q1Value = newValue;
                    break;
                  case 'Q2:':
                    getDocumentById("Q2", newValue as String);
                    q2Value = newValue;
                    break;
                  case 'Q3:':
                    getDocumentById("Q3", newValue as String);
                    q3Value = newValue;
                    break;
                  case 'Q4:':
                    getDocumentById("Q4", newValue as String);
                    q4Value = newValue;
                    break;
                }
              });
            },
            items: items.map<DropdownMenuItem<String>>((String value) {
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

  String? _getSelectedValue(String label) {
    switch (label) {
      case 'Q1:':
        return q1Value;
      case 'Q2:':
        return q2Value;
      case 'Q3:':
        return q3Value;
      case 'Q4:':
        return q4Value;
      default:
        return null;
    }
  }

  void getDocumentById(String quarter, String documentId) async {
    try {
      // Get a reference to the document with the specified ID
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('audits').doc(documentId);

      // Get the document snapshot
      DocumentSnapshot documentSnapshot = await documentReference.get();

      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      Map<String, dynamic> auditsData = data['audits'] as Map<String, dynamic>;

      List<String> sortedKeys = auditsData.keys.toList()
        ..sort((a, b) => int.parse(a).compareTo(int.parse(b)));
      Map<String, int> sortedMap = {};
      sortedKeys.forEach((key) {
        sortedMap[key] = auditsData[key];
      });

      switch (quarter) {
        case "Q1":
          List<int> audit = sortedMap.values.toList();
          List<int> quarterData = TableData.calculateDomainScores(audit);
          widget.updateQuarter1Data(quarterData);
          break;
        case "Q2":
          List<int> audit = sortedMap.values.toList();
          List<int> quarterData = TableData.calculateDomainScores(audit);
          widget.updateQuarter2Data(quarterData);
          break;
        case "Q3":
          List<int> audit = sortedMap.values.toList();
          List<int> quarterData = TableData.calculateDomainScores(audit);
          widget.updateQuarter3Data(quarterData);
          break;
        case "Q4":
          List<int> audit = sortedMap.values.toList();
          Map<String, int> combinedMap =
              combineListsIntoMap(TableData.domainCodes, audit);
          widget.onAuditUpdated(combinedMap);
      }
    } catch (e) {
      print('Error getting document: $e');
    }
  }

  Map<String, int> combineListsIntoMap(List<String> keys, List<int> values) {
    Map<String, int> result = {};

    if (keys.length != values.length) {
      throw ArgumentError('Both lists must have the same length.');
    }

    for (int i = 0; i < keys.length; i++) {
      result[keys[i]] = values[i];
    }

    return result;
  }
}
