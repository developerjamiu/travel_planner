import 'package:travel_planner/src/models/itinerary_day.dart';
import 'package:travel_planner/src/services/itinerary_service.dart';

class GeminiItineraryService implements ItineraryService {
  @override
  Future<List<ItineraryDay>> generateItinerary({
    required String city,
    required DateTime startDate,
    required DateTime endDate,
    required String vibe,
    required String budget,
    required String pace,
  }) {
    // TODO: implement generateItinerary
    throw UnimplementedError();
  }
}
