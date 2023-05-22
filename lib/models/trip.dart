class Trip {
  final String id, title;
  final DateTime startDate;
  final DateTime? endDate;

  Trip({
    required this.id,
    required this.title,
    required this.startDate,
    this.endDate,
  });
}
