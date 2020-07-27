import 'package:flutter/material.dart';

import '../models/run_data.dart';
import '../services/database_storage.dart';
import '../widgets/all_runs_summary_chart.dart';
import '../widgets/navigation_drawer.dart';
import '../widgets/overview_item.dart';
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
            return snapshot.data.length == 0
                ? Center(
                    child: OverviewItem(
                      title: 'Run History Unavailable',
                      subtitle: 'Now would be a good time to go for a run',
                      bold: false,
                    ),
                  )
                : CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: AllRunsSummarryChart(allRuns: snapshot.data),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return RunHistoryTile(
                              data: snapshot
                                  .data[snapshot.data.length - index - 1],
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
