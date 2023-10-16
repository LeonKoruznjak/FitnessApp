import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/pages/workout_session_page.dart';

import '../data/workout_data.dart';
import 'workout.dart';

class startWorkoutPage extends StatefulWidget {
  const startWorkoutPage({Key? key}) : super(key: key);

  @override
  State<startWorkoutPage> createState() => _startWorkoutPage();
}

class _startWorkoutPage extends State<startWorkoutPage> {
  final newWorkoutNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<WorkoutData>(context, listen: false).initializeWorkoutList();
  }


  void goToWorkoutPage(String workoutName) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => workoutSessionPage(
              workoutName: workoutName,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white10,
        appBar: AppBar(
          backgroundColor: Colors.black26,
          title: Text("Select a workout to begin:"),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white10,
          ),
          child: ListView.builder(
              itemCount: value.getWorkoutList().length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0, top: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      value.getWorkoutList()[index].name,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.start,color: Colors.white),
                          onPressed: () => goToWorkoutPage(
                              value.getWorkoutList()[index].name),
                        ),
                      ],
                    ),
                  ),
                ),
              ),),
        ),
      ),
    );
  }
}
