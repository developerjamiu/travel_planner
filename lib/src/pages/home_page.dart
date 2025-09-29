import 'package:flutter/material.dart';
import 'package:travel_planner/src/models/itinerary_day.dart';
import 'package:travel_planner/src/pages/itinerary_page.dart';
import 'package:travel_planner/src/services/itinerary_service.dart';
import 'package:travel_planner/src/services/mock_itinerary_service.dart';
import 'package:travel_planner/src/widgets/app_button.dart';
import 'package:travel_planner/src/widgets/app_dropdown.dart';
import 'package:travel_planner/src/widgets/app_text_field.dart';
import 'package:travel_planner/src/common/date_range_field_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  // Replace the MockItineraryService with GeminiItinerarySerive when Implemented
  final ItineraryService _itineraryService = MockItineraryService();
  bool _isLoading = false;

  late final _cityController = TextEditingController();
  late final _travelDateController = TextEditingController();
  DateTimeRange? _selectedDateRange;
  String? _selectedVibe;
  String? _selectedBudget;
  String? _selectedPace;

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: _selectedDateRange,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null && picked != _selectedDateRange) {
      setState(() => _selectedDateRange = picked);
      _travelDateController.text = picked.text;
    }
  }

  Future<void> _generateItinerary() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final List<ItineraryDay> itineraryDays = await _itineraryService
            .generateItinerary(
              city: _cityController.text,
              startDate: _selectedDateRange!.start,
              endDate: _selectedDateRange!.end,
              vibe: _selectedVibe!,
              budget: _selectedBudget!,
              pace: _selectedPace!,
            );

        if (!mounted) return;

        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ItineraryPage(days: itineraryDays),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          ),
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error generating itinerary: $e')),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Plan your next adventure.",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Fill in the details below to generate a personalized itinerary.",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.white60),
                  ),
                  const SizedBox(height: 32),
                  AppTextField(
                    controller: _cityController,
                    label: 'Destination City',
                    icon: Icons.location_city,
                    hint: 'e.g., Lagos, Nigeria',
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _selectDateRange,
                    child: AppTextField(
                      enabled: false,
                      hint: 'Select travel dates',
                      label: 'Travel Dates',
                      icon: Icons.calendar_today,
                      controller: _travelDateController,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppDropdown(
                    label: 'Traveler Vibe',
                    icon: Icons.palette_outlined,
                    initialValue: _selectedVibe,
                    items: [
                      'History & Nature',
                      'Artsy Foodie',
                      'Creative & Tech',
                      'Luxury Seeker',
                      'Adventure Seeker',
                      'Family Fun',
                      'Relax & Recharge',
                    ],
                    onChanged: (value) => setState(() => _selectedVibe = value),
                  ),
                  const SizedBox(height: 16),
                  AppDropdown(
                    label: 'Budget',
                    icon: Icons.attach_money,
                    initialValue: _selectedBudget,
                    items: ['Budget-friendly', 'Mid-range', 'Luxury'],
                    onChanged: (value) =>
                        setState(() => _selectedBudget = value),
                  ),
                  const SizedBox(height: 16),
                  AppDropdown(
                    label: 'Pace',
                    icon: Icons.speed_outlined,
                    initialValue: _selectedPace,
                    items: ['Relaxed', 'Moderate', 'Action-packed'],
                    onChanged: (value) => setState(() => _selectedPace = value),
                  ),
                  const SizedBox(height: 40),
                  AppButton(
                    onPressed: _isLoading ? null : _generateItinerary,
                    label: 'Generate Itinerary',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
