import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/pages/goals_and_calendar_page.dart';
import 'package:untitled1/pages/my_goals.dart';
import 'package:untitled1/pages/personal_records_page.dart';
import 'package:untitled1/pages/start_workout.dart';
import 'package:untitled1/pages/workout_calendar_page.dart';
import 'workouts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text(
          "Home page",
          style: TextStyle(color: Colors.white),
        ),
        leading: Icon(Icons.home),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("lib/assets/start_a_workout.jpeg"),
                    fit: BoxFit.fill,
                  ),
                ),
                height: 300,
                child: Card(
                  color: Colors.transparent,
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: Colors.white60,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return const startWorkoutPage();
                        }),
                      );
                    },
                    child: const SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Center(
                        child: Text(
                          "Start a workout",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("lib/assets/goals_&_calendar.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
                height: 300,
                child: Card(
                  color: Colors.transparent,
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: Colors.white60,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return const GoalsAndCalendar();
                        }),
                      );
                    },
                    child: const SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Center(
                        child: Text(
                          "Goals & Calendar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("lib/assets/my_workouts.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
                height: 300,
                child: Card(
                  color: Colors.transparent,
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: Colors.white60,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return const WorkoutsPage();
                        }),
                      );
                    },
                    child: const SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Center(
                        child: Text(
                          "My workouts",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("lib/assets/my_prs.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
                height: 300,
                child: Card(
                  color: Colors.transparent,
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: Colors.white60,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return PersonalRecordsPage();
                        }),
                      );
                    },
                    child: const SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Center(
                        child: Text(
                          "My PR's",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
