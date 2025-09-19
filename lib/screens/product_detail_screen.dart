import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yes_bharath_mt/utils/mock_data.dart';
import 'package:yes_bharath_mt/widgets/badge_icon.dart';
import 'package:yes_bharath_mt/widgets/button_widget.dart';
import 'package:yes_bharath_mt/widgets/product_card.dart';
import 'package:yes_bharath_mt/widgets/product_variation_selector.dart';

import '../providers/product_provider.dart';

/// Main product detail screen that displays comprehensive product information
/// including images, pricing, variants, and related products
class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch providers for reactive state management
    final products = ref.watch(productListProvider);
    final product = ref.watch(selectedProductProvider);
    final currentIndex = ref.watch(carouselIndexProvider);

    // Early return for null product state
    if (product == null) {
      return const Scaffold(body: Center(child: Text("No product selected")));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image carousel section
            _ProductImageCarousel(
              product: product,
              currentIndex: currentIndex,
              onPageChanged: (index) {
                ref.read(carouselIndexProvider.notifier).state = index;
              },
            ),

            const SizedBox(height: 12),

            // Product basic information section
            _ProductBasicInfo(product: product),

            const SizedBox(height: 44),

            // Product variant selection section
            _buildProductVariants(),

            const SizedBox(height: 16),

            // Product features section
            const _ProductFeaturesCard(),

            const SizedBox(height: 20),

            // Product details section
            _buildProductDetails(),

            const SizedBox(height: 20),

            // Related products section
            _buildRelatedProductsSection(products),

            const SizedBox(height: 20),

            // Action buttons section
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  /// Builds the app bar with notification and action icons
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        BadgeIcon(icon: Icons.notifications_none, count: 2, onTap: () {}),
        BadgeIcon(icon: Icons.favorite_border, count: 0, onTap: () {}),
        BadgeIcon(icon: Icons.shopping_bag_outlined, count: 3, onTap: () {}),
      ],
    );
  }

  /// Builds product variant selection widgets
  Widget _buildProductVariants() {
    return ProductVariantSelector(
      title: "White Pattern",
      subtitle: "Only 5 Left",
      options: List.generate(6, (index) => VariantOption.image(tempImageUrl)),
    );
  }

  /// Builds product details card with specifications
  Widget _buildProductDetails() {
    const productDetails = {
      "Fabric": "Cotton",
      "Length": "Regular",
      "Neck": "Round Neck",
      "Style Code": "0909ii",
    };

    return ProductDetailsCard(details: productDetails, onViewMore: () {});
  }

  /// Builds the related products section with horizontal scrolling
  Widget _buildRelatedProductsSection(List products) {
    return Column(
      children: [
        // Section header
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "You May Like",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "View All",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Horizontal product list
        SizedBox(
          height: 280,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 160,
                child: ProductCard(product: products[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Builds the bottom action buttons (Add to cart, Buy now)
  Widget _buildActionButtons() {
    return const Row(
      children: [
        Expanded(child: ButtonWidget(text: 'Add to cart')),
        SizedBox(width: 10),
        Expanded(child: ButtonWidget(text: 'Buy Now', isFilled: true)),
      ],
    );
  }
}

/// Widget for displaying product image carousel with indicators
class _ProductImageCarousel extends StatelessWidget {
  final dynamic product;
  final int currentIndex;
  final Function(int) onPageChanged;

  const _ProductImageCarousel({
    required this.product,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image carousel
        CarouselSlider(
          options: CarouselOptions(
            height: 313,
            enlargeCenterPage: true,
            viewportFraction: 0.8,
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 500),
            onPageChanged: (index, _) => onPageChanged(index),
          ),
          items: product.images.map<Widget>((imageUrl) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 250,
                    color: Colors.grey[200],
                    child: const Icon(Icons.error, color: Colors.grey),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 250,
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 8),

        // Carousel indicators
        _buildCarouselIndicators(),
      ],
    );
  }

  /// Builds dot indicators for the carousel
  Widget _buildCarouselIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: product.images.asMap().entries.map<Widget>((entry) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: currentIndex == entry.key ? 12 : 6,
          height: 6,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: currentIndex == entry.key ? Colors.redAccent : Colors.grey,
          ),
        );
      }).toList(),
    );
  }
}

/// Widget for displaying basic product information (brand, name, pricing)
class _ProductBasicInfo extends StatelessWidget {
  final dynamic product;

  const _ProductBasicInfo({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Brand name
        Text(
          product.brand,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),

        const SizedBox(height: 4),

        // Product name
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black54,
          ),
        ),

        const SizedBox(height: 8),

        // Pricing information
        _buildPricingRow(),
      ],
    );
  }

  /// Builds the pricing row with current price, old price, and discount
  Widget _buildPricingRow() {
    return Row(
      children: [
        // Current price
        Text(
          "₹${product.price}",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 8),
        // Old price with strikethrough
        Text(
          "₹${product.oldPrice}",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        const SizedBox(width: 8),
        // Discount percentage
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            "${product.discount}% OFF",
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

/// Widget for displaying product features like COD, return policy, etc.
class _ProductFeaturesCard extends StatelessWidget {
  const _ProductFeaturesCard();

  // Static list of features to avoid rebuilding
  static const List<String> _features = [
    'COD Available',
    '15 Days Exchange / Return Available',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      //
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _features.map(_buildFeatureItem).toList(),
      ),
    );
  }

  /// Builds individual feature item with bullet point
  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "• ",
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          Expanded(
            child: Text(
              feature,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget for displaying detailed product specifications
class ProductDetailsCard extends StatelessWidget {
  final Map<String, String> details;
  final VoidCallback onViewMore;

  const ProductDetailsCard({
    super.key,
    required this.details,
    required this.onViewMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      //
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          const Text(
            "Product Details",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),

          // Product specifications list
          ...details.entries.map(_buildDetailItem),

          const SizedBox(height: 12),
          const Divider(height: 1, color: Colors.black12),

          // View more button
          _buildViewMoreButton(),
        ],
      ),
    );
  }

  /// Builds individual detail item (key-value pair)
  Widget _buildDetailItem(MapEntry<String, String> entry) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ${entry.key}",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "- ${entry.value}",
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the view more button with arrow icon
  Widget _buildViewMoreButton() {
    return InkWell(
      onTap: onViewMore,
      borderRadius: BorderRadius.circular(8),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "View More",
              style: TextStyle(
                fontSize: 14,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
