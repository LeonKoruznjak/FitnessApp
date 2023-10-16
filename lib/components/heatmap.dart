import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:hive/hive.dart';
import 'package:untitled1/data/datetime.dart';

class MyHeatMap extends StatelessWidget {

  final Map<DateTime, int>? datasets;
  final String startDateYYYYMMDD;

  const MyHeatMap({
    super.key,
    required this.datasets,
    required this.startDateYYYYMMDD});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          color: Colors.white10,

        ),
        padding: EdgeInsets.only(top: 15,left: 20,right: 20,bottom: 15),
        child: Center(
          child: HeatMap(
            startDate: createDatetimeObject(startDateYYYYMMDD),
            endDate: DateTime.now().add(const Duration(days: 47)),
            datasets: datasets,
            colorMode: ColorMode.color,
            defaultColor: Colors.white70,
            textColor: Colors.white,
            showColorTip: false,
            showText: true,
            scrollable: true,
            size: 40,
            colorsets: const{
              1:Colors.green,
            },
          ),
        ),
      ),
    );
  }
}
