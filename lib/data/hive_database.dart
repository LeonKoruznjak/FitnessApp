


import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled1/data/datetime.dart';

import '../models/exercise.dart';
import '../models/workout.dart';

class HiveDatabase {
  // reference our Hive box
  final _myBox = Hive.box("workout_database_test2");

  // check if there is data stored if not record the save date
  bool previousDataExists() {
    if (_myBox.isEmpty) {
      print("Previous data does not exists");
      _myBox.put("START_DATE", todaysDateFormatted());
      return false;
    } else {
      print("Previous data does exists");
      return true;
    }
  }

  //write data
  void saveToDatabase(List<Workout> workouts) {
    final workoutList = convertObjectToWorkoutList(workouts);
    final exerciseList = convertObjectToExerciseList(workouts);

    //check if any exercises have been done
    if(exerciseWasCompleted(workouts)){
      _myBox.put("COMPLETION_STATUS_${todaysDateFormatted()}",1);
    }else{
      _myBox.put("COMPLETION_STATUS_${todaysDateFormatted()}",0);
    }

    // save into hive
    _myBox.put("WORKOUTS", workoutList);
    _myBox.put("EXERCISES", exerciseList);
  }

  //read data and return a list of workouts
  List<Workout> readFromDatabase() {
    List<Workout> mySavedWorkouts = [];

    List<String> workoutNames = _myBox.get("WORKOUTS");
    final exerciseDetails = _myBox.get("EXERCISES");

    //create workoutobjects
    for (int i = 0; i < workoutNames.length; i++) {
      // each workout can have multiple exercises
      List<Exercise> exercisesInEachWorkout = [];

      for (int j = 0; j < exerciseDetails[i].length; j++) {
        // so add each exercise in to a list
        exercisesInEachWorkout.add(
          Exercise(
            name: exerciseDetails[i][j][0],
            weight: exerciseDetails[i][j][1],
            reps: exerciseDetails[i][j][2],
            sets: exerciseDetails[i][j][3],
            isComepleted: exerciseDetails[i][j][4]== "true"? true:false,
            wasCompleted: exerciseDetails[i][j][5]== "true"? true:false,
          ),
        );
      }
      Workout workout=Workout(name: workoutNames[i], exercises: exercisesInEachWorkout);

      //add individual workout to overall list
      mySavedWorkouts.add(workout);
    }
    return mySavedWorkouts;
  }

  //check exercise done
  bool exerciseWasCompleted(List<Workout> workouts) {
    //go through each workout
    for (var workout in workouts) {
      //go through each exercise in workouts
      for (var exercise in workout.exercises) {
        if (exercise.wasCompleted) {
          return true;
        }
      }
    }
    return false;
  }

  // converts workout objects in a list of strings so it can be saved with hive
  List<String> convertObjectToWorkoutList(List<Workout> workouts) {
    List<String> workoutList = [];

    for (int i = 0; i < workouts.length; i++) {
      // in each workout,add the name followed by a list of exercises
      workoutList.add(workouts[i].name);
    }

    return workoutList;
  }

  // converts exercises in a workout object in a list of strings so it can be saved with hive
  List<List<List<String>>> convertObjectToExerciseList(List<Workout> workouts) {
    List<List<List<String>>> exerciseList = [];

    for (int i = 0; i < workouts.length; i++) {
      //get exercise from each workout
      List<Exercise> exerciseInWorkout = workouts[i].exercises;

      List<List<String>> individualWorkout = [];

      for (int j = 0; j < exerciseInWorkout.length; j++) {
        List<String> individualExercise = [];

        individualExercise.addAll([
          exerciseInWorkout[j].name,
          exerciseInWorkout[j].weight,
          exerciseInWorkout[j].reps,
          exerciseInWorkout[j].sets,
          exerciseInWorkout[j].isComepleted.toString(),
          exerciseInWorkout[j].wasCompleted.toString(),
        ],);
        individualWorkout.add(individualExercise);
      }

      exerciseList.add(individualWorkout);
    }
    return exerciseList;
  }


  String getStartDate() {
    return _myBox.get("START_DATE");
  }

  //get completion status of a given date yyyymmdd

int getCompletedStatus(String yyyymmdd){
    //returns 0 or 1, if null return 0
  int completionStatus= _myBox.get("COMPLETION_STATUS_$yyyymmdd") ?? 0;
  return completionStatus;

}


}



