import 'package:flutter/material.dart';

import '../models/run_data.dart';
import '../screens/detailed_run_history_page.dart';

class RecentRunTile extends StatelessWidget {
  const RecentRunTile({
    Key key,
    @required this.width,
    @required this.height,
    @required this.runData,
  }) : super(key: key);

  final double width;
  final double height;
  final RunData runData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(DetailedRunHistoryPage.routeName, arguments: runData);
      },
      child: Padding(
        padding: EdgeInsets.only(right: width * 0.03),
        child: Container(
          width: width * 0.35,
          height: height * 0.2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
            crossAxisCount: 2,
            children: <Widget>[
              Icon(
                Icons.location_on,
                color: Colors.green[200],
                size: 48,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Jan 31',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    '6:20 pm',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      runData.distance,
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      'KM',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
