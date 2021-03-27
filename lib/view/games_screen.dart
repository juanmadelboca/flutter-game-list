import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:wagr_challenge/model/game.dart';
import 'package:wagr_challenge/repository/games.dart';
import 'package:wagr_challenge/util/color_parser.dart';
import 'package:wagr_challenge/widgets/game_card.dart';

class GamesScreen extends StatefulHookWidget {
  @override
  _GamesScreenState createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  List<String> days = [
    'Today',
    'Tomorrow',
    '29/3',
    '30/3',
    '31/3',
    '1/4',
    '2/4'
  ];
  int selected = 0;
  ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    useMemoized(() {
      scrollController = ScrollController()..addListener(()=> print('scroll'));
    });
    GamesRepository gamesRepository = Provider.of(context);
    final future = useMemoized(() => gamesRepository.getGames());
    final snapshotGames = useFuture(future);
    bool loadingGames =
        snapshotGames.connectionState == ConnectionState.waiting;
    List<Game> games = snapshotGames.data;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 90,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: double.infinity,
                child: Text(
                  'Games',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 30,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: days.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 0.5, color: Colors.black.withAlpha(80)))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 5.0,
                                    color: selected == index
                                        ? Colors.black.withAlpha(200)
                                        : Colors.transparent))),
                        child: Text(
                          days[index],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          loadingGames
              ? Center(
                  child: SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                    ),
                  ),
                )
              : games != null
                  ? ListView.builder(
                      controller: scrollController,
                      itemCount: games.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GameCard(games[index]);
                      })
                  : Container(child: Center(child: Text('Error')))
        ],
      ),
    );
  }
}
