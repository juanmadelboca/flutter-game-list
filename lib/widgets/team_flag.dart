import 'package:flutter/material.dart';
import 'package:wagr_challenge/util/color_parser.dart';

class TeamFlag extends StatelessWidget {
  final bool homeTeam;
  final String primaryColor;
  final String secondaryColor;

  const TeamFlag({Key key, this.homeTeam, this.primaryColor, this.secondaryColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: fromHex(primaryColor),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(homeTeam ? 15.0 : 0.0),
              bottomLeft: Radius.circular(homeTeam ? 15.0 : 0.0),
            ),
          ),
          width: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: fromHex(secondaryColor),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(homeTeam ? 0.0 : 15.0),
              bottomRight: Radius.circular(homeTeam ? 0.0 : 15.0),
            ),
          ),
          width: 10,
        ),
      ],
    );
  }
}
