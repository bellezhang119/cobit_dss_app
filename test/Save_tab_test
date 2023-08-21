import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SaveTab extends StatefulWidget {
  final Map<String, int> audits;

  SaveTab({Key? key, required this.audits}) : super(key: key);

  @override
  _SaveTabState createState() => _SaveTabState();
}

class _SaveTabState extends State<SaveTab> {
  TextEditingController saveNameController = TextEditingController();

  void saveDataToFirestore() async {
    List<String> auditKey =
        List.generate(40, (index) => (index + 1).toString());
    List<int> auditValues = widget.audits.values.toList();
    Map<String, int> saveAudit = {};
    for (var i = 0; i < widget.audits.keys.length; i++) {
      saveAudit[auditKey[i]] = auditValues[i];
    }
    String saveName = saveNameController.text;

    if (saveName.isNotEmpty) {
      try {
        // Reference to the Firestore collection
        CollectionReference auditsCollection =
            FirebaseFirestore.instance.collection('audits');

        // Save the data with the entered save name as the document ID
        await auditsCollection.doc(saveName).set({
          'audits': saveAudit,
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Data saved successfully')));
      } catch (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error saving data')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter a save name')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: saveNameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter save name',
          ),
        ),
        ElevatedButton(
            onPressed: saveDataToFirestore, child: Text('Save Q4 Data'))
      ],
    );
  }
}
