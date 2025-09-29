import 'package:flutter/material.dart';
import 'package:travel_planner/src/models/schedule_item.dart';

class TimelineTile extends StatelessWidget {
  final ScheduleItem item;
  final bool isFirst;
  final bool isLast;

  const TimelineTile({
    super.key,
    required this.item,
    this.isFirst = false,
    this.isLast = false,
  });

  IconData _getIconForActivity(String activityType) {
    switch (activityType.toLowerCase()) {
      case 'food':
        return Icons.restaurant_outlined;
      case 'activity':
        return Icons.attractions_outlined;
      case 'rest':
        return Icons.coffee_outlined;
      case 'travel':
        return Icons.directions_car_outlined;
      case 'buffer':
        return Icons.timer_outlined;
      default:
        return Icons.explore_outlined;
    }
  }

  Color _getColorForActivity(String activityType) {
    switch (activityType.toLowerCase()) {
      case 'food':
        return const Color(0xFFEF4444);
      case 'activity':
        return const Color(0xFF10B981);
      case 'rest':
        return const Color(0xFF6366F1);
      case 'travel':
        return const Color(0xFFF59E0B);
      case 'buffer':
        return const Color(0xFFA855F7);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final activityColor = _getColorForActivity(item.activityType);
    const double iconPadding = 8;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                item.startTime,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 2,
                  height: 6,
                  color: isFirst ? Colors.transparent : Colors.white24,
                ),
                Container(
                  padding: const EdgeInsets.all(iconPadding),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: activityColor,
                  ),
                  child: Icon(
                    _getIconForActivity(item.activityType),
                    size: 18,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: isLast ? Colors.transparent : Colors.white24,
                  ),
                ),
              ],
            ),
            SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.description,
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 12),
                        const Divider(height: 1, color: Colors.white12),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: Colors.white70,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item.address,
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(13),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.lightbulb_outline,
                                size: 16,
                                color: Color(0xFFF59E0B),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  item.visitorInfo,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white.withAlpha(230),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
