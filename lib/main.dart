import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'data/workout_data.dart';
import 'pages/home_page.dart';

void main() async {
  //initialize Hive
  await Hive.initFlutter();
  //open Hive box
  await Hive.openBox("workout_database_test2");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        theme: ThemeData(
          bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white10,),
          canvasColor: Colors.white10,
          unselectedWidgetColor: Colors.white,
        ),
      ),
    );
  }
}
