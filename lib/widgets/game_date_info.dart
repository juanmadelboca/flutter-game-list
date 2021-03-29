import 'package:flutter/material.dart';
import 'package:wagr_challenge/util/date.dart';

class GameDateInfo extends StatelessWidget {
  final DateTime dateTime;
  final Color gameDateInfoColor = Colors.black38;

  const GameDateInfo({Key key, this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        friendlyHourAndTimeZone(dateTime),
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
}
