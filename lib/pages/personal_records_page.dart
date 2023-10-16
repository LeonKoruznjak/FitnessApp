import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../data/record_manager.dart';

class PersonalRecordsPage extends StatefulWidget {
  @override
  _PersonalRecordsPageState createState() => _PersonalRecordsPageState();
}

class _PersonalRecordsPageState extends State<PersonalRecordsPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _benchController = TextEditingController();
  TextEditingController _squatController = TextEditingController();
  TextEditingController _deadliftController = TextEditingController();
  List<Map<String, dynamic>> _recordsList = [];
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text('Personal Records'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildRecordList(),
    );
  }

  @override
  void dispose() {
    _benchController.dispose();
    _squatController.dispose();
    _deadliftController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newRecord = {
        'date': DateTime.now(),
        'bench':
            _benchController.text.isNotEmpty ? _benchController.text : null,
        'squat':
            _squatController.text.isNotEmpty ? _squatController.text : null,
        'deadlift': _deadliftController.text.isNotEmpty
            ? _deadliftController.text
            : null,
      };

      setState(() {
        _recordsList.add(newRecord);
      });

      _benchController.clear();
      _squatController.clear();
      _deadliftController.clear();

      RecordManager.saveRecord(_recordsList);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  void _loadRecords() async {
    final records = await RecordManager.getRecords();
    setState(() {
      _recordsList = records.map((record) {
        return {
          ...record,
          'date': DateTime.parse(record['date']),
        };
      }).toList();
      _isLoading = false;
    });
  }

  void _deleteRecord(int index) {
    setState(() {
      _recordsList.removeAt(index);
    });

    RecordManager.saveRecord(_recordsList);
  }

  Widget _buildRecordList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _recordsList.length,
              itemBuilder: (context, index) {
                final record = _recordsList[index];
                final date = DateFormat('MMM dd, yyyy').format(record['date']);
                final bench = record['bench'];
                final squat = record['squat'];
                final deadlift = record['deadlift'];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              _deleteRecord(index);
                            },
                            icon: Icons.delete,
                            backgroundColor: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                          )
                        ],
                      ),
                      child: Card(
                        color: Colors.black,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(
                            'Record ${index + 1}',
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date: $date',
                                style: TextStyle(color: Colors.white),
                              ),
                              if (bench != null)
                                Text(
                                  'Bench Press: $bench',
                                  style: TextStyle(color: Colors.white),
                                ),
                              if (squat != null)
                                Text(
                                  'Squat: $squat',
                                  style: TextStyle(color: Colors.white),
                                ),
                              if (deadlift != null)
                                Text(
                                  'Deadlift: $deadlift',
                                  style: TextStyle(color: Colors.white),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _showAddRecordDialog,
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // Set the button background color
              onPrimary: Colors.white, // Set the button text color
            ),
            child: Text('Add a new record!'),
          ),
        ],
      ),
    );
  }

  void _showAddRecordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            'Add a Record!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _benchController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isNotEmpty &&
                          !RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Bench Press:',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _squatController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isNotEmpty &&
                          !RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Squat:',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _deadliftController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isNotEmpty &&
                          !RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Deadlift:',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _submitForm();
                Navigator.of(context).pop();
              },
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.green),
              ),
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}
