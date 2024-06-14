import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_calling_task/zim_video_call.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController callidController = TextEditingController();
  final TextEditingController useridController = TextEditingController();
  List<Map<String, String>> savedData = [];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  // Save data to SharedPreferences
  void _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> newEntry = {
      'callid': callidController.text,
      'userid': useridController.text,
    };
    setState(() {
      savedData.add(newEntry);
    });
    await prefs.setString('savedData', jsonEncode(savedData));
    callidController.clear();
    useridController.clear();
  }

  // Load saved data from SharedPreferences
  void _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('savedData');
    if (data != null) {
      setState(() {
        savedData = List<Map<String, String>>.from(jsonDecode(data));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: callidController,
              decoration: InputDecoration(
                labelText: 'Call ID',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: useridController,
              decoration: InputDecoration(
                labelText: 'User ID',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (callidController.text.isNotEmpty && useridController.text.isNotEmpty) {
                _saveData();
              }
            },
            child: Text('Save'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: savedData.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                        'Call ID: ${savedData[index]['callid']}, User ID: ${savedData[index]['userid']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.videocam),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ZimVideocall(
                              callid: savedData[index]['callid']!,
                              userid: savedData[index]['userid']!,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
