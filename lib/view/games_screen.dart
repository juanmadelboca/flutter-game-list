import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wagr_challenge/constant/colors.dart';
import 'package:wagr_challenge/enum/sport.dart';
import 'package:wagr_challenge/model/date_filter.dart';
import 'package:wagr_challenge/model/game.dart';
import 'package:wagr_challenge/model/sport_item.dart';
import 'package:wagr_challenge/repository/games.dart';
import 'package:wagr_challenge/util/date.dart';
import 'package:wagr_challenge/widgets/filter_tab.dart';
import 'package:wagr_challenge/widgets/game_card.dart';

class GamesScreen extends StatefulHookWidget {
  static const String routeName = '/GamesScreen';

  @override
  _GamesScreenState createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  int _selected = 0;
  ItemScrollController scrollController = ItemScrollController();
  Sport sportFilter = Sport.ALL;
  ItemPositionsListener itemPositionsListener;
  bool disableScrollNotifier = false;

  @override
  void initState() {
    itemPositionsListener = ItemPositionsListener.create();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GamesRepository gamesRepository = Provider.of(context);
    final future = useMemoized(() => gamesRepository.getGames());

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Object>(
          future: future,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black12,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      wagrColor,
                    ),
                  ),
                ),
              );
            List<Game> games = snapshot.data;
            if (games.isEmpty)
              return Container(
                child: Center(
                  child: Text(
                    'Ups there are no games available',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );

            List<DateFilter> filters = _getFilterList(games.first.gameDatetime);
            List<Game> filteredGames = games;
            if (sportFilter != Sport.ALL) {
              filteredGames = games.where((element) => (element.sport == sportFilter)).toList();
            }
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Games',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: whiteCard,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: DropdownButton<Sport>(
                                  value: sportFilter,
                                  underline: SizedBox(),
                                  iconSize: 30,
                                  onChanged: (Sport newValue) {
                                    setState(() {
                                      sportFilter = newValue;
                                      _selected = 0;
                                    });
                                  },
                                  items: Sport.values.map((Sport sport) {
                                    SportItem sportItem = _getSportItem(sport);
                                    return DropdownMenuItem<Sport>(
                                        value: sport,
                                        child: Row(
                                          children: [
                                            Icon(sportItem.icon),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(sportItem.displayName),
                                          ],
                                        ));
                                  }).toList()),
                            ),
                          )
                        ],
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
                    itemCount: filters?.length ?? 0,
                    itemBuilder: (context, index) {
                      return FilterTab(
                        selected: index == _selected,
                        displayName: filters[index].displayName,
                        onTap: () async {
                          int scrollIndex = filteredGames
                              .indexWhere((element) => compareGameDate(element.gameDatetime, filters[index].dateTime));
                          if (scrollIndex < 0) {
                            Fluttertoast.showToast(
                                msg: "There are no games for this date",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: whiteCard,
                                textColor: Colors.black,
                                fontSize: 18.0);
                            return;
                          } else {
                            setState(() {
                              _selected = index;
                            });
                          }
                          disableScrollNotifier = true;
                          await scrollController.scrollTo(index: scrollIndex, duration: Duration(milliseconds: 300));
                          disableScrollNotifier = false;
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  child: NotificationListener<ScrollUpdateNotification>(
                    child: ScrollablePositionedList.builder(
                        itemScrollController: scrollController,
                        itemPositionsListener: itemPositionsListener,
                        itemCount: filteredGames?.length ?? 0,
                        itemBuilder: (context, index) {
                          bool isFirstItem = (index == 0 ||
                              !compareGameDate(
                                  filteredGames[index].gameDatetime, filteredGames[index - 1].gameDatetime));
                          return Column(
                            children: [
                              if (isFirstItem)
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                                  child: Container(
                                    child: Text(
                                      filters
                                          .firstWhere((element) =>
                                              compareGameDate(element.dateTime, filteredGames[index].gameDatetime))
                                          .displayName,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                                    ),
                                    width: double.maxFinite,
                                  ),
                                ),
                              GameCard(filteredGames[index]),
                            ],
                          );
                        }),
                    onNotification: (notification) {
                      if (disableScrollNotifier) return false;
                      int firstVisibleItem = itemPositionsListener.itemPositions.value.first.index;
                      Game firstVisibleGame = filteredGames[firstVisibleItem];
                      int selected = filters
                          .indexWhere((filter) => compareGameDate(firstVisibleGame.gameDatetime, filter.dateTime));
                      if (selected >= 0 && _selected != selected) {
                        setState(() {
                          _selected = selected;
                        });
                      }
                      return true;
                    },
                  ),
                )
              ],
            );
          }),
    );
  }

  List<DateFilter> _getFilterList(DateTime dateTime) {
    List<DateFilter> filters = List<DateFilter>();
    final now = dateTime;
    filters.add(DateFilter(now, displayName: 'Today'));
    filters.add(DateFilter(DateTime(now.year, now.month, now.day + 1), displayName: 'Tomorrow'));
    for (int i = 2; i < 8; i++) {
      final date = DateTime(now.year, now.month, now.day + i);
      filters.add(DateFilter(date));
    }
    return filters;
  }

  SportItem _getSportItem(Sport sport) {
    switch (sport) {
      case Sport.SOCCER:
        return SportItem(Icons.sports_soccer, 'Soccer');
      case Sport.FOOTBALL:
        return SportItem(Icons.sports_football_outlined, 'Football');
      case Sport.BASKETBALL:
        return SportItem(Icons.sports_basketball, 'Basketball');
      case Sport.ICE_HOCKEY:
        return SportItem(Icons.sports_hockey, 'Ice Hockey');
      default:
        return SportItem(Icons.sports_handball, 'All Sports');
    }
  }
}
