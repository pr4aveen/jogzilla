import 'package:flutter/material.dart';

import '../models/run_data.dart';
import '../screens/run_config_page.dart';
import '../services/database_storage.dart';
import '../widgets/navigation_drawer.dart';
import '../widgets/run_history_tile.dart';

class RunHistoryPage extends StatelessWidget {
  static const String routeName = 'run_history_page';
  final DatabaseStorage storage = DatabaseStorage.instance;

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
        onPressed: () => Navigator.pushNamed(context, RunConfigPage.routeName),
        label: Text('Start New Run'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: FutureBuilder(
        future: storage.queryAllRuns(),
        builder: (BuildContext context, AsyncSnapshot<List<RunData>> snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
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
                        data: snapshot.data[index],
                      );
                    },
                    childCount: snapshot.data.length,
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
