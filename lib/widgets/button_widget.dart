import 'package:flutter/material.dart';

/// A customizable button widget with two styles: 
/// - **Filled** (solid background with white text)
/// - **Outlined** (transparent background with red border and text)
///
/// Usage:
/// ```dart
/// ButtonWidget(text: "Login", isFilled: true);   // Filled red button
/// ButtonWidget(text: "Cancel");                  // Outlined button
/// ```
class ButtonWidget extends StatelessWidget {
  /// The text displayed inside the button.
  final String text;

  /// If true, the button is displayed as filled (solid red background).
  /// If false, the button is displayed as outlined (transparent background with border).
  final bool isFilled;

  const ButtonWidget({
    super.key,
    required this.text,
    this.isFilled = false, // Default is outlined style
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50, // Fixed button height
      decoration: BoxDecoration(
        // Background color depends on whether the button is filled
        color: isFilled ? Colors.red : Colors.transparent,

        // Always has a red border
        border: Border.all(color: Colors.red),

        // Rounded corners
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            // Text color is white for filled button, red for outlined
            color: isFilled ? Colors.white : Colors.red,
          ),
        ),
      ),
    );
  }
}
