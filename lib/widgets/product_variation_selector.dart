import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yes_bharath_mt/providers/product_provider.dart';

class ProductVariantSelector extends ConsumerWidget {
  final String title;
  final String subtitle;
  final List<VariantOption> options;
  final bool isColorBox; // if true → show color boxes instead of images

  const ProductVariantSelector({
    super.key,
    required this.title,
    required this.subtitle,
    required this.options,
    this.isColorBox = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedVariantProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Color: ",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Options (images or color boxes)
        SizedBox(
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: options.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final option = options[index];
              final isSelected = index == selectedIndex;

              return GestureDetector(
                onTap: () =>
                    ref.read(selectedVariantProvider.notifier).state = index,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? Colors.red : Colors.grey.shade300,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    image: !isColorBox && option.imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(option.imageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: isColorBox ? option.color : null,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Variant option model
class VariantOption {
  final String? imageUrl;
  final Color? color;

  VariantOption.image(this.imageUrl) : color = null;
  VariantOption.color(this.color) : imageUrl = null;
}
