import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yes_bharath_mt/utils/mock_data.dart';
import 'package:yes_bharath_mt/widgets/badge_icon.dart';
import 'package:yes_bharath_mt/widgets/button_widget.dart';
import 'package:yes_bharath_mt/widgets/product_card.dart';
import 'package:yes_bharath_mt/widgets/product_variation_selector.dart';
import 'package:yes_bharath_mt/widgets/size_selector.dart';

import '../providers/product_provider.dart';

/// A detailed product screen showing images, sizes, prices, and related products.
///
/// Uses Riverpod for state management.
/// Provides carousel slider, size selection, product details, and
/// "You may like" suggestions with horizontal scrolling.
class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productListProvider);
    final product = ref.watch(selectedProductProvider);
    final currentIndex = ref.watch(carouselIndexProvider);

    if (product == null) {
      return const Scaffold(body: Center(child: Text("No product selected")));
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          BadgeIcon(icon: Icons.notifications_none, count: 2, onTap: () {}),
          BadgeIcon(icon: Icons.favorite_border, count: 0, onTap: () {}),
          BadgeIcon(icon: Icons.shopping_bag_outlined, count: 3, onTap: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image carousel
            CarouselSlider(
              options: CarouselOptions(
                height: 300,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 500),
                onPageChanged: (index, _) {
                  ref.read(carouselIndexProvider.notifier).state = index;
                },
              ),
              items: product.images.map((item) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 10),

            // Carousel indicator dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: product.images.asMap().entries.map((entry) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == entry.key
                        ? Colors.redAccent
                        : Colors.grey,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 12),

            // Product name
            Text(
              product.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // Price, old price, discount
            Row(
              children: [
                Text(
                  "₹${product.price}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "₹${product.oldPrice}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "${product.discount}% OFF",
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),

            const SizedBox(height: 16),

            //
            ProductVariantSelector(
              title: "White Pattern",
              subtitle: "Only 5 Left",
              options: [
                VariantOption.image(tempImageUrl),
                VariantOption.image(tempImageUrl),
                VariantOption.image(tempImageUrl),
              ],
            ),

            const SizedBox(height: 16),

            //
            ProductVariantSelector(
              title: "Black",
              subtitle: "Only 5 Left",
              options: [
                VariantOption.image(tempImageUrl),
                VariantOption.image(tempImageUrl),
              ],
            ),

            const SizedBox(height: 16),

            //
            ProductVariantSelector(
              title: "Black",
              subtitle: "Only 5 Left",
              isColorBox: true,
              options: [
                VariantOption.color(Colors.black),
                VariantOption.color(Colors.red),
                VariantOption.color(Colors.blue),
                VariantOption.color(Colors.teal),
                VariantOption.color(Colors.orange),
              ],
            ),

            const SizedBox(height: 16),

            // Size section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Size',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Size Chart', style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16),
            SizeSelectorWidget(productType: ProductType.cloth),
            SizeSelectorWidget(productType: ProductType.fabric),

            const SizedBox(height: 16),

            // Features section
            const ProductFeaturesCard(),

            const SizedBox(height: 20),

            // Product details
            ProductDetailsCard(
              details: {
                "Fabric": "Cotton",
                "Length": "Regular",
                "Neck": "Round Neck",
                "Style Code": "0909ii",
              },
              onViewMore: () {},
            ),

            const SizedBox(height: 20),

            // Recommended products
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
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

            SizedBox(
              height: 280,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: products.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return SizedBox(
                    width: 160,
                    child: ProductCard(product: product),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Action buttons
            Row(
              children: const [
                Expanded(child: ButtonWidget(text: 'Add to cart')),
                SizedBox(width: 10),
                Expanded(child: ButtonWidget(text: 'Buy Now', isFilled: true)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A card widget that displays product features like COD availability,
/// return policy, etc.
class ProductFeaturesCard extends StatelessWidget {
  const ProductFeaturesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final features = ['COD Available', '15 Days Exchange / Return Available'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: features
            .map(
              (item) => Padding(
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
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

/// A card widget to display product specifications such as fabric,
/// length, style code, etc.
/// Includes a "View More" option to expand details.
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
      decoration: _cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Product Details",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),

          // Key-value product details
          Column(
            children: details.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Text(
                      "• ${entry.key}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "- ${entry.value}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 12),
          const Divider(height: 1, color: Colors.black12),

          // View more option
          InkWell(
            onTap: onViewMore,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
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
          ),
        ],
      ),
    );
  }
}

/// Common card decoration style used across product details/features cards.
final BoxDecoration _cardDecoration = BoxDecoration(
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
);
