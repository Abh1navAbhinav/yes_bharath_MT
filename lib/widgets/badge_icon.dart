import 'package:flutter/material.dart';

/// A customizable icon button with a badge count overlay.
///
/// Typically used for showing notifications, cart items, or favorites count.  
/// - [icon]: The main icon to display.  
/// - [count]: The badge number. Hidden if `count <= 0`.  
/// - [onTap]: Callback when the icon is pressed.
class BadgeIcon extends StatelessWidget {
  final IconData icon;
  final int count;
  final VoidCallback? onTap;

  const BadgeIcon({
    super.key,
    required this.icon,
    required this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main icon button
        IconButton(
          icon: Icon(icon, size: 28, color: Colors.black),
          onPressed: onTap,
        ),

        // Badge overlay (only visible if count > 0)
        if (count > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: _badgeDecoration,
              child: Text(
                "$count",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Common decoration style for the badge container.
const BoxDecoration _badgeDecoration = BoxDecoration(
  color: Colors.red,
  shape: BoxShape.circle,
);
