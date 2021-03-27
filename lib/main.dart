import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'repository/games.dart';
import 'view/games_screen.dart';

void main() {
  runApp(MyApp());
}
BuildContext globalContext;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    globalContext = context;
    return Provider(
      create: (context) => GamesRepository(),
      child: MaterialApp(
        title: 'Wagr Challenge',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: GamesScreen(),
      ),
    );
  }
}
