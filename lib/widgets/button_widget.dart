import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final bool isFilled;
  const ButtonWidget({super.key, required this.text, this.isFilled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: isFilled ? Colors.red : Colors.transparent,
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: isFilled ? Colors.white : Colors.red),
        ),
      ),
    );
  }
}
