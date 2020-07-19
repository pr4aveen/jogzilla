import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/run_data.dart';
import '../widgets/navigation_drawer.dart';
import '../widgets/recent_run_tile.dart';

class HomePage extends StatelessWidget {
  static const String routeName = 'home_page';

  final List<RunData> runs = [
    RunData(
      dateTime: 'June 11, 2020 at 10:15 AM',
      distance: '5.00',
      pace: '5:00 min/km',
      duration: '25m 00s',
      description: 'Morning Run',
    ),
    RunData(
      dateTime: 'June 9, 2020 at 9:06 AM',
      distance: '2.40',
      pace: '14.04 /km',
      duration: '10m 00s',
      description: 'IPPT training',
    ),
    RunData(
      dateTime: 'June 8, 2020 at 10:03 PM',
      distance: '3.00',
      pace: '12.00 /km',
      duration: '15m 00s',
      description: 'Late night jog',
    ),
    RunData(
      dateTime: 'June 4, 2020 at 6:06 AM',
      distance: '21.1',
      pace: '9.80 /km',
      duration: '2h 15m 03s',
      description: 'Half Marathon',
    ),
    RunData(
      dateTime: 'June 1, 2020 at 9:06 AM',
      distance: '2.4',
      pace: '14.04 /km',
      duration: '10m 00s',
      description: 'IPPT training',
    ),
  ];

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
      body: Column(
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
              ItemCard(
                height: height * 0.2,
                width: width * 0.85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    OverviewItem(
                      title: '32 km',
                      subtitle: 'TOTAL DISTANCE',
                    ),
                    VerticalDivider(
                      color: Colors.grey[800],
                      indent: height * 0.02,
                      endIndent: height * 0.02,
                      thickness: 1,
                    ),
                    OverviewItem(
                      title: "9' 06\"",
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
                ItemCard(
                  height: height * 0.25,
                  width: width * 0.85,
                  child: Center(child: Text('Stats')),
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
                  padding: EdgeInsets.only(left: width * 0.075),
                  height: height * 0.20,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: runs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RecentRunTile(
                        width: width,
                        height: height,
                        runData: runs[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key key,
    @required this.height,
    @required this.width,
    @required this.child,
  }) : super(key: key);

  final double height;
  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: child,
      height: height,
      width: width,
    );
  }
}

class OverviewItem extends StatelessWidget {
  const OverviewItem({@required this.title, @required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
                fontSize: 32.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle,
            style: const TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
