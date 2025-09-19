import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

/// Screen that displays a list of products in a grid layout
/// with search functionality and bottom navigation for filters
class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the product list from the provider
    final products = ref.watch(productListProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search bar section
            _buildSearchBar(),

            // Product grid section
            _buildProductGrid(context, ref, products),
          ],
        ),
      ),
      // Bottom navigation with filter and sort options
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  /// Builds the search bar widget
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          // Consistent border styling for enabled and default states
          border: _searchFieldBorder,
          enabledBorder: _searchFieldBorder,
          hintText: "Men's Shirt",

          prefixIcon: const Icon(Icons.arrow_back_rounded, color: Colors.grey),
          suffixIcon: const Icon(Icons.cancel_outlined, color: Colors.grey),
        ),
      ),
    );
  }

  /// Builds the product grid view
  Widget _buildProductGrid(
    BuildContext context,
    WidgetRef ref,
    List<dynamic> products,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return _buildProductItem(context, ref, product);
      },
    );
  }

  /// Builds individual product item with tap handling
  Widget _buildProductItem(
    BuildContext context,
    WidgetRef ref,
    dynamic product,
  ) {
    return GestureDetector(
      onTap: () => _navigateToProductDetail(context, ref, product),
      child: ProductCard(product: product),
    );
  }

  /// Builds the bottom navigation bar
  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: _bottomNavDecoration,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _BottomNavItem(icon: Icons.tune_outlined, label: 'Filter'),
          _BottomNavItem(icon: Icons.filter_list, label: 'Sort By'),
        ],
      ),
    );
  }

  /// Handles navigation to product detail screen
  void _navigateToProductDetail(
    BuildContext context,
    WidgetRef ref,
    dynamic product,
  ) {
    // Set the selected product in the provider
    ref.read(selectedProductProvider.notifier).state = product;

    // Navigate to product detail screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProductDetailScreen()),
    );
  }

  // Static styling constants
  static const OutlineInputBorder _searchFieldBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );
}

/// Custom bottom navigation item widget
class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _BottomNavItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [Icon(icon), Text(label)],
    );
  }
}

/// Decoration for the bottom navigation bar
final BoxDecoration _bottomNavDecoration = BoxDecoration(
  color: Colors.white,
  border: Border(top: BorderSide(color: Colors.grey.shade300)),
);
