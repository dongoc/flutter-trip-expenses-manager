class Trip {
  final int id;
  final String title;
  final DateTime startDate;
  final DateTime? endDate;

  Trip({
    required this.id,
    required this.title,
    required this.startDate,
    this.endDate,
  });

  int getTripPeriod() {
    return endDate != null ? endDate!.difference(startDate).inDays + 1 : 1;
  }
}
