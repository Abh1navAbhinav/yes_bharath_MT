import 'package:flutter/material.dart';
import '../models/product_model.dart';

/// A card widget that displays product details including:
/// - Product image with "Trending" and "Favorite" overlays
/// - Brand name, product name
/// - Pricing information with discount
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product image with overlays (trending badge + favorite icon)
        _buildImageSection(),

        const SizedBox(height: 8),

        // Brand name
        Text(
          product.brand,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),

        // Product name
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

        const SizedBox(height: 8),

        // Price, old price, and discount row
        _buildPriceSection(),
      ],
    );
  }

  /// Builds the product image section with "Trending" badge and "Favorite" icon
  Widget _buildImageSection() {
    return SizedBox(
      height: 179,
      child: Stack(
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              product.imageUrl,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),

          // Trending badge
          if (product.isTrending) _buildTrendingBadge(),

          // Favorite icon (top right)
          _buildFavoriteIcon(),
        ],
      ),
    );
  }

  /// Builds the "Trending" badge displayed on top-left
  Widget _buildTrendingBadge() {
    return Positioned(
      top: 5,
      left: 5,
      child: Container(
        height: 20,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: const Color(0xff10B981),
        ),
        child: const Text(
          'Trending',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /// Builds the favorite (heart) icon displayed on top-right
  Widget _buildFavoriteIcon() {
    return Positioned(
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
            color: Color(product.isFavourite ? 0xffEF4444 : 0xff6B7280),
            size: 20,
          ),
        ),
      ),
    );
  }

  /// Builds the price row with current price, old price, and discount
  Widget _buildPriceSection() {
    return Row(
      children: [
        // Current price
        Text(
          "₹${product.price}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(width: 6),

        // Old price (strikethrough)
        Text(
          "₹${product.oldPrice}",
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        const SizedBox(width: 6),

        // Discount percentage
        Text(
          "${product.discount}% OFF",
          style: const TextStyle(color: Colors.red),
        ),
      ],
    );
  }
}
