import 'package:flutter/material.dart';
import 'package:yes_bharath_mt/models/product_model.dart';

/// A custom card widget to display product information in a clean, 
/// visually appealing way with an image, brand, name, price, and 
/// old price (strikethrough).
///
/// Includes:
/// - Product image with rounded corners
/// - Favorite (wishlist) icon overlay
/// - Product brand (bold text)
/// - Product name (single line with ellipsis)
/// - Product price + old price (with strikethrough)
///
/// Usage:
/// ```dart
/// ProductCard(product: myProduct);
/// ```
class ProductCard extends StatelessWidget {
  /// Product data model containing brand, name, price, image, etc.
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0, // No shadow for a clean flat look
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded card corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image with Favorite Icon
          Expanded(
            child: Stack(
              children: [
                // Product image with rounded top corners
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.network(
                    product.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.fill, // Fill the space inside the card
                  ),
                ),

                // Favorite (wishlist) icon positioned at top-right
                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5), // Semi-transparent background
                      borderRadius: BorderRadius.circular(100), // Circular background
                    ),
                    child: const Center(
                      child: Icon(Icons.favorite_outline), // Default outlined heart icon
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Product Details Section (brand, name, price)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand name in bold
                Text(
                  product.brand,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                // Product name with ellipsis if too long
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                // Price + Old Price (strikethrough)
                Row(
                  children: [
                    // Current price
                    Text(
                      "₹${product.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 6),

                    // Old price (with strikethrough)
                    Text(
                      "₹${product.oldPrice}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
