import 'package:travel_planner/src/models/itinerary_day.dart';

abstract interface class ItineraryService {
  Future<List<ItineraryDay>> generateItinerary({
    required String city,
    required DateTime startDate,
    required DateTime endDate,
    required String vibe,
    required String budget,
    required String pace,
  });
}
