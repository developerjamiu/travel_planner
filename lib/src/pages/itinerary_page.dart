import 'package:flutter/material.dart';
import 'package:travel_planner/src/models/itinerary_day.dart';
import 'package:travel_planner/src/widgets/timeline_tile.dart';

class ItineraryPage extends StatelessWidget {
  final List<ItineraryDay> days;

  const ItineraryPage({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: days.length,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Your Itinerary'),
          bottom: TabBar(
            isScrollable: days.length > 4,
            tabs: days.map((day) => Tab(text: 'Day ${day.dayNumber}')).toList(),
            indicatorColor: Theme.of(context).colorScheme.primary,
            indicatorWeight: 3,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: TabBarView(
          children: days
              .map(
                (day) => ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemCount: day.schedule.length,
                  itemBuilder: (context, index) {
                    final item = day.schedule[index];
                    return TimelineTile(
                      item: item,
                      isFirst: index == 0,
                      isLast: index == day.schedule.length - 1,
                    );
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
