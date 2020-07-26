import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/run_data.dart';
import '../services/database_storage.dart';
import '../widgets/navigation_drawer.dart';
import '../widgets/overview_item.dart';
import '../widgets/past_week_runs.dart';
import '../widgets/recent_run_tile.dart';

class HomePage extends StatelessWidget {
  static const String routeName = 'home_page';

  final DatabaseStorage storage = DatabaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('jogzilla'),
      ),
      backgroundColor: Colors.grey[200],
      drawer: NavigationDrawer(),
      body: FutureBuilder(
          future: storage.queryAllRuns(),
          builder:
              (BuildContext context, AsyncSnapshot<List<RunData>> snapshot) {
            if (snapshot.hasData) {
              return HomePageBody(
                  height: height, width: width, runs: snapshot.data);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class HomePageBody extends StatelessWidget {
  HomePageBody({
    Key key,
    @required this.height,
    @required this.width,
    @required this.runs,
  }) : super(key: key);

  final double height;
  final double width;
  final List<RunData> runs;

  final BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
  );

  String _totalDistance() {
    double totalDistance = 0;
    for (int i = 0; i < runs.length; i++) {
      totalDistance += runs[i].distance;
    }
    return totalDistance.toString() + ' km';
  }

  String _avgPace() {
    if (runs.length == 0) {
      return "0' 00\"";
    }
    double avgPace = 0;
    for (int i = 0; i < runs.length; i++) {
      avgPace += runs[i].pace;
    }
    avgPace /= runs.length;
    return "${avgPace.toString().split('.')[0]}' " +
        "${avgPace.toString().split('.')[1].substring(0, 2)}\"";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
              ),
              margin: EdgeInsets.only(bottom: height * 0.1, top: 0),
              height: height * 0.15,
            ),
            Container(
              height: height * 0.2,
              width: width * 0.85,
              decoration: cardDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  OverviewItem(
                    title: _totalDistance(),
                    subtitle: 'TOTAL DISTANCE',
                  ),
                  VerticalDivider(
                    color: Colors.grey[800],
                    indent: height * 0.02,
                    endIndent: height * 0.02,
                    thickness: 1,
                  ),
                  OverviewItem(
                    title: _avgPace(),
                    subtitle: 'AVERAGE PACE',
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: width * 0.85,
                child: Text(
                  'This week',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: height * 0.25,
                width: width * 0.85,
                decoration: cardDecoration,
                padding: EdgeInsets.only(top: height * 0.02),
                child: Center(child: PastWeekRuns(now: DateTime.now())),
              ),
              Container(
                width: width * 0.85,
                child: Text(
                  'Recent runs',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: height * 0.20,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: runs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding:
                          EdgeInsets.only(left: index == 0 ? width * 0.075 : 0),
                      child: RecentRunTile(
                        width: width,
                        height: height,
                        runData: runs[runs.length - 1 - index],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
