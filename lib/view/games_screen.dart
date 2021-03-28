import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wagr_challenge/model/date_filter.dart';
import 'package:wagr_challenge/model/game.dart';
import 'package:wagr_challenge/repository/games.dart';
import 'package:wagr_challenge/util/date.dart';
import 'package:wagr_challenge/widgets/filter_tab.dart';
import 'package:wagr_challenge/widgets/game_card.dart';

class GamesScreen extends StatefulWidget {
  @override
  _GamesScreenState createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  int selected = 0;
  ItemScrollController scrollController = ItemScrollController();
  List<DateFilter> _filters;

  @override
  Widget build(BuildContext context) {
    GamesRepository gamesRepository = Provider.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Object>(
          future: gamesRepository.getGames(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              );
            final List<Game> games = snapshot.data;
            _filters = _getFilterList(games.first.gameDatetime);
            return Column(
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
                    itemCount: _filters?.length ?? 0,
                    itemBuilder: (context, index) {
                      return FilterTab(
                        selected: index == selected,
                        displayName: _filters[index].displayName,
                        onTap: () {
                          setState(() {
                            selected = index;
                          });
                          int scrollIndex = games.indexWhere(
                              (element) => compareGameDate(element.gameDatetime, _filters[index].dateTime));
                          scrollController.scrollTo(index: scrollIndex, duration: Duration(milliseconds: 800));
                        },
                      );
                    },
                  ),
                ),
                games != null
                    ? Expanded(
                        child: ScrollablePositionedList.builder(
                            itemScrollController: scrollController,
                            itemCount: games?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  if (index == 0 ||
                                      index == games.length ||
                                      !compareGameDate(games[index].gameDatetime, games[index - 1].gameDatetime))
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                                      child: Container(
                                        child: Text(
                                          _filters
                                              .firstWhere((element) =>
                                                  compareGameDate(element.dateTime, games[index].gameDatetime))
                                              .displayName,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                                        ),
                                        width: double.maxFinite,
                                      ),
                                    ),
                                  GameCard(games[index]),
                                ],
                              );
                            }),
                      )
                    : Container(child: Center(child: Text('Error')))
              ],
            );
          }),
    );
  }

  List<DateFilter> _getFilterList(DateTime dateTime) {
    List<DateFilter> filters = List<DateFilter>();
    final now = dateTime;
    filters.add(DateFilter(now, 'Today'));
    filters.add(DateFilter(DateTime(now.year, now.month, now.day + 1), 'Tomorrow'));
    for (int i = 2; i < 8; i++) {
      final date = DateTime(now.year, now.month, now.day + i);
      filters.add(DateFilter(date, _getFilterName(date)));
    }
    return filters;
  }

  String _getFilterName(DateTime dateTime) {
    String month;
    switch (dateTime.month) {
      case 1:
        month = 'Jan';
        break;
      case 2:
        month = 'Feb';
        break;
      case 3:
        month = 'Mar';
        break;
      case 4:
        month = 'Apr';
        break;
      case 5:
        month = 'May';
        break;
      case 6:
        month = 'Jun';
        break;
      case 7:
        month = 'Jul';
        break;
      case 8:
        month = 'Aug';
        break;
      case 9:
        month = 'Sep';
        break;
      case 10:
        month = 'Oct';
        break;
      case 11:
        month = 'Nov';
        break;
      case 12:
        month = 'Dec';
        break;
    }
    return month + ' ' + dateTime.day.toString();
  }
}
