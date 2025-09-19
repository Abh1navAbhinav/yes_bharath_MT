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
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 40,
        width: 78,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 7, bottom: 7),
              child: Text(
                value.toString().padLeft(2, "0"),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(width: 8),

            // Stepper buttons
            Container(
              width: 21,
              color: Colors.red.withOpacity(0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: onIncrement,
                    child: const Icon(Icons.add, size: 14, color: Colors.grey),
                  ),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Size',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.productType == ProductType.cloth
                  ? 'Size Chart'
                  : 'Size in meter',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.grey,
                decoration: TextDecoration.underline,
                decorationColor: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (widget.productType == ProductType.cloth)
          // 🔹 Cloth UI (Choice Chips)
          Wrap(
            spacing: 10,
            children: widget.sizes.map((size) {
              final isSelected = size == selectedSize;
              return ChoiceChip(
                label: Text(
                  size,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
                backgroundColor: Colors.white,
                showCheckmark: false,
                selected: isSelected,
                selectedColor: Color(0xffEC1B45),

                onSelected: (value) {
                  setState(() {
                    selectedSize = size;
                  });
                },
              );
            }).toList(),
          )
        else
          // 🔹 Fabric UI (Stepper)
          Row(
            children: [
              _buildStepper(
                value: meter,
                onIncrement: () => setState(() => meter++),
                onDecrement: () {
                  if (meter > 1) setState(() => meter--);
                },
              ),
              const SizedBox(width: 4),
              Text(
                "M",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 12),
              _buildStepper(
                value: millimeter,
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
              const SizedBox(width: 4),
              Text(
                "MM",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
