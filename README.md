# AI Travel Planner with Flutter & Firebase

This repository contains the source code for the "AI Travel Planner," a sample Flutter application built to demonstrate the power of the Firebase AI Logic SDK with the Gemini model.

The app allows users to generate a personalized, day-by-day travel itinerary by providing a destination, travel dates, and personal preferences like travel style, budget, and desired pace. It serves as the basis for a hands-on codelab designed to teach developers how to integrate generative AI into their own Flutter applications.

## Features

- **Personalized Itineraries**: Generates unique travel plans based on user input.
- **Secure AI Calls**: Uses the Firebase AI Logic SDK for Flutter (`firebase_ai`) to securely call the Gemini model directly from the client-side app without exposing API keys.
- **Clean Architecture**: The project is structured with a clear separation between the UI (pages/widgets), business logic (services), and data structures (models).
- **Modern UI**: A modern user interface featuring a timeline view to display the generated schedule.

## Technology Stack

- **Framework**: Flutter
- **AI Integration**: Firebase AI Logic SDK (`firebase_ai`)
- **AI Model**: Google Gemini (`gemini-2.5-flash`)

## Repository Structure

This repository is structured to support a codelab format:

- `starter` branch: This is the starting point for the codelab. It contains the complete UI and a mock data service (`MockItineraryService`). You will work from this branch.
- `main` branch: This branch contains the final, completed code with the `GeminiItineraryService` fully implemented. You can use it as a reference.

## Getting Started

To run the starter project on your local machine, follow these steps:

1. **Clone the repository**:

   ```bash
   git clone git@github.com:developerjamiu/travel_planner.git
   cd travel_planner
   ```

2. **Checkout the `starter` branch**:

   ```bash
   git checkout starter
   ```

3. **Configure Firebase**:

   Follow the instructions in the codelab to connect the app to your own Firebase project using the FlutterFire CLI.

4. **Install dependencies and run**:

   ```bash
   flutter pub get
   flutter run
   ```

## Codelab: Build This App From Scratch

Ready to dive in and build the AI-powered features yourself?

We have prepared a detailed, step-by-step guide that will walk you through the entire process of replacing the mock data service with a live integration to the Gemini API using the Firebase AI Logic SDK.

➡️ [Start the Codelab](https://github.com/developerjamiu/travel_planner/blob/starter/codelabs/01_INTRODUCTION.md)
