import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jogzilla/widgets/navigation_drawer.dart';

class HomePage extends StatelessWidget {
  static const String routeName = 'home_page';

  final List runs = [1, 2, 3, 4, 5, 6];

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
                      return Padding(
                        padding: EdgeInsets.only(right: width * 0.03),
                        child: ItemCard(
                          width: width * 0.35,
                          height: height * 0.2,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(runs[index].toString() + 'km'),
                              ],
                            ),
                          ),
                        ),
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
