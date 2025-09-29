import 'package:flutter/material.dart';

class AppDropdown extends StatelessWidget {
  const AppDropdown({
    super.key,
    this.initialValue,
    required this.label,
    required this.icon,
    required this.items,
    this.onChanged,
  });

  final String? initialValue;
  final String label;
  final IconData icon;
  final List<String> items;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: initialValue,
      isExpanded: true,
      dropdownColor: const Color(0xFF1E1E1E),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withAlpha(180)),
        prefixIcon: Icon(icon, color: Colors.white70, size: 20),
      ),
      hint: Text(
        'Select an option',
        style: TextStyle(color: Colors.white.withAlpha(128)),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, overflow: TextOverflow.ellipsis),
        );
      }).toList(),
      validator: (value) {
        if (value == null) return 'Please select an option';

        return null;
      },
      onChanged: onChanged,
    );
  }
}
