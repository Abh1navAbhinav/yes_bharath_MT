import 'package:flutter/material.dart';

/// Enum to define the type of product for size selection
enum ProductType { cloth, fabric }

/// A widget that provides size selection functionality for different product types.
/// For cloth products, it shows size chips (S, M, L, XL, XXL).
/// For fabric products, it shows meter and millimeter steppers.
class SizeSelectorWidget extends StatefulWidget {
  final ProductType productType;
  final List<String> sizes;

  const SizeSelectorWidget({
    super.key,
    required this.productType,
    this.sizes = const ["S", "M", "L", "XL", "XXL"],
  });

  @override
  State<SizeSelectorWidget> createState() => _SizeSelectorWidgetState();
}

class _SizeSelectorWidgetState extends State<SizeSelectorWidget> {
  // Selected size for cloth products
  String? selectedSize;

  // Fabric measurement values
  int meter = 2;
  int millimeter = 50;

  /// Builds a stepper widget for incrementing/decrementing numeric values
  /// Used for meter and millimeter selection in fabric products
  Widget _buildStepper({
    required int value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 40,
        width: 78,
        decoration: _stepperDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Display value with zero padding
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 7, bottom: 7),
              child: Text(
                value.toString().padLeft(2, "0"),
                style: _stepperTextStyle,
              ),
            ),
            const SizedBox(width: 8),
            // Increment/Decrement buttons container
            Container(
              width: 21,
              color: Colors.red.withOpacity(0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Increment button
                  InkWell(
                    onTap: onIncrement,
                    child: const Icon(Icons.add, size: 14, color: Colors.grey),
                  ),
                  // Decrement button
                  InkWell(
                    onTap: onDecrement,
                    child: const Icon(
                      Icons.remove,
                      size: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the size selection UI for cloth products using ChoiceChips
  Widget _buildClothSizeSelector() {
    return Wrap(
      spacing: 10,
      children: widget.sizes.map((size) {
        final isSelected = size == selectedSize;
        return ChoiceChip(
          label: Text(
            size,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
          backgroundColor: Colors.white,
          showCheckmark: false,
          selected: isSelected,
          selectedColor: const Color(0xffEC1B45),
          onSelected: (value) {
            setState(() {
              selectedSize = size;
            });
          },
        );
      }).toList(),
    );
  }

  /// Builds the fabric size selector with meter and millimeter steppers
  Widget _buildFabricSizeSelector() {
    return Row(
      children: [
        // Meter stepper
        _buildStepper(
          value: meter,
          onIncrement: () => setState(() => meter++),
          onDecrement: () {
            if (meter > 1) setState(() => meter--);
          },
        ),
        const SizedBox(width: 4),
        const Text("M", style: _unitTextStyle),
        const SizedBox(width: 12),
        // Millimeter stepper
        _buildStepper(
          value: millimeter,
          onIncrement: _incrementMillimeter,
          onDecrement: _decrementMillimeter,
        ),
        const SizedBox(width: 4),
        const Text("MM", style: _unitTextStyle),
      ],
    );
  }

  /// Handles millimeter increment with automatic meter conversion
  void _incrementMillimeter() {
    setState(() {
      millimeter += 10;
      // Convert to meter when reaching 100mm
      if (millimeter >= 100) {
        millimeter = 0;
        meter++;
      }
    });
  }

  /// Handles millimeter decrement with automatic meter conversion
  void _decrementMillimeter() {
    setState(() {
      if (millimeter > 0) {
        millimeter -= 10;
      } else if (meter > 1) {
        // Convert from meter when millimeter is 0
        meter--;
        millimeter = 90;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row with title and size chart/meter info
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Size', style: _titleTextStyle),
            Text(
              widget.productType == ProductType.cloth
                  ? 'Size Chart'
                  : 'Size in meter',
              style: _subtitleTextStyle,
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Conditional size selector based on product type
        widget.productType == ProductType.cloth
            ? _buildClothSizeSelector()
            : _buildFabricSizeSelector(),
      ],
    );
  }

  // Static styling constants for better performance and maintainability
  static const BoxDecoration _stepperDecoration = BoxDecoration(
    border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static const TextStyle _stepperTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle _unitTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle _titleTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle _subtitleTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: Colors.grey,
    decoration: TextDecoration.underline,
    decorationColor: Colors.grey,
  );
}
