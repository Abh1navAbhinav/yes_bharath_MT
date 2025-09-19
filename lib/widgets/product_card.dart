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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image with Favorite Icon
        SizedBox(
          height: 179,
          child: Stack(
            children: [
              // Product image with rounded top corners
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                child: Image.asset(
                  product.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),

              if (product.isTrending)
                Positioned(
                  top: 5,
                  left: 5,
                  child: Container(
                    height: 20,
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Color(0xff10B981),
                    ),
                    child: Text(
                      'Trending',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

              // Favorite (wishlist) icon positioned at top-right
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      product.isFavourite
                          ? Icons.favorite
                          : Icons.favorite_outline_rounded,
                      color: Color(
                        product.isFavourite ? 0xffEF4444 : 0xff6B7280,
                      ),
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 8),

        // Product Details Section (brand, name, price)
        Text(
          product.brand,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),

        // Product name with ellipsis if too long
        Text(
          product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8),

        // Price + Old Price (strikethrough)
        Row(
          children: [
            // Current price
            Text(
              "₹${product.price}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
            const SizedBox(width: 6),

            // Product discount in percentage
            Text(
              "${product.discount}% OFF",
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}
