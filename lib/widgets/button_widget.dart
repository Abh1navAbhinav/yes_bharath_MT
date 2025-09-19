import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final bool isFilled;

  const ButtonWidget({super.key, required this.text, this.isFilled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _buttonHeight,
      decoration: _buildBoxDecoration(),
      child: Center(child: Text(text, style: _buildTextStyle())),
    );
  }

  /// Builds the box decoration for the button
  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: isFilled ? _primaryColor : Colors.transparent,
      border: Border.all(color: _primaryColor),
      borderRadius: BorderRadius.circular(8),
    );
  }

  /// Builds the text style depending on the button type
  TextStyle _buildTextStyle() {
    return TextStyle(
      color: isFilled ? Colors.white : _primaryColor,
      fontWeight: FontWeight.w600,
    );
  }

  // ---- Static Styling Constants ----
  static const double _buttonHeight = 50;
  static const Color _primaryColor = Color(0xffEC1B45);
}
