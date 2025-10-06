import 'dart:convert';

import 'package:travel_planner/src/models/itinerary_day.dart';
import 'package:travel_planner/src/services/itinerary_service.dart';
import 'package:firebase_ai/firebase_ai.dart';

class GeminiItineraryService implements ItineraryService {
  @override
  Future<List<ItineraryDay>> generateItinerary({
    required String city,
    required DateTime startDate,
    required DateTime endDate,
    required String vibe,
    required String budget,
    required String pace,
  }) async {
    final model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-2.5-flash',
    );

    final prompt = _buildPrompt(
      city: city,
      startDate: startDate,
      endDate: endDate,
      vibe: vibe,
      budget: budget,
      pace: pace,
    );

    final generationConfig = GenerationConfig(
      temperature: 0.3,
      responseMimeType: 'application/json',
    );

    final response = await model.generateContent([
      Content.text(prompt),
    ], generationConfig: generationConfig);

    if (response.text == null) {
      throw Exception('Failed to generate itinerary: No response text.');
    }

    final decodedJson = jsonDecode(response.text!) as Map<String, dynamic>;
    final List<dynamic> itineraryJson = decodedJson['itinerary'];

    return itineraryJson
        .map((dayJson) => ItineraryDay.fromJson(dayJson))
        .toList();
  }

  // Inside the GeminiItineraryService class...

  String _buildPrompt({
    required String city,
    required DateTime startDate,
    required DateTime endDate,
    required String vibe,
    required String budget,
    required String pace,
  }) {
    // This is the prompt from Google AI Studio.
    return '''
     You are a world-class travel agent and expert local guide, possessing deep knowledge of cities across the globe. Your name is "Gemini Guide."

     Your task is to create a personalized, detailed, and logistically optimized itinerary based on the user profile and rules provided below. You must draw upon your specific knowledge of the requested city to create an authentic and practical plan.

     ### USER PROFILE:

     - **Destination City:** $city
     - **Travel Dates:** ${startDate.toIso8601String()} to ${endDate.toIso8601String()}
     - **Traveler Vibe:** $vibe
     - **Budget:** $budget
     - **Pace:** $pace

     ### CRITICAL RULES:

     1.  **LOGISTICAL OPTIMIZATION:** This is the most important rule. Group all activities for a given day within the same geographical area or neighborhood to minimize travel time. Account for typical traffic patterns in the specified city.
     2.  **REALISTIC PACING:** The user has requested a specific pace. You MUST build the itinerary to match it, incorporating breaks for meals and rest.
     3.  **BE HYPER-SPECIFIC & ACTIONABLE:** This is non-negotiable.
         - You MUST provide the specific, well-known names of establishments (e.g., "Bower's Memorial Tower", "Amala Skye"), not generic descriptions like "a historical site."
         - For each location, you MUST provide visitor-friendly context. Is it a walk-in spot? Is there an entry fee? Is it a public space? This helps the tourist understand how to approach the location.
     4.  **LOCAL FLAVOR:** Prioritize authentic, local experiences that are highly rated by locals, not just tourists. Avoid generic, international chains.
     5.  **PRACTICALITY:** Suggest activities that are likely to be open on the specified days and times.
     6.  **JSON OUTPUT ONLY:** Your entire response MUST be a single, valid JSON object. Do not include any explanatory text, comments, or markdown formatting before or after the JSON block.

     ### REQUIRED JSON FORMAT:

     The root of the object must contain a single key, "itinerary", which is an array of "day" objects. Follow this schema precisely:

     ```json
     {
       "itinerary": [
         {
           "day_number": 1,
           "date": "2025-10-11",
           "theme_of_the_day": "A short, creative theme for the day's activities.",
           "schedule": [
             {
               "start_time": "HH:MM",
               "end_time": "HH:MM",
               "activity_type": "Food | Activity | Rest | Travel",
               "title": "The specific, official name of the place, e.g., 'University of Ibadan Zoological Garden'.",
               "description": "A one or two-sentence description explaining the activity and why it fits the traveler's vibe. If the title is generic (e.g., 'Lunch'), this MUST contain a specific named suggestion.",
               "address_or_landmark": "A specific, searchable address or well-known landmark for Google Maps.",
               "visitor_info": "Crucial tips for a first-time visitor. E.g., 'Small entry fee required', 'Best visited in the morning', 'Famous local spot, expect a queue', 'Wear comfortable walking shoes'."
             }
           ]
         }
       ]
     } d
  ''';
  }
}
