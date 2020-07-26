import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:jogzilla/models/run_data.dart';

class AllRunsSummarryChart extends StatelessWidget {
  final List<RunData> allRuns;

  AllRunsSummarryChart({@required this.allRuns});

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  String _getTotalDistance() {
    double totalDistance = 0;
    for (int i = 0; i < allRuns.length; i++) {
      totalDistance += allRuns[i].distance;
    }
    return totalDistance.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'RUN SUMMARY',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Total Distance: ' + _getTotalDistance(),
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: LineChart(
              LineChartData(
                borderData: FlBorderData(
                    show: false,
                    border:
                        Border.all(color: const Color(0xff37434d), width: 1)),
                titlesData: FlTitlesData(
                  show: false,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTitles: (value) => (value + 1).toInt().toString(),
                  ),
                  leftTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(allRuns.length,
                        (i) => FlSpot(i.toDouble(), allRuns[i].distance)),
                    colors: gradientColors,
                    barWidth: 7,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 0,
            color: Colors.grey[800],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
