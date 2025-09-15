import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

/// Displays a list of products in a grid format with a search bar on top.
///
/// Uses Riverpod to fetch the product list from [productListProvider].  
/// On tapping a product, navigates to [ProductDetailScreen] while updating
/// the [selectedProductProvider].
class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productListProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search bar with back and clear icons
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Men's Shirt",
                  prefixIcon: const Icon(Icons.arrow_back_rounded,
                      color: Colors.grey),
                  suffixIcon:
                      const Icon(Icons.cancel_outlined, color: Colors.grey),
                ),
              ),
            ),

            // Product grid view
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    // Update selected product state
                    ref.read(selectedProductProvider.notifier).state = product;

                    // Navigate to product detail page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProductDetailScreen(),
                      ),
                    );
                  },
                  child: ProductCard(product: product),
                );
              },
            ),
          ],
        ),
      ),

      // Bottom navigation with "Filter" and "Sort By" options
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: _bottomNavDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            _BottomNavItem(icon: Icons.tune_outlined, label: 'Filter'),
            _BottomNavItem(icon: Icons.filter_list, label: 'Sort By'),
          ],
        ),
      ),
    );
  }
}

/// A reusable bottom navigation item with icon and label.
///
/// Used in the bottom navigation bar of [ProductListScreen].
class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _BottomNavItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        Text(label),
      ],
    );
  }
}

/// Common decoration style for the bottom navigation bar.
final BoxDecoration _bottomNavDecoration = BoxDecoration(
  color: Colors.white,
  border: Border(top: BorderSide(color: Colors.grey.shade300)),
);
