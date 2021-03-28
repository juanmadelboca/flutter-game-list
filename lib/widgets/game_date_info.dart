import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GameDateInfo extends StatelessWidget {
  final DateTime dateTime;
  final Color gameDateInfoColor = Colors.black38;

  const GameDateInfo({Key key, this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        _friendlyDatePrint(dateTime),
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: gameDateInfoColor),
      ),
      SizedBox(
        width: 5,
      ),
      Icon(
        Icons.watch_later_outlined,
        color: gameDateInfoColor,
        size: 21,
      ),
    ]);
  }

  String _friendlyDatePrint(DateTime dateTime) {
    return DateFormat.jm().format(dateTime) + ' ' ;
  }
}
