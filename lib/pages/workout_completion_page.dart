import 'package:flutter/material.dart';


class WorkoutCompletionPage extends StatelessWidget {
  final String elapsedTime;
  final int completedExercises;
  final String workoutName;

  const WorkoutCompletionPage({Key? key, required this.elapsedTime, required this.completedExercises, required this.workoutName})
      : super(key: key);





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$workoutName',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Completed!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Completed Exercises: $completedExercises',
                style: TextStyle(fontSize: 20,color: Colors.white),
              ),
              SizedBox(height: 15),
              Text(
                'Elapsed Time: $elapsedTime',
                style: TextStyle(fontSize: 20,color: Colors.white),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Set the button background color
                  onPrimary: Colors.white, // Set the button text color
                ),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text('Return to Home Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}