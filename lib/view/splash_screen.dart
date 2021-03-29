import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wagr_challenge/constant/colors.dart';
import 'package:wagr_challenge/view/games_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _scale = 1.0;
  Timer _timer;
  int count = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 800), (Timer timer){
      setState(() {
        _scale = (0.5 * (count % 2)) + 0.5;
      });
      if(count >= 3){
        _timer.cancel();
        Navigator.of(context).pushReplacementNamed(GamesScreen.routeName);
      }
        count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: wagrColor,
        body: Stack(
          children: <Widget>[
            Center(
              child: AnimatedContainer(
                  height: 100 * _scale,
                  width: 260 * _scale,
                  duration: Duration(milliseconds: 1000),
                  child: Image.asset('assets/wagr_logo.jpg')),
            )
          ],
        ));
  }
}