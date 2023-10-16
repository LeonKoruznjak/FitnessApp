import 'package:flutter/cupertino.dart';
import 'package:untitled1/data/datetime.dart';

import '../models/exercise.dart';
import '../models/workout.dart';
import 'hive_database.dart';

class WorkoutData extends ChangeNotifier {
  final db = HiveDatabase();

  List<Workout> workoutList = [
    // default workout
    Workout(name: "Upper body", exercises: [
      Exercise(name: "bicep curl", sets: "5", reps: "10", weight: "15",wasCompleted: false),
    ]),
    Workout(name: "Lower body", exercises: [
      Exercise(name: "Leg curl", sets: "5", reps: "10", weight: "15",wasCompleted: false),
    ])
  ];

  // get list of workouts
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  //get lenght of workout
  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  //number of completed exercies
  int numberOfCompletedExercises(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    int completedCount = 0;

    for (Exercise exercise in relevantWorkout.exercises) {
      if (exercise.isComepleted) {
        completedCount++;
      }
    }

    return completedCount;
  }

  //add a workout
  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));
    notifyListeners();

    db.saveToDatabase(workoutList);
  }

  void deleteWorkout(String name) {
    workoutList.removeWhere((element) => element.name == name);
    notifyListeners();
    db.saveToDatabase(workoutList);
  }

  void renameWorkout(String workoutName,String newName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    relevantWorkout.name=newName;
    notifyListeners();
    db.saveToDatabase(workoutList);
  }

  //add exercise to workout
  void addExercise(
    String workoutName,
    String name,
    String weight,
    String reps,
    String sets,
  ) {
    // find relevant workout
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    relevantWorkout.exercises.add(Exercise(
      name: name,
      weight: weight,
      reps: reps,
      sets: sets,
      isComepleted: false,
      wasCompleted: false,
    ));
    notifyListeners();
    db.saveToDatabase(workoutList);
  }

  void deleteExercise(String workoutName, String exerciseName) {
    print('Deleting exercise: $exerciseName from workout: $workoutName');
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    relevantWorkout.exercises
        .removeWhere((element) => element.name == exerciseName);
    notifyListeners();
    db.saveToDatabase(workoutList);
  }


  //check off exercise
  void checkOffExercise(String workoutName, String exerciseName) {
    // find relevant workout and exercise
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);

    //check off bollean to show user exercise is completed and put wasCompleted to true

    relevantExercise.isComepleted = !relevantExercise.isComepleted;
    relevantExercise.wasCompleted = true;
    notifyListeners();
    //load heat map
    loadHeatMap();
    db.saveToDatabase(workoutList);


  }

  void ResetExercies(String workoutName) {

    Workout relevantWorkout = getRelevantWorkout(workoutName);
    for (Exercise exercise in relevantWorkout.exercises) {
      exercise.isComepleted = false;
    }
    notifyListeners();
    db.saveToDatabase(workoutList);
  }

  void initializeWorkoutList() {
    if (db.previousDataExists()) {
      workoutList = db.readFromDatabase();
    } else {
      db.saveToDatabase(workoutList);
    }

    //load heat map
    loadHeatMap();
  }

  //return relevant workout object based on the workout name
  Workout getRelevantWorkout(String workoutName) {
    // find relevant workout
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workoutName == workout.name);
    return relevantWorkout;
  }

  //return relevant exercise object based on the workout and exercise name
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    // find relevant workout
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);
    return relevantExercise;
  }

  String getStartDate() {
    return db.getStartDate();
  }

  Map<DateTime, int> heatMapDataSet = {};

  void loadHeatMap() {
    DateTime startDate = createDatetimeObject(getStartDate());

    // Count the number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    // Go from start date to today and add each completion status to the dataset
    // "COMPLETION_STATUS_yyyymmdd" will be the key in the database
    for (int i = 0; i <= daysInBetween; i++) {
      String yyyymmdd =
          convertDateTimeToString(startDate.add(Duration(days: i)));

      print('Loading heat map for $yyyymmdd'); // Add this line for debugging

      // Completion status: 0 or 1
      int completionStatus = db.getCompletedStatus(yyyymmdd);

      // Year, month, day
      int year = startDate.add(Duration(days: i)).year;
      int month = startDate.add(Duration(days: i)).month;
      int day = startDate.add(Duration(days: i)).day;

      final percentageForEachDay = <DateTime, int>{
        DateTime(year, month, day): completionStatus
      };

      // Add to the heat map dataset
      heatMapDataSet.addEntries(percentageForEachDay.entries);
    }
  }
}
