import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yes_bharath_mt/widgets/badge_icon.dart';
import 'package:yes_bharath_mt/widgets/button_widget.dart';
import 'package:yes_bharath_mt/widgets/product_card.dart';
import 'package:yes_bharath_mt/widgets/size_selector.dart';

import '../providers/product_provider.dart';

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
            CarouselSlider(
              options: CarouselOptions(
                height: 300,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(milliseconds: 500),
                onPageChanged: (index, reason) {
                  ref.read(carouselIndexProvider.notifier).state = index;
                },
              ),
              items: product.images.map((item) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item,
                    height: 250,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: product.images.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
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
            Text(
              product.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
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
            Row(
              children: <Widget>[
                Text('Color: ', style: TextStyle(color: Colors.grey)),
                Text(
                  'White pattern',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Spacer(),
                Text('Only 5 Left', style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
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
            SizeSelector(sizes: product.availableSizes),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    ['COD Available', '15 Days Exchange / Return Available']
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "• ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
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
            ),
            const SizedBox(height: 20),
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
                physics: BouncingScrollPhysics(),
                itemCount: products.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
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
            Row(
              children: [
                Expanded(child: ButtonWidget(text: 'Add to cart')),
                const SizedBox(width: 10),
                Expanded(child: ButtonWidget(text: 'Buy Now', isFilled: true)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
