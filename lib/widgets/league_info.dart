import 'package:flutter/material.dart';
import 'package:wagr_challenge/model/game.dart';

class LeagueInfo extends StatelessWidget {
  final League league;
  final Color leagueInfoColor = Colors.black38;

  const LeagueInfo({Key key, this.league}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          _getLeagueIcon(league),
          color: leagueInfoColor,
          size: 21,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          _getLeagueDisplayName(league),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: leagueInfoColor),
        )
      ],
    );
  }

  IconData _getLeagueIcon(League value) {
    IconData icon;
    switch (value) {
      case League.NHL:
        icon = Icons.sports_hockey;
        break;
      case League.NFL:
        icon = Icons.sports_football_outlined;
        break;
      case League.NBA:
        icon = Icons.sports_basketball_rounded;
        break;
      case League.ENGLISH_PREMIER_LEAGUE:
        icon = Icons.sports_soccer;
        break;
    }
    return icon;
  }

  String _getLeagueDisplayName(League league) {
    String leagueDisplayName;
    switch (league) {
      case League.NHL:
      case League.NFL:
      case League.NBA:
        leagueDisplayName = leagueValues.reverse[league];
        break;
      case League.ENGLISH_PREMIER_LEAGUE:
        leagueDisplayName = 'FIFA';
        break;
    }
    return leagueDisplayName;
  }
}
