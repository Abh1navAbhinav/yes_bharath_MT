import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productListProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Men's Shirt",
                  prefixIcon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.grey,
                  ),
                  suffixIcon: Icon(Icons.cancel_outlined, color: Colors.grey),
                ),
              ),
            ),

            GridView.builder(
              shrinkWrap: true,
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
                    ref.read(selectedProductProvider.notifier).state = product;
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
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: const [Icon(Icons.tune_outlined), Text('Filter')],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: const [Icon(Icons.filter_list), Text('Sort By')],
            ),
          ],
        ),
      ),
    );
  }
}
