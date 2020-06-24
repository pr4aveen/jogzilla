import 'package:flutter/material.dart';

class RunProgressPage extends StatelessWidget {
  static const String routeName = 'run_progress_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RunProgressCard(
                cardText: '3.04 km',
                textSize: 48,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    RunProgressCard(cardText: '12m 34s'),
                    RunProgressCard(cardText: '15 km/h')
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    RunProgressCard(cardText: 'PAUSE'),
                    RunProgressCard(cardText: 'STOP')
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

class RunProgressCard extends StatelessWidget {
  final String cardText;
  final double textSize;

  RunProgressCard({@required this.cardText, this.textSize = 32.0});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Center(
          child: Text(
            cardText,
            style: TextStyle(
              fontSize: textSize,
            ),
          ),
        ),
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          // color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
