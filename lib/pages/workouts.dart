import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../data/workout_data.dart';
import 'workout.dart';

class WorkoutsPage extends StatefulWidget {
  const WorkoutsPage({Key? key}) : super(key: key);

  @override
  State<WorkoutsPage> createState() => _WorkoutsPage();
}

class _WorkoutsPage extends State<WorkoutsPage> {
  final newWorkoutNameController = TextEditingController();
  final changeWorkoutNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<WorkoutData>(context, listen: false).initializeWorkoutList();
  }

  void createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          "Create a new workout!",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: newWorkoutNameController,
          decoration: InputDecoration(
            hintText: "New workout name:",
            hintStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
          ),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: save,
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
          ),
          SizedBox(width: 10,),
          TextButton(
            onPressed: cancel,
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.green),
            ),
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void renameWorkout(String workoutName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text("Rename workout!", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
        content: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(hintText: "New workout name:",
            hintStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
          ),
          controller: changeWorkoutNameController,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              saveNewName(workoutName, changeWorkoutNameController.text);
            },
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
          ),
          SizedBox(width: 10,),
          TextButton(
            onPressed: cancel,
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.green),
            ),
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void saveNewName(
    String workoutName,
    String newName,
  ) {
    Provider.of<WorkoutData>(context, listen: false)
        .renameWorkout(workoutName, newName);
    print("OVO RAdi");
    //pop dialog
    Navigator.pop(context);
    clear();
  }

  // save workout
  void save() {
    // get name from controller
    String workoutName = newWorkoutNameController.text;

    //add new workout
    Provider.of<WorkoutData>(context, listen: false).addWorkout(workoutName);

    //pop dialog
    Navigator.pop(context);
    clear();
  }

  void deleteWorkout(String workoutName) {
    Provider.of<WorkoutData>(context, listen: false).deleteWorkout(workoutName);
  }

  //cancel create workout
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newWorkoutNameController.clear();
    changeWorkoutNameController.clear();
  }

  void goToWorkoutPage(String workoutName) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WorkoutPage(
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
          title: Text("My workouts:"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                onPressed: createNewWorkout,
                label: const Text(
                  'Add a new workout',
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
            itemCount: value.getWorkoutList().length,
            itemBuilder: (context, index) => Slidable(
                  endActionPane: ActionPane(
                    motion: StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => renameWorkout(
                          value.getWorkoutList()[index].name,
                        ),
                        icon: Icons.settings,
                        backgroundColor: Colors.green,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      SlidableAction(
                        onPressed: (context) =>
                            deleteWorkout(value.getWorkoutList()[index].name),
                        icon: Icons.delete,
                        backgroundColor: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        title: Text(
                          value.getWorkoutList()[index].name,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.white),
                              onPressed: () => goToWorkoutPage(
                                  value.getWorkoutList()[index].name),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}
