

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/heatmap.dart';
import '../data/workout_data.dart';

class MyHeatMapCalendar extends StatefulWidget {
  const MyHeatMapCalendar({Key? key}) : super(key: key);

  @override
  State<MyHeatMapCalendar> createState() => _MyHeatMapCalendarState();
}

class _MyHeatMapCalendarState extends State<MyHeatMapCalendar> {
  @override
  void initState() {
    super.initState();
    Provider.of<WorkoutData>(context, listen: false).initializeWorkoutList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        body: Column(
            children:[MyHeatMap(
                datasets: value.heatMapDataSet,
                startDateYYYYMMDD: value.getStartDate()),]
        ),
      ),
    );
  }
}

/*
Consumer<WorkoutData>(
builder: (context, value, child) => Scaffold(
body: Column(
children:[MyHeatMap(
datasets: value.heatMapDataSet,
startDateYYYYMMDD: value.getStartDate()),]
),
),
);
*/