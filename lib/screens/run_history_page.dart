import 'package:flutter/material.dart';

import './run_progress_page.dart';
import '../models/run_data.dart';
import '../widgets/navigation_drawer.dart';
import '../widgets/run_history_tile.dart';

class RunHistoryPage extends StatelessWidget {
  static const String routeName = 'run_history_page';
  final List<RunData> sampleData = [
    RunData(
      dateTime: 'June 11, 2020 at 10:15 AM',
      distance: '5.00 km',
      pace: '5:00 min/km',
      duration: '25m 00s',
      description: 'Morning Run',
    ),
    RunData(
      dateTime: 'June 9, 2020 at 9:06 AM',
      distance: '2.40 km',
      pace: '14.04 /km',
      duration: '10m 00s',
      description: 'IPPT training',
    ),
    RunData(
      dateTime: 'June 8, 2020 at 10:03 PM',
      distance: '3.00 km',
      pace: '12.00 /km',
      duration: '15m 00s',
      description: 'Late night jog',
    ),
    RunData(
      dateTime: 'June 4, 2020 at 6:06 AM',
      distance: '21.1 km',
      pace: '9.80 /km',
      duration: '2h 15m 03s',
      description: 'Half Marathon',
    ),
    RunData(
      dateTime: 'June 1, 2020 at 9:06 AM',
      distance: '2.4 km',
      pace: '14.04 /km',
      duration: '10m 00s',
      description: 'IPPT training',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Run History'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      drawer: NavigationDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Navigator.pushNamed(context, RunProgressPage.routeName),
        label: Text('Start New Run'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            // placeholder until statistics widget is ready
            child: Container(
              color: Theme.of(context).primaryColor,
              height: 350,
              child: Center(
                child: Text(
                  'SUMMARY STATISTICS',
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return RunHistoryTile(
                  data: sampleData[index],
                );
              },
              childCount: sampleData.length,
            ),
          ),
        ],
      ),
    );
  }
}
