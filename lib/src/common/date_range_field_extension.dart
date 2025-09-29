import 'package:flutter/material.dart';

extension DateRangeFieldX on DateTimeRange {
  String get text => '${formatDate(start)} - ${formatDate(end)}, ${start.year}';

  String formatDate(DateTime date) =>
      "${_getMonthAbbreviation(date.month)} ${date.day}";

  String _getMonthAbbreviation(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return months[month - 1];
  }
}
