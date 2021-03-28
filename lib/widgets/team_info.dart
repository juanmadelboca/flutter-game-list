import 'package:flutter/material.dart';

class TeamInfo extends StatelessWidget {
  final String teamName;
  final bool homeTeam;
  final String spread;

  const TeamInfo({Key key, this.teamName, this.homeTeam, this.spread}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: homeTeam? CrossAxisAlignment.end: CrossAxisAlignment.start, children: [
        Text(
          spread,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          textAlign: homeTeam ? TextAlign.end : TextAlign.start,
        ),
        Text(
          teamName,
          maxLines: 2,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: homeTeam ? TextAlign.end : TextAlign.start,
        ),
      ]),
    );
  }
}
