import 'package:flutter/material.dart';

class RunProgressCard extends StatelessWidget {
  final String cardText;
  final double textSize;
  final Color backgroundColor;
  final Color textColor;

  RunProgressCard({
    @required this.cardText,
    this.textSize = 32.0,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          cardText,
          style: TextStyle(
            fontSize: textSize,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: backgroundColor,
      ),
    );
  }
}
