class ScheduleItem {
  final String startTime;
  final String endTime;
  final String activityType;
  final String title;
  final String description;
  final String address;
  final String visitorInfo;

  ScheduleItem({
    required this.startTime,
    required this.endTime,
    required this.activityType,
    required this.title,
    required this.description,
    required this.address,
    required this.visitorInfo,
  });

  factory ScheduleItem.fromJson(Map<String, dynamic> json) {
    return ScheduleItem(
      startTime: json['start_time'],
      endTime: json['end_time'],
      activityType: json['activity_type'],
      title: json['title'],
      description: json['description'],
      address: json['address_or_landmark'],
      visitorInfo: json['visitor_info'],
    );
  }
}
