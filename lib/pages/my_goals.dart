import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalTrackerPage extends StatefulWidget {
  @override
  _GoalTrackerPageState createState() => _GoalTrackerPageState();
}

class _GoalTrackerPageState extends State<GoalTrackerPage> {
  late TextEditingController _goalController;
  late SharedPreferences _preferences;
  List<GoalItem> _goals = [];

  @override
  void initState() {
    super.initState();
    _goalController =
        TextEditingController(); // Initialize _goalController here
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    List<String>? savedGoalsJson = _preferences.getStringList('goals');

    if (savedGoalsJson != null) {
      List<dynamic> savedGoals =
          savedGoalsJson.map((json) => jsonDecode(json)).toList();

      _goals = savedGoals
          .map((goalMap) =>
              GoalItem(goalMap['goal'], goalMap['completed'] ?? false))
          .toList();
    } else {
      _goals = [];
    }

    _goalController = TextEditingController();

    setState(() {
      // No changes in the setState block
    });
  }

  @override
  void dispose() {
    _goalController.dispose();
    super.dispose();
  }

  Future<void> _saveGoal(String goal) async {
    setState(() {
      _goals.add(GoalItem(goal, false));
    });

    _goalController.clear();

    await _updateSharedPreferences();
  }

  Future<void> _updateSharedPreferences() async {
    List<Map<String, dynamic>> savedGoals = _goals
        .map((goalItem) => {
              'goal': goalItem.goal,
              'completed': goalItem.completed,
            })
        .toList();
    await _preferences.setStringList(
        'goals', savedGoals.map((goal) => jsonEncode(goal)).toList());
  }

  void _toggleGoalCompletion(int index) {
    setState(() {
      _goals[index].completed = !_goals[index].completed;
    });

    _updateSharedPreferences();
  }

  void _deleteGoal(int index) {
    setState(() {
      _goals.removeAt(index);
    });

    _updateSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goal Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _goalController,
              decoration: InputDecoration(
                hintText: 'Enter your goal',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_goalController.text.isNotEmpty) {
                  _saveGoal(_goalController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Goal saved!')),
                  );
                }
              },
              child: Text('Save Goal'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _goals.length,
                itemBuilder: (context, index) {
                  final goalItem = _goals[index];

                  return Dismissible(
                    key: Key(goalItem.goal),
                    onDismissed: (_) => _deleteGoal(index),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 16.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: CheckboxListTile(
                      activeColor: Colors.green,
                      title: Text(
                        goalItem.goal,
                        style: TextStyle(
                          decoration: goalItem.completed
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      value: goalItem.completed,
                      onChanged: (_) => _toggleGoalCompletion(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoalItem {
  final String goal;
  bool completed;

  GoalItem(this.goal, this.completed);
}
