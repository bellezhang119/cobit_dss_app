import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SaveTab extends StatefulWidget {
  final Map<String, int> audits;

  SaveTab({Key? key, required this.audits}) : super(key: key);

  @override
  _SaveTabState createState() => _SaveTabState();
}

class _SaveTabState extends State<SaveTab> {

  String saveName = ''; //for text in the input box
  bool isTextShown = false; //used to feedback whether the text is saved

/*
 When the save button is pressed:
 - Save code to the database.
 - Print data to the console.
 TODO: Add pop-up prompts for successful and unsuccessful saves.
 Note: Currently, there's no way to determine save success.
*/

  void _handleButtonPress() {
    setState(() {
      isTextShown = true;
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isTextShown = false;
      });
    });

    //TODO update data to the database
    print("save data");
  }

  Widget _buildTextField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          saveName = value;
        });
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter save name',
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
        onPressed: _handleButtonPress, child: Text('save data'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextField(),
        // On save: show 'success' if successful, otherwise show 'failure'.
        if (isTextShown)
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              'Saved successfully',
              style: TextStyle(
                color: Colors.green,
                fontSize: 12.0,
              ),
            ),
          ),
        Spacer(), // This will push the button to the bottom of the screen.
        _buildSaveButton(),

      ],
    );
  }
}
