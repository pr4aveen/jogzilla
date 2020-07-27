import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  const CustomRoundedButton(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.onTap,
      @required this.title,
      @required this.color})
      : super(key: key);

  final double height;
  final double width;
  final Function onTap;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        child: Text(title),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: color),
      ),
      onTap: onTap,
    );
  }
}
