import 'dart:convert';

import 'package:wagr_challenge/enum/league.dart';
import 'package:wagr_challenge/enum/sport.dart';

List<Game> gameFromJson(String str) => List<Game>.from(json.decode(str).map((x) => Game.fromJson(x)));

String gameToJson(List<Game> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Game {
  Game({
    this.gameId,
    this.sport,
    this.gameDatetime,
    this.league,
    this.homeTeamKey,
    this.homePrimaryColor,
    this.homeSecondaryColor,
    this.awayTeamKey,
    this.awayPrimaryColor,
    this.awaySecondaryColor,
    this.spread,
    this.homeTeam,
    this.awayTeam,
  });

  int gameId;
  Sport sport;
  DateTime gameDatetime;
  League league;
  String homeTeamKey;
  String homePrimaryColor;
  String homeSecondaryColor;
  String awayTeamKey;
  String awayPrimaryColor;
  String awaySecondaryColor;
  String spread;
  Team homeTeam;
  Team awayTeam;

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        gameId: json["gameId"],
        sport: sportValues.map[json["sport"]],
        gameDatetime: DateTime.parse(json["gameDatetime"]),
        league: leagueValues.map[json["league"]],
        homeTeamKey: json["homeTeamKey"],
        homePrimaryColor: json["homePrimaryColor"],
        homeSecondaryColor: json["homeSecondaryColor"],
        awayTeamKey: json["awayTeamKey"],
        awayPrimaryColor: json["awayPrimaryColor"],
        awaySecondaryColor: json["awaySecondaryColor"],
        spread: json["spread"] == null ? null : json["spread"],
        homeTeam: Team.fromJson(Map<String, dynamic>.from(json["homeTeam"])),
        awayTeam: Team.fromJson(Map<String, dynamic>.from(json["awayTeam"])),
      );

  Map<String, dynamic> toJson() => {
        "gameId": gameId,
        "sport": sportValues.reverse[sport],
        "gameDatetime": gameDatetime.toIso8601String(),
        "league": leagueValues.reverse[league],
        "homeTeamKey": homeTeamKey,
        "homePrimaryColor": homePrimaryColor,
        "homeSecondaryColor": homeSecondaryColor,
        "awayTeamKey": awayTeamKey,
        "awayPrimaryColor": awayPrimaryColor,
        "awaySecondaryColor": awaySecondaryColor,
        "spread": spread == null ? null : spread,
        "homeTeam": homeTeam.toJson(),
        "awayTeam": awayTeam.toJson(),
      };
}

class Team {
  Team({
    this.teamId,
    this.teamName,
    this.city,
    this.teamKey,
    this.primaryColor,
    this.secondaryColor,
  });

  int teamId;
  String teamName;
  String city;
  String teamKey;
  String primaryColor;
  String secondaryColor;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        teamId: json["teamId"],
        teamName: json["teamName"],
        city: json["city"],
        teamKey: json["teamKey"],
        primaryColor: json["primaryColor"],
        secondaryColor: json["secondaryColor"],
      );

  Map<String, dynamic> toJson() => {
        "teamId": teamId,
        "teamName": teamName,
        "city": city,
        "teamKey": teamKey,
        "primaryColor": primaryColor,
        "secondaryColor": secondaryColor,
      };
}
