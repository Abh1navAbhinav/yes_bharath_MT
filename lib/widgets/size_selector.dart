import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
  final List<String> sizes;
  const SizeSelector({super.key, required this.sizes});

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: widget.sizes.map((size) {
        final isSelected = size == selectedSize;
        return ChoiceChip(
          label: Text(size),
          selected: isSelected,
          onSelected: (value) {
            setState(() {
              selectedSize = size;
            });
          },
        );
      }).toList(),
    );
  }
}
