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
  final Color backgroundColor = Color(0xFFE8BD6F);
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    new Timer(Duration(milliseconds: 800),(){
      setState(() {
        _scale = 0.5;
      });
      new Timer(Duration(milliseconds: 800),(){
        setState(() {
          _scale = 0.9;
        });
        new Timer(Duration(milliseconds: 800),(){
          setState(() {
            _scale = 0.6;
          });
          new Timer(Duration(milliseconds: 800),(){
            Navigator.of(context).pushReplacementNamed(GamesScreen.routeName);
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
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