# Build an AI Travel Planner with Flutter and Firebase AI Logic

Learn to build a complete Flutter application that uses the Gemini model through the Firebase AI Logic SDK to generate personalized, dynamic travel itineraries.

Modern applications are moving beyond static data. Users expect intelligent, personalized experiences that adapt to their needs. Generative AI is the key to unlocking this next level of interactivity, but integrating it securely and efficiently can be a major challenge.

This guide will walk you through building a complete "AI Travel Planner" application. You'll start with a polished, pre-built UI and replace its mock data service with a live implementation that calls the Gemini AI model directly from your Flutter app using the Firebase AI Logic SDK. You'll learn how to securely manage API calls, engineer an effective prompt for structured JSON output, and parse that data into clean Dart objects.

**30 min read**

## Features Covered

- Configuring a Flutter app with Firebase.
- Using the `firebase_ai` SDK to call the Gemini model securely.
- Engineering a detailed prompt in Google AI Studio for structured JSON.
- Parsing a complex JSON response into typed Dart models.

## Prerequisites

- **A Firebase account and project**: [Create a project](https://console.firebase.google.com/) in the Firebase console.
- **Flutter SDK Installed**: [Install the Flutter SDK](https://docs.flutter.dev/get-started/install).
- **Firebase CLI Installed**: Install the Firebase CLI by running npm install -g firebase-tools.

## Step 1: Get the Starter Project

To focus on the AI integration, we'll begin with a starter project that has the complete UI and data models already built.

1. **Clone the project repository**:

   ```bash
   git clone git@github.com:developerjamiu/travel_planner.git
   cd travel_planner
   ```

2. **Checkout the `starter` branch**:

   ```bash
   git checkout starter
   ```

3. **Install dependencies**:

   ```bash
   flutter pub get
   ```

4. **Run the app**:

   Run the project on a simulator or device. You'll see the main form. Fill it out and tap "Generate Itinerary." The app will work, but it will return the same hard-coded mock data every time. Our goal is to replace this with a live, AI-powered response.

5. **Explore the code**

## Step 2: Configure Your Firebase Project

Next, you'll connect your Flutter application to your Firebase project and enable the necessary services.

1. **Create a Firebase Project**:

   If you haven't already, go to the [Firebase Console](https://console.firebase.google.com/) and create a new project.

2. **Enable the Firebase AI Logic API**:

   This is a critical step to allow your project to communicate with the Gemini API.

   - In the Firebase Console, with your project selected, navigate to the **Firebase AI Logic** page (you can find it in the "Build" menu in the left-hand sidebar).
   - Click **Get started**. This will launch a guided workflow.
   - When prompted to select a provider, choose the **Gemini Developer API**.
   - Follow the on-screen instructions. The console will automatically enable the necessary APIs for your project. This step ensures the error you encountered doesn't happen.

3. **Log in to the Firebase CLI**:

   ```bash
   firebase login
   ```

4. **Configure your app**:

   In the root of your Flutter project, run the FlutterFire configuration tool:

   ```bash
   flutterfire configure
   ```

   Follow the prompts, selecting the Firebase project you just created. This will automatically generate a `firebase_options.dart` file.

5. **Add the Firebase packages**:

   From your Flutter project directory, run the following command to install both the core and AI plugins:

   ```bash
   flutter pub add firebase_core firebase_ai
   ```

6. **Initialize Firebase in your app**:

   Open your `lib/main.dart` file. You need to ensure Firebase is initialized before the app runs. The starter project should already have this, but you can verify it looks like this:

   ```dart
   import 'package:firebase_core/firebase_core.dart';
   import 'firebase_options.dart';
   // ... other imports for your app

   void main() async {
     // This is required to ensure native code can be called before runApp
     WidgetsFlutterBinding.ensureInitialized();

     // Initialize Firebase
     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

     runApp(const TravelPlannerApp());
   }
   ```

## Step 3: Engineer the Prompt in Google AI Studio

Before writing any AI code, we must perfect our instruction—the prompt. A well-designed prompt is the difference between getting a random paragraph and getting clean, structured data that your app can actually use.

1. **Navigate to Google AI Studio**:

   Open [aistudio.google.com](aistudio.google.com) in your browser.

2. **Create a New Prompt**:

   Start a new "Freeform prompt."

3. **Design and Test Your Prompt**:

   Copy and paste the prompt below into the editor. This prompt is carefully engineered to give the AI a specific role ("Gemini Guide"), a set of critical rules, and a strict JSON schema for its response.

   ````md
   You are a world-class travel agent and expert local guide, possessing deep knowledge of cities across the globe. Your name is "Gemini Guide."

   Your task is to create a personalized, detailed, and logistically optimized itinerary based on the user profile and rules provided below. You must draw upon your specific knowledge of the requested city to create an authentic and practical plan.

   ### USER PROFILE:

   - **Destination City:** {{city}}
   - **Travel Dates:** {{startDate}} - {{endDate}}
   - **Traveler Vibe:** {{vibe}}
   - **Budget:** {{budget}}
   - **Pace:** {{pace}}

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
   }
   ```
   ````

   Experiment by filling in the `{{VARIABLES}}` and running the prompt. You'll see that it consistently returns a valid JSON object. This is the exact prompt we will use in our Flutter code.

## Step 4: Implement the `GeminiItineraryService`

Now for the main event. We will build our new service class that calls the Gemini API and parses the response.

1. **Create the service file**:

   In your project, navigate to `lib/src/services/` and create a new file named `gemini_itinerary_service.dart`.

2. **Define the class structure**:

   Add the following boilerplate code. This creates our class and ensures it conforms to the `ItineraryService` interface.

   ```dart
   import 'dart:convert';
   import 'package:firebase_ai/firebase_ai.dart';
   import 'package:travel_planner/src/models/itinerary_day.dart';
   import 'package:travel_planner/src/services/itinerary_service.dart';

   class GeminiItineraryService implements ItineraryService {
     // We will add a helper method and the main method here.
   }
   ```

3. **Create the `_buildPrompt` Helper Method**:

   Inside your `GeminiItineraryService` class, create a private helper method that takes all the user's preferences and returns the fully constructed prompt string. This keeps your main logic clean.

   ````dart
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
   ````

4. **Implement the `generateItinerary` Method**:

   Now, implement the main method. It will initialize the model, call your new `_buildPrompt` method, execute the AI call, and parse the response.

   ```dart
   // Continuing inside the GeminiItineraryService class...

   @override
   Future<List<ItineraryDay>> generateItinerary({
     required String city,
     required DateTime startDate,
     required DateTime endDate,
     required String vibe,
     required String budget,
     required String pace,
   }) async {
     // Initialize the model
     final model = FirebaseAI.googleAI().generativeModel(
       model: 'gemini-2.5-flash',
     );

     // Build the prompt using our helper method
     final prompt = _buildPrompt(
       city: city,
       startDate: startDate,
       endDate: endDate,
       vibe: vibe,
       budget: budget,
       pace: pace,
     );

     // Call the AI and parse the response
     final generationConfig = GenerationConfig(
       temperature: 0.3,
       responseMimeType: 'application/json',
     );

     final response = await model.generateContent(
       [Content.text(prompt)],
       generationConfig: generationConfig,
     );

     if (response.text == null) {
       throw Exception('Failed to generate itinerary: No response text.');
     }

     final decodedJson = jsonDecode(response.text!) as Map<String, dynamic>;
     final List<dynamic> itineraryJson = decodedJson['itinerary'];

     return itineraryJson
       .map((dayJson) => ItineraryDay.fromJson(dayJson))
       .toList();
     }
   ```

## Step 5: Activate the Live AI Service

The final step is to tell our app to use the new `GeminiItineraryService`.

1. Open `lib/src/pages/home_page.dart`.
2. Find the `_itineraryService` **variable** near the top of the `_HomePageState` class.
3. **Swap the implementation**:

   ```dart
   // Before:
   // final ItineraryService _itineraryService = MockItineraryService();

   // After:
   final ItineraryService _itineraryService = GeminiItineraryService();
   ```

## Step 6: What's Next? (Going Beyond the Basics)

Congratulations! You've built a fully functional, AI-powered feature. The skills you've learned; prompt engineering, secure API calls, and JSON parsing are the foundation for almost any generative AI application. Here are some other topics you can explore next to make your app even more powerful.

- **Mastering Structured Output**:
  In this codelab, we used a detailed prompt and the `responseMimeType: 'application/json'` to get structured data. This is a powerful feature that ensures the model's output is always valid JSON that your app can reliably parse. For even more complex data structures, you can provide the model with a full JSON schema in your prompt to enforce an even stricter output format.

- **Function Calling: Giving Your AI Superpowers**:
  Function calling allows the model to use external tools and your own app's functions. Imagine you want your itinerary to include real-time weather information. You could define a `getWeather(city, date)` function in your Dart code and make the AI aware of it. The model could then say, "To give the best recommendation, I need to know the weather. Please call the `getWeather` function for Lagos on October 11th." Your app would execute the function, return the weather data to the model, and the model would then use that information to suggest either an outdoor market or an indoor museum. This turns your AI from a content generator into an intelligent agent that can interact with the world.

- **Streaming Responses for a Faster UI**:
  For a more responsive user experience, you can use the `model.generateContentStream()` method. Instead of waiting for the entire itinerary to be generated, you can listen to a stream of data and display each day's plan the moment it's ready. This makes the app feel significantly faster and more interactive to the user.

- **Implement Caching**:
  To save on API costs and improve speed for repeated requests, consider caching generated itineraries. You could use a simple package like **hive** for local device caching or a cloud database like Firestore to store popular itineraries that can be served instantly to other users.
