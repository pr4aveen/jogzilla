import 'package:flutter/material.dart';
import 'package:jogzilla/widgets/all_runs_summary_chart.dart';

import '../models/run_data.dart';
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
      ),
      drawer: NavigationDrawer(),
      body: FutureBuilder(
        future: storage.queryAllRuns(),
        builder: (BuildContext context, AsyncSnapshot<List<RunData>> snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  // placeholder until statistics widget is ready
                  child: AllRunsSummarryChart(allRuns: snapshot.data),
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
