import 'package:flutter/material.dart';
import 'package:wagr_challenge/constant/colors.dart';
import 'package:wagr_challenge/model/game.dart';
import 'package:wagr_challenge/util/color_parser.dart';

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
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: fromHex(game.homePrimaryColor),
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(15.0),
                              bottomLeft: const Radius.circular(15.0),
                            ),
                          ),
                          width: 10,
                        ),
                        Container(
                          color: fromHex(game.homeSecondaryColor),
                          width: 10,
                        ),
                      ],
                    ),
                    Container(
                      width: 100,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _calculateSpread(game.spread),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.end,
                            ),
                            Text(game.homeTeam.teamName,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.end),
                          ]),
                    ),
                    Text('vs'),
                    Container(
                      width: 100,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _calculateSpread(game.spread, awayTeam: true),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                            Text(game.awayTeam.teamName,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ]),
                    ),
                    Row(
                      children: [
                        Container(
                          color: fromHex(game.awayPrimaryColor),
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: fromHex(game.awaySecondaryColor),
                            borderRadius: new BorderRadius.only(
                              topRight: const Radius.circular(15.0),
                              bottomRight: const Radius.circular(15.0),
                            ),
                          ),
                          width: 10,
                        ),
                      ],
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
                Row(children: [
                  Icon(getLeagueIcon(game.league)),
                  Text(leagueValues.reverse[game.league])
                ],),
                Row(children: [
                  Text(_friendlyDatePrint(game.gameDatetime)),
                  Icon(Icons.watch_later_outlined),
                ],)
              ],
            ),
          )
        ],
      ),
    );
  }

  IconData getLeagueIcon(League value) {
    IconData icon;
    switch(value) {
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

  String _calculateSpread(String spread, {bool awayTeam = false}){
    String calculatedSpread;
    if(spread == null) return 'Odds pending';
    calculatedSpread = awayTeam? (double.parse(spread) * -1).toString(): spread;
    if(double.parse(calculatedSpread) > 0){
      calculatedSpread = '+' + calculatedSpread;
    }
    return calculatedSpread;
  }
  String _friendlyDatePrint(DateTime dateTime) {
    return dateTime.hour.toString() + dateTime.timeZoneName;
  }
}
