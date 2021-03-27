import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:wagr_challenge/main.dart';
import 'package:wagr_challenge/model/game.dart';
import 'dart:async';

class GamesRepository {
  final cloudFunctionsTimeout = 60;

  Future<List<Game>> getGames() async {
    //final HttpsCallableResult result = await cloudFunction('code-challenge-mobile-app-games');
    //return result.data.map((e) => Game.fromJson(e)).where((e) => e != null).toList();

    String data = await DefaultAssetBundle.of(globalContext).loadString('assets/response.json');
    final result = json.decode(data);
    return result.map<Game>((e) => Game.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future cloudFunction(String name, {Map<String, dynamic> params}) async {
    final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(name,
        options: HttpsCallableOptions(
            timeout: Duration(seconds: cloudFunctionsTimeout)));
    return await callable.call(params ?? Map<String, dynamic>());
  }
}
