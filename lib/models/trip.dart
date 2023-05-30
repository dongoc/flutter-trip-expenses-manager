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

  Trip.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        startDate = json['start_date'],
        endDate = json['end_date'];

  int getTripPeriod() {
    return endDate != null ? endDate!.difference(startDate).inDays + 1 : 1;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
    };
  }
}
