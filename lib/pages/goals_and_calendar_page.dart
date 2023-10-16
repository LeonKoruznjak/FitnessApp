import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/goal.dart';
import '../components/heatmap.dart';
import '../data/workout_data.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class GoalsAndCalendar extends StatefulWidget {
  const GoalsAndCalendar({Key? key}) : super(key: key);

  @override
  State<GoalsAndCalendar> createState() => _GoalsAndCalendar();
}

class _GoalsAndCalendar extends State<GoalsAndCalendar> {
  late TextEditingController _goalController;
  late SharedPreferences _preferences;
  List<GoalItem> _goals = [];

  @override
  void initState() {
    super.initState();
    _goalController =
        TextEditingController(); // Initialize _goalController here
    _initSharedPreferences();
    Provider.of<WorkoutData>(context, listen: false).initializeWorkoutList();
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

    setState(() {});

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

  Future<void> _showAddGoalDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            'Add a Goal:',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: _goalController,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.white),
              hintText: 'Enter your goal',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (_goalController.text.isNotEmpty) {
                  _saveGoal(_goalController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Goal saved!')),
                  );
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Set the button background color
                onPrimary: Colors.white, // Set the button text color
              ),
              child: Text('Save'),
            ),
            SizedBox(width: 10,),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                primary: Colors.green, // Set the button text color
              ),
              child: Text('Cancel'),
            ),

          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white10,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.black26,
          title: Text("Goals & Calendar"),
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: Colors.black,
              ),
              height: MediaQuery.of(context).size.height *
                  0.5, // Adjust the height as needed
              child: MyHeatMap(
                datasets: value.heatMapDataSet,
                startDateYYYYMMDD: value.getStartDate(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 10),
                Text(
                  "My goals:",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(child: Container()),
                // Empty container to expand and fill the remaining space
                FloatingActionButton.extended(
                  onPressed: () => _showAddGoalDialog(context),
                  label: const Text(
                    'Add a new goal',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.green,
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _goals.length,
                itemBuilder: (context, index) {
                  final goalItem = _goals[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Dismissible(
                        key: Key(goalItem.goal),
                        onDismissed: (_) => _deleteGoal(index),
                        background: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                          ),
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
                              color: Colors.white,
                              decorationThickness: 4,
                              decorationColor: Colors.white,
                              decoration: goalItem.completed
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          value: goalItem.completed,
                          onChanged: (_) => _toggleGoalCompletion(index),
                        ),
                      ),
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
