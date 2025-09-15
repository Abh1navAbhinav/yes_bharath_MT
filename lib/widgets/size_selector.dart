import 'package:flutter/material.dart';

enum ProductType { cloth, fabric }

class SizeSelectorWidget extends StatefulWidget {
  final ProductType productType;
  final List<String> sizes; // For cloth products

  const SizeSelectorWidget({
    super.key,
    required this.productType,
    this.sizes = const ["S", "M", "L", "XL", "XXL"],
  });

  @override
  State<SizeSelectorWidget> createState() => _SizeSelectorWidgetState();
}

class _SizeSelectorWidgetState extends State<SizeSelectorWidget> {
  // For cloth
  String? selectedSize;

  // For fabric
  int meter = 2;
  int millimeter = 50;

  // Common stepper builder (for fabric sizes)
  Widget _buildStepper({
    required int value,
    required String unit,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value.toString().padLeft(2, "0"),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 4),
          Text(unit, style: const TextStyle(color: Colors.black54)),

          const SizedBox(width: 8),

          // Stepper buttons
          Column(
            children: [
              InkWell(
                onTap: onIncrement,
                child: const Icon(Icons.add, size: 16, color: Colors.redAccent),
              ),
              const SizedBox(height: 4),
              InkWell(
                onTap: onDecrement,
                child: const Icon(
                  Icons.remove,
                  size: 16,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.productType == ProductType.cloth) {
      // 🔹 Cloth UI (Choice Chips)
      return Wrap(
        spacing: 10,
        children: widget.sizes.map((size) {
          final isSelected = size == selectedSize;
          return ChoiceChip(
            label: Text(size),
            selected: isSelected,
            selectedColor: Colors.redAccent.withOpacity(0.2),
            onSelected: (value) {
              setState(() {
                selectedSize = size;
              });
            },
          );
        }).toList(),
      );
    } else {
      // 🔹 Fabric UI (Stepper)
      return Row(
        children: [
          _buildStepper(
            value: meter,
            unit: "M",
            onIncrement: () => setState(() => meter++),
            onDecrement: () {
              if (meter > 1) setState(() => meter--);
            },
          ),
          const SizedBox(width: 12),
          _buildStepper(
            value: millimeter,
            unit: "MM",
            onIncrement: () {
              setState(() {
                millimeter += 10;
                if (millimeter >= 100) {
                  millimeter = 0;
                  meter++;
                }
              });
            },
            onDecrement: () {
              setState(() {
                if (millimeter > 0) {
                  millimeter -= 10;
                } else if (meter > 1) {
                  meter--;
                  millimeter = 90;
                }
              });
            },
          ),
        ],
      );
    }
  }
}
