import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import '../widgets/size_selector.dart';


class ProductVariantSelector extends ConsumerWidget {
  final String title;
  final String subtitle;
  final List<VariantOption> options;
  final bool isColorBox;
  final ProductType productType;

  const ProductVariantSelector({
    super.key,
    required this.title,
    required this.subtitle,
    required this.options,
    this.productType = ProductType.cloth,
    this.isColorBox = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedVariantProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header section with title and subtitle
        _buildHeader(),

        const SizedBox(height: 16),

        // Variant options (color swatches or image thumbnails)
        _buildVariantOptions(ref, selectedIndex),

        const SizedBox(height: 16),

        // Size selector (only visible for product types that support it)
        SizeSelectorWidget(productType: productType),
      ],
    );
  }

  /// Builds the header row showing "Color: Red" and subtitle
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: "Color: ",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
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
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Builds the horizontal scrollable list of variant options
  Widget _buildVariantOptions(WidgetRef ref, int selectedIndex) {
    return SizedBox(
      height: isColorBox ? 30 : 64,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final option = options[index];
          final isSelected = index == selectedIndex;
          return _buildVariantItem(ref, index, option, isSelected);
        },
      ),
    );
  }

  /// Builds an individual variant item (either a color box or an image thumbnail)
  Widget _buildVariantItem(
    WidgetRef ref,
    int index,
    VariantOption option,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () => ref.read(selectedVariantProvider.notifier).state = index,
      child: Container(
        width: isColorBox ? 30 : 62,
        height: isColorBox ? 30 : 64,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.red : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
          image: !isColorBox && option.imageUrl != null
              ? DecorationImage(
                  image: NetworkImage(option.imageUrl!),
                  fit: BoxFit.fill,
                )
              : null,
          color: isColorBox ? option.color : null,
        ),
      ),
    );
  }
}

/// Model for a product variant option.
/// Can either be an image or a color swatch.
class VariantOption {
  final String? imageUrl;
  final Color? color;

  /// Constructor for an image-based variant
  VariantOption.image(this.imageUrl) : color = null;

  /// Constructor for a color-based variant
  VariantOption.color(this.color) : imageUrl = null;
}
