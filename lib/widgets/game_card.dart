import 'package:flutter/material.dart';
import 'package:wagr_challenge/constant/colors.dart';
import 'package:wagr_challenge/model/game.dart';
import 'package:wagr_challenge/util/color_parser.dart';
import 'package:wagr_challenge/widgets/game_date_info.dart';
import 'package:wagr_challenge/widgets/league_info.dart';
import 'package:wagr_challenge/widgets/team_flag.dart';
import 'package:wagr_challenge/widgets/team_info.dart';

class GameCard extends StatelessWidget {
  final Game game;

  GameCard(this.game);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Column(
        children: [
          Card(
            color: whiteCard,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 3,
            child: Container(
                height: 90,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TeamFlag(
                      homeTeam: true,
                      primaryColor: game.homePrimaryColor,
                      secondaryColor: game.homeSecondaryColor,
                    ),
                    TeamInfo(
                      homeTeam: true,
                      spread: _calculateSpread(game.spread),
                      teamName: game.homeTeam.teamName,
                    ),
                    Text('vs.', style: TextStyle(fontSize: 18),),
                    TeamInfo(
                      homeTeam: false,
                      spread: _calculateSpread(game.spread, awayTeam: true),
                      teamName: game.awayTeam.teamName,
                    ),
                    TeamFlag(
                      homeTeam: false,
                      primaryColor: game.awayPrimaryColor,
                      secondaryColor: game.awaySecondaryColor,
                    ),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, right: 3.0, left: 3.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LeagueInfo(
                  league: game.league,
                ),
                GameDateInfo(dateTime: game.gameDatetime)
              ],
            ),
          )
        ],
      ),
    );
  }

  String _calculateSpread(String spread, {bool awayTeam = false}) {
    if (spread == null) return 'Odds pending';
    double calculatedSpread = double.parse(spread);
    calculatedSpread = awayTeam ? (calculatedSpread * -1) : calculatedSpread;
    if (calculatedSpread > 0) {
      return '+' + calculatedSpread.toString();
    }
    return calculatedSpread.toString();
  }
}
