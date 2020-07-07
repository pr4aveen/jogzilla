import 'package:flutter/material.dart';

class RunDataItem extends StatelessWidget {
  final String label;
  final String value;
  Color color = Colors.grey.shade500;

  RunDataItem({
    @required this.label,
    @required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: Theme.of(context).textTheme.caption.copyWith(color: color),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}
