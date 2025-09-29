import 'dart:convert';

import 'package:travel_planner/src/models/itinerary_day.dart';
import 'package:travel_planner/src/services/itinerary_service.dart';

class MockItineraryService implements ItineraryService {
  @override
  Future<List<ItineraryDay>> generateItinerary({
    required String city,
    required DateTime startDate,
    required DateTime endDate,
    required String vibe,
    required String budget,
    required String pace,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    final decodedJson = jsonDecode(mockIbadanResponse);
    final List<dynamic> itineraryJson = decodedJson['itinerary'];
    final List<ItineraryDay> itineraryDays = itineraryJson
        .map((day) => ItineraryDay.fromJson(day))
        .toList();

    return itineraryDays;
  }
}

const String mockIbadanResponse = """
{
  "itinerary": [
    {
      "day_number": 1,
      "date": "2025-10-11",
      "theme_of_the_day": "Historic Hearts & University Greens",
      "schedule": [
        { "start_time": "10:00", "end_time": "12:00", "activity_type": "Activity", "title": "University of Ibadan Zoological Garden", "description": "Start your day with a relaxed walk through one of Nigeria's oldest zoos, located within the beautiful University of Ibadan campus.", "address_or_landmark": "University of Ibadan, Oyo Road, Ibadan", "visitor_info": "Small entry fee required. Best visited in the morning when animals are most active. Wear comfortable walking shoes." },
        { "start_time": "12:00", "end_time": "12:30", "activity_type": "Travel", "title": "Travel to Bodija", "description": "A short ride from the university to the Bodija area for a truly local lunch experience.", "address_or_landmark": "Bodija, Ibadan", "visitor_info": "Use a ride-sharing app or a local taxi." },
        { "start_time": "12:30", "end_time": "14:00", "activity_type": "Food", "title": "Authentic Amala at Amala Skye", "description": "No trip to Ibadan is complete without trying Amala. Amala Skye is a legendary local canteen-style restaurant famous for its delicious and budget-friendly food.", "address_or_landmark": "Amala Skye, near Bodija Market, Ibadan", "visitor_info": "Very popular local spot, expect a queue. It's a casual, no-frills experience. Be ready to point at what you want!" },
        { "start_time": "14:00", "end_time": "14:30", "activity_type": "Buffer", "title": "Post-Lunch Buffer", "description": "A short buffer to account for any delays or just to relax after a hearty meal.", "address_or_landmark": "Bodija Area", "visitor_info": "A good time to digest and plan the next move." },
        { "start_time": "14:30", "end_time": "16:00", "activity_type": "Activity", "title": "Cocoa House & Oodua Museum", "description": "Visit Cocoa House, once the tallest building in tropical Africa. Head to the top floor to visit the Oodua Museum for a dose of Yoruba history.", "address_or_landmark": "Cocoa House, Oba Adebimpe Rd, Dugbe, Ibadan", "visitor_info": "There's a fee to access the top floor/museum. The view from the top is one of the best in the city." }
      ]
    },
    {
      "day_number": 2,
      "date": "2025-10-12",
      "theme_of_the_day": "City Panoramas & Cultural Roots",
      "schedule": [
        { "start_time": "11:00", "end_time": "12:30", "activity_type": "Activity", "title": "Bower's Memorial Tower", "description": "Climb the historic Bower's Tower for a stunning 360-degree panoramic view of the 'city of seven hills'.", "address_or_landmark": "Oke Are, Ibadan", "visitor_info": "There are about 60 steps to the top. A small fee is collected by the local caretaker. The view is worth the climb." },
        { "start_time": "12:30", "end_time": "13:00", "activity_type": "Travel", "title": "Journey to Agodi Gardens", "description": "Head from the hills of Bower's Tower to the green expanse of Agodi Gardens.", "address_or_landmark": "Agodi Gardens, Ibadan", "visitor_info": "The gardens are a well-known landmark." },
        { "start_time": "13:00", "end_time": "15:00", "activity_type": "Activity", "title": "Relax at Agodi Gardens", "description": "Enjoy a peaceful afternoon at this large urban park. You can walk the grounds or simply relax by the lake.", "address_or_landmark": "Parliament Road, Agodi, Ibadan", "visitor_info": "Entry fee required. It's a family-friendly public space. You can find food and drink vendors inside." },
        { "start_time": "15:00", "end_time": "16:30", "activity_type": "Food", "title": "Late Lunch at a Garden Restaurant", "description": "Have a relaxed late lunch at one of the restaurants within or near Agodi Gardens.", "address_or_landmark": "Inside Agodi Gardens, Ibadan", "visitor_info": "Offers a mix of local and continental dishes in a serene setting." }
      ]
    },
    {
      "day_number": 3,
      "date": "2025-10-13",
      "theme_of_the_day": "Markets and Modernity",
      "schedule": [
        { "start_time": "10:00", "end_time": "12:00", "activity_type": "Activity", "title": "Explore Oje Market", "description": "Dive into one of Ibadan's oldest and most vibrant traditional markets, famous for its Aso Ofi and Adire textiles.", "address_or_landmark": "Oje Market, Ibadan", "visitor_info": "Can be crowded. It's a great place for photography and to see local commerce in action. Be prepared to bargain." },
        { "start_time": "12:30", "end_time": "14:00", "activity_type": "Food", "title": "Lunch at Wimpy's", "description": "A throwback experience at one of Ibadan's oldest fast-food joints, known for its classic burgers and ice cream.", "address_or_landmark": "Wimpy's Restaurant, Dugbe, Ibadan", "visitor_info": "A nostalgic spot for many locals. Offers a simple, casual dining experience." },
        { "start_time": "14:30", "end_time": "16:30", "activity_type": "Activity", "title": "Afternoon at The Palms Shopping Mall", "description": "Experience modern Ibadan with a visit to The Palms mall for some shopping or to catch a movie at the cinema.", "address_or_landmark": "The Palms Shopping Mall, Ring Road, Ibadan", "visitor_info": "A modern mall with local and international brands, a food court, and a cinema." }
      ]
    },
    {
      "day_number": 4,
      "date": "2025-10-14",
      "theme_of_the_day": "Art & Relaxation",
      "schedule": [
        { "start_time": "11:00", "end_time": "13:00", "activity_type": "Activity", "title": "Visit Topfat Art Gallery", "description": "Discover contemporary and traditional Nigerian art at this well-regarded local gallery.", "address_or_landmark": "Topfat Art Gallery, off Awolowo Avenue, Bodija, Ibadan", "visitor_info": "Check their opening hours beforehand. A great place to see work from local artists." },
        { "start_time": "13:30", "end_time": "15:00", "activity_type": "Food", "title": "Lunch at Martha's Kitchen", "description": "Enjoy a tasty meal at this popular restaurant known for its wide variety of Nigerian dishes.", "address_or_landmark": "Martha's Kitchen, Bodija, Ibadan", "visitor_info": "A popular and reliable choice for a good quality local meal." },
        { "start_time": "15:30", "end_time": "17:00", "activity_type": "Rest", "title": "Relax at a Cafe", "description": "Spend a quiet afternoon reading or catching up on emails at a modern cafe.", "address_or_landmark": "Any modern cafe in the Bodija or Akobo area.", "visitor_info": "Many cafes in these areas offer good coffee and Wi-Fi." }
      ]
    },
    {
      "day_number": 5,
      "date": "2025-10-15",
      "theme_of_the_day": "A Final View",
      "schedule": [
        { "start_time": "10:00", "end_time": "11:30", "activity_type": "Activity", "title": "Revisit Cocoa House", "description": "Take one last look at the city from the top of Cocoa House, seeing the 'city of seven hills' in the morning light.", "address_or_landmark": "Cocoa House, Oba Adebimpe Rd, Dugbe, Ibadan", "visitor_info": "A great final photo opportunity." },
        { "start_time": "12:00", "end_time": "13:30", "activity_type": "Food", "title": "Farewell Lunch", "description": "Enjoy a final taste of Ibadan at a restaurant of your choice, perhaps trying something you missed earlier.", "address_or_landmark": "Dugbe or Ring Road area.", "visitor_info": "Many options available around the central business district." }
      ]
    }
  ]
}
""";
