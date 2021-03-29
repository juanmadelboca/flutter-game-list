import 'package:confetti/confetti.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:wagr_challenge/constant/colors.dart';
import 'dart:math';
import 'package:wagr_challenge/util/color_parser.dart';
import 'package:wagr_challenge/widgets/team_flag.dart';

class ConfirmationScreenParams {
  final String primaryColor;
  final String secondaryColor;
  final String teamName;
  final String spread;

  ConfirmationScreenParams({this.spread, this.primaryColor, this.secondaryColor, this.teamName});
}

class ConfirmationScreen extends StatefulWidget {
  static const String routeName = '/ConfirmationScreen';

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  ConfirmationScreenParams _params;

  ConfettiController _controllerPrimary;
  ConfettiController _controllerSecondary;

  @override
  void initState() {
    _controllerPrimary = ConfettiController(duration: const Duration(seconds: 5));
    _controllerSecondary = ConfettiController(duration: const Duration(seconds: 5));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controllerPrimary.play();
      _controllerSecondary.play();
    });
    super.initState();
  }

  _initParams() {
    if (_params != null) return;
    _params = ModalRoute.of(context).settings.arguments;
  }

  @override
  Widget build(BuildContext context) {
    _initParams();
    return Scaffold(
      backgroundColor: whiteCard,
      body: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 30, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () => Navigator.of(context).pop()),
                        Text(
                          'Congratulations!',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(width: 200, height: 200, child: FlareActor('assets/win.flr', animation: "coins_out")),
                        Text(
                          'Congratulations you have put your bet! Let\'s hope the best!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 3,
                        color: whiteCard,
                        child: Container(
                          height: 80,
                          child: Row(
                            children: [
                              TeamFlag(
                                homeTeam: true,
                                primaryColor: _params.primaryColor,
                                secondaryColor: _params.secondaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                _params.teamName,
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                              )),
                              Text(
                                _params.spread,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black38),
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
          Align(
            alignment: Alignment.centerRight,
            child: ConfettiWidget(
              confettiController: _controllerPrimary,
              blastDirection: pi * 11 / 8,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.05,
              shouldLoop: false,
              colors: [
                fromHex(_params.primaryColor),
              ], // manually specify the colors to be used
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ConfettiWidget(
              confettiController: _controllerSecondary,
              blastDirection: pi * 13 / 8,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.05,
              shouldLoop: false,
              colors: [fromHex(_params.secondaryColor)], // manually specify the colors to be used
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controllerPrimary.dispose();
    _controllerSecondary.dispose();
    super.dispose();
  }
}
