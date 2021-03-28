bool compareGameDate(DateTime gameDate, DateTime filterDate) {
  return gameDate.year == filterDate.year && gameDate.month == filterDate.month
      && gameDate.day == filterDate.day;
}