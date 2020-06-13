import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/run_data.dart';
import '../widgets/run_history_tile.dart';

// consider using normal appbar and unpinned sliverappbar for statistics page.
// grey colur seperation (vertical) for run metrics

class RunHistory extends StatelessWidget {
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
      distance: '3.00 km km',
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
      backgroundColor: kDarkBackground,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 350.0,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title: Text('STATISTICS'),
            ),
            pinned: true,
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
