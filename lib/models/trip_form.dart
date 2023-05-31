class TripForm {
  final String title;
  final DateTime startDate;
  final DateTime? endDate;

  TripForm({
    required this.title,
    required this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
    };
  }
}
