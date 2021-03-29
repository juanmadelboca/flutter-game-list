
import 'dart:convert';

List<Game> gameFromJson(String str) => List<Game>.from(json.decode(str).map((x) => Game.fromJson(x)));

String gameToJson(List<Game> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Game {
  Game({
    this.gameId,
    this.sport,
    this.gameDatetime,
    this.gameStatus,
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
    this.marketSpread,
  });

  int gameId;
  Sport sport;
  DateTime gameDatetime;
  GameStatus gameStatus;
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
  MarketSpread marketSpread;

  factory Game.fromJson(Map<String, dynamic> json) => Game(
    gameId: json["gameId"],
    sport: sportValues.map[json["sport"]],
    gameDatetime: DateTime.parse(json["gameDatetime"]),
    gameStatus: gameStatusValues.map[json["gameStatus"]],
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
    marketSpread: MarketSpread.fromJson(Map<String, dynamic>.from(json["marketSpread"])),
  );

  Map<String, dynamic> toJson() => {
    "gameId": gameId,
    "sport": sportValues.reverse[sport],
    "gameDatetime": gameDatetime.toIso8601String(),
    "gameStatus": gameStatusValues.reverse[gameStatus],
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
    "marketSpread": marketSpread.toJson(),
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

enum GameStatus { NOT_STARTED, POSTPONED }

final gameStatusValues = EnumValues({
  "not_started": GameStatus.NOT_STARTED,
  "postponed": GameStatus.POSTPONED
});

enum League { ENGLISH_PREMIER_LEAGUE, NHL, NBA, NFL }

final leagueValues = EnumValues({
  "ENGLISH_PREMIER_LEAGUE": League.ENGLISH_PREMIER_LEAGUE,
  "NBA": League.NBA,
  "NFL": League.NFL,
  "NHL": League.NHL
});

class MarketSpread {
  MarketSpread({
    this.spread,
  });

  String spread;

  factory MarketSpread.fromJson(Map<String, dynamic> json) => MarketSpread(
    spread: json["spread"] == null ? null : json["spread"],
  );

  Map<String, dynamic> toJson() => {
    "spread": spread == null ? null : spread,
  };
}

enum Sport { SOCCER, ICE_HOCKEY, BASKETBALL, FOOTBALL, ALL }

final sportValues = EnumValues({
  "BASKETBALL": Sport.BASKETBALL,
  "FOOTBALL": Sport.FOOTBALL,
  "ICE_HOCKEY": Sport.ICE_HOCKEY,
  "SOCCER": Sport.SOCCER
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
