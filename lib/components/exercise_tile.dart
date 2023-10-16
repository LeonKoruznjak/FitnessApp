import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../data/workout_data.dart';

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String reps;
  final String sets;
  final bool isCompleted;
  final bool showCheckBox;
  void Function(bool?)? onCheckBoxChanged;
  Function(BuildContext)? deleteExercise;

  ExerciseTile(
      {Key? key,
      required this.exerciseName,
      required this.weight,
      required this.reps,
      required this.sets,
      required this.isCompleted,
      required this.onCheckBoxChanged,
      required this.deleteExercise,
      required this.showCheckBox})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                onPressed: deleteExercise,
                icon: Icons.delete,
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.circular(15),
              )
            ],
          ),
          child: ListTile(
            title: Text(exerciseName,
                style: TextStyle(
                    decorationThickness: 4,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none)),
            subtitle: Row(
              children: [
                Chip(
                  label: Text(
                    "${weight}kg",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Chip(
                  label: Text(
                    "${reps}reps",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Chip(
                  label: Text(
                    "${sets}sets",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            trailing: showCheckBox
                ? Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.green,
                    value: isCompleted,
                    onChanged: (value) => onCheckBoxChanged!(value),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
