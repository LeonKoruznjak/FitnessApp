import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/exercise_tile.dart';
import '../data/workout_data.dart';
import '../models/category.dart';
import 'workout_completion_page.dart';

class workoutSessionPage extends StatefulWidget {
  final String workoutName;

  const workoutSessionPage({Key? key, required this.workoutName})
      : super(key: key);

  @override
  State<workoutSessionPage> createState() => _workoutSessionPage();
}

class _workoutSessionPage extends State<workoutSessionPage> {
  // Check box was tapped
  void onCheckBoxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkOffExercise(workoutName, exerciseName);
  }

  // Text controllers
  final exerciseNameController = TextEditingController();
  final exerciseWeightController = TextEditingController();
  final exerciseRepsController = TextEditingController();
  final exerciseSetsController = TextEditingController();

  void save() {
    if (selectedCategory != null) {
      String newExerciseName = selectedExercise!.name;
      String newExerciseSets = exerciseSetsController.text;
      String newExerciseReps = exerciseRepsController.text;
      String newExerciseWeight = exerciseWeightController.text;

      Provider.of<WorkoutData>(context, listen: false).addExercise(
        widget.workoutName,
        newExerciseName,
        newExerciseWeight,
        newExerciseReps,
        newExerciseSets,
      );

      selectedExercise = null;
      Navigator.pop(context);
      clear();
    }
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    exerciseNameController.clear();
    exerciseWeightController.clear();
    exerciseSetsController.clear();
    exerciseRepsController.clear();
  }

  void deleteExercise(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false).deleteExercise(
      workoutName,
      exerciseName,
    );
  }

  String? selectedCategory;
  ExerciseOption? selectedExercise;

  void createNewExercise() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                ListTile(
                  title: Text(selectedCategory ?? 'Select Category'),
                  onTap: () {
                    openCategoryDrawer(setState);
                  },
                ),
                if (selectedCategory != null) ...[
                  ListTile(
                    title: Text(selectedExercise != null
                        ? selectedExercise!.name
                        : 'Select Exercise'),
                    onTap: () {
                      openExerciseDrawer(setState, selectedCategory!);
                    },
                  ),
                  ListTile(
                    subtitle: TextField(
                      decoration: InputDecoration(hintText: 'Weight [kg]:'),
                      keyboardType: TextInputType.number,
                      controller: exerciseWeightController,
                    ),
                  ),
                  ListTile(
                    subtitle: TextField(
                      decoration: InputDecoration(hintText: 'Number of reps:'),
                      keyboardType: TextInputType.number,
                      controller: exerciseRepsController,
                    ),
                  ),
                  ListTile(
                    subtitle: TextField(
                      decoration: InputDecoration(hintText: 'Number of sets:'),
                      keyboardType: TextInputType.number,
                      controller: exerciseSetsController,
                    ),
                  ),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: save,
                      child: Text('Save'),
                    ),
                    TextButton(
                      onPressed: cancel,
                      child: Text('Cancel'),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  void openCategoryDrawer(StateSetter setState) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: exerciseCategories.length,
          itemBuilder: (context, index) {
            final category = exerciseCategories[index];
            print(category);
            return ListTile(
              title: Text(category),
              onTap: () {
                setState(() {
                  selectedCategory = category;
                });
                print(selectedCategory);
                Navigator.pop(context); // Close the category drawer
              },
            );
          },
        );
      },
    );
  }

  void openExerciseDrawer(StateSetter setState, String selectedCategory) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final exercises = exerciseOptions[selectedCategory];
        print(exercises);

        return Column(
          children: exercises?.map((exercise) {
                return ListTile(
                  title: Text(exercise.name),
                  onTap: () {
                    setState(() {
                      selectedExercise = exercise;
                    });
                    Navigator.pop(context); // Close the exercise drawer
                  },
                );
              }).toList() ??
              [],
        );
      },
    );
  }

  bool isTimerRunning = false;
  Stopwatch stopwatch = Stopwatch();
  String elapsedTime = '00:00:00';
  Timer? timer;

  void startTimer() {
    setState(() {
      isTimerRunning = true;
      stopwatch.start();
      timer = Timer.periodic(Duration(seconds: 1), (_) {
        setState(() {
          elapsedTime = formatElapsedTime(stopwatch.elapsed);
        });
      });
    });
  }

  void pauseTimer() {
    setState(() {
      isTimerRunning = false;
      stopwatch.stop();
      if (timer != null) {
        timer!.cancel();
      }
      // Update the elapsed time when pausing
      elapsedTime = formatElapsedTime(stopwatch.elapsed);
    });
  }

  void resetTimer() {
    setState(() {
      isTimerRunning = false;
      stopwatch.reset();
      elapsedTime = '00:00:00';
      if (timer != null) {
        timer!.cancel();
      }
    });
  }

  String formatElapsedTime(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void ResetExercises(String workoutName) {
    Provider.of<WorkoutData>(context, listen: false).ResetExercies(workoutName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white10,
        appBar: AppBar(
          backgroundColor: Colors.black26,
          title: Text(widget.workoutName),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutCompletionPage(
                      workoutName: widget.workoutName,
                      completedExercises:
                          value.numberOfCompletedExercises(widget.workoutName),
                      elapsedTime: elapsedTime,
                    ),
                  ),
                ).then((_) {
                  setState(() {
                    ResetExercises(widget.workoutName);
                  });
                });
              },
              icon: Icon(Icons.done),
            ),
          ],
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            // Adjust the preferred size as needed
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      isTimerRunning
                          ? elapsedTime
                          : formatElapsedTime(stopwatch.elapsed),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 110,),
                    IconButton(
                      onPressed: isTimerRunning ? pauseTimer : startTimer,
                      icon: Icon(
                        isTimerRunning ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),


        body: ListView.builder(
          itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
          itemBuilder: (context, index) => ExerciseTile(
            showCheckBox: true,
            exerciseName: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .name,
            weight: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .weight,
            reps: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .reps,
            sets: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .sets,
            isCompleted: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .isComepleted,
            onCheckBoxChanged: (val) => onCheckBoxChanged(
                widget.workoutName,
                value
                    .getRelevantWorkout(widget.workoutName)
                    .exercises[index]
                    .name),
            deleteExercise: (context) => deleteExercise(
              widget.workoutName,
              value
                  .getRelevantWorkout(widget.workoutName)
                  .exercises[index]
                  .name,
            ),
          ),
        ),
      ),
    );
  }
}
