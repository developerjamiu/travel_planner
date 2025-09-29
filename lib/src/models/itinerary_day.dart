import 'package:travel_planner/src/models/schedule_item.dart';

class ItineraryDay {
  final int dayNumber;
  final String date;
  final String theme;
  final List<ScheduleItem> schedule;

  ItineraryDay({
    required this.dayNumber,
    required this.date,
    required this.theme,
    required this.schedule,
  });

  factory ItineraryDay.fromJson(Map<String, dynamic> json) => ItineraryDay(
    dayNumber: json['day_number'],
    date: json['date'],
    theme: json['theme_of_the_day'],
    schedule: (json['schedule'] as List)
        .map((i) => ScheduleItem.fromJson(i))
        .toList(),
  );
}
