import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/exercise_tile.dart';
import '../data/workout_data.dart';
import '../models/category.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;

  const WorkoutPage({Key? key, required this.workoutName}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  //Check box was tapped
  void onCheckBoxChaneged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkOffExercise(workoutName, exerciseName);
  }

  //text controllers
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

  //cancel create workout
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  //clear the controllers
  void clear() {
    exerciseNameController.clear();
    exerciseWeightController.clear();
    exerciseSetsController.clear();
    exerciseRepsController.clear();
  }

  //delete exercise
  void deleteExercise(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .deleteExercise(workoutName, exerciseName);
  }

  String? selectedCategory;
  ExerciseOption? selectedExercise;

  void createNewExercise() {
    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      trailing: Icon(Icons.list_alt, color: Colors.white),
                      title: Text(
                        selectedCategory ?? 'Select Category',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        openCategoryDrawer(setState);
                      },
                    ),
                  ),
                ),
                if (selectedCategory != null) ...[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      bottom: 8.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListTile(
                        trailing: Icon(
                          Icons.list_alt,
                          color: Colors.white,
                        ),
                        title: Text(
                          selectedExercise != null
                              ? selectedExercise!.name
                              : 'Select Exercise:',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          openExerciseDrawer(setState, selectedCategory!);
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    subtitle: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Weight [kg]:',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      controller: exerciseWeightController,
                    ),
                  ),
                  ListTile(
                    subtitle: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Number of reps:',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      controller: exerciseRepsController,
                    ),
                  ),
                  ListTile(
                    subtitle: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Number of sets:',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      controller: exerciseSetsController,
                    ),
                  ),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 130,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ElevatedButton(
                          onPressed: save,
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 130,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextButton(
                          onPressed: cancel,
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.green),
                          ),
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                          ),
                        ),
                      ),
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
      backgroundColor: Colors.black,
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: exerciseCategories.length,
          itemBuilder: (context, index) {
            final category = exerciseCategories[index];
            print(category);
            return ListTile(
              title: Text(
                category,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
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

  void printExerciseOptions(String categoryName) {
    List<ExerciseOption> options = exerciseOptions["Legs"] ?? [];

    if (options.isNotEmpty) {
      options.forEach((option) {
        print(option.name);
      });
    } else {
      print('No exercise options found for the category: $categoryName');
    }
  }

  void openExerciseDrawer(StateSetter setState, String selectedCategory) {
    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      builder: (context) {
        final exercises = exerciseOptions[selectedCategory];
        print(exercises);

        return ListView(
          children: exercises?.map((exercise) {
                return ListTile(
                  title: Text(
                    exercise.name,
                    style: TextStyle(color: Colors.white),
                  ),
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

  Widget buildTextField(
      {required String hintText, required TextEditingController controller}) {
    return ListTile(
      subtitle: TextField(
        decoration: InputDecoration(hintText: hintText),
        keyboardType: TextInputType.number,
        controller: controller,
      ),
    );
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                onPressed: createNewExercise,
                label: const Text(
                  'Add a new exercise',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                icon: const Icon(Icons.add),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                isExtended: false,
              ),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
          itemBuilder: (context, index) => ExerciseTile(
            showCheckBox: false,
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
            onCheckBoxChanged: (val) => onCheckBoxChaneged(
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
