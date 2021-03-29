import 'package:dio/dio.dart';
import 'package:wagr_challenge/model/game.dart';
import 'dart:async';

class GamesRepository {
  final cloudFunctionsTimeout = 60;

  Future<List<Game>> getGames() async {
    var response = await Dio().get('https://us-central1-wagr-develop.cloudfunctions.net/code-challenge-mobile-app-games');
    if(response.statusCode == 200) {
      return response.data.map<Game>((e) => Game.fromJson(Map<String, dynamic>.from(e))).toList();
    } else {
      return List<Game>();
    }
  }
}
