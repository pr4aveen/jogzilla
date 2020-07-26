import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jogzilla/models/run_data.dart';
import 'package:jogzilla/services/database_storage.dart';

class PastWeekRuns extends StatelessWidget {
  final DateTime now;
  final DatabaseStorage storage = DatabaseStorage.instance;

  PastWeekRuns({@required this.now});

  List<BarChartRodData> runDistanceByDay(List<RunData> pastWeekRuns) {
    DateTime today = DateTime(now.year, now.month, now.day);
    List<List<RunData>> pastWeekRunsByDay = List.generate(7, (index) => []);

    for (int i = 0; i < pastWeekRuns.length; i++) {
      RunData current = pastWeekRuns[i];

      Duration timeDifference =
          DateTime.parse(current.dateTime).difference(today);

      if (timeDifference.isNegative) {
        pastWeekRunsByDay[timeDifference.inDays + 5].add(current);
      } else {
        pastWeekRunsByDay[6].add(current);
      }
    }

    List<BarChartRodData> runDistanceByDay =
        pastWeekRunsByDay.map((runsPerDay) {
      double totalDistancePerDay = 0;
      for (int i = 0; i < runsPerDay.length; i++) {
        totalDistancePerDay += double.parse(runsPerDay[i].distance);
      }
      return BarChartRodData(
          y: totalDistancePerDay, color: Colors.lightBlueAccent);
    }).toList();

    return runDistanceByDay;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: storage.getPastWeekRuns(now),
      builder: (BuildContext context, AsyncSnapshot<List<RunData>> snapshot) {
        if (snapshot.hasData) {
          return BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: List.generate(
                7,
                (i) => BarChartGroupData(
                  x: i,
                  barRods: [runDistanceByDay(snapshot.data)[i]],
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,
                  textStyle: TextStyle(
                      color: const Color(0xff7589a2),
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                  margin: 20,
                  getTitles: (double value) {
                    if (value.toInt() == 6) return 'Today';
                    int dayOfTheWeek = now.weekday;
                    switch ((value.toInt() + dayOfTheWeek) % 7) {
                      case 0:
                        return 'Mon';
                      case 1:
                        return 'Tue';
                      case 2:
                        return 'Wed';
                      case 3:
                        return 'Thu';
                      case 4:
                        return 'Fri';
                      case 5:
                        return 'Sat';
                      case 6:
                        return 'Sun';
                      default:
                        return '';
                    }
                  },
                ),
                leftTitles: SideTitles(showTitles: false),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
