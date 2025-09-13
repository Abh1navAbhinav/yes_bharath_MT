class Product {
  final String id;
  final String brand;
  final String name;
  final String imageUrl;
  final double price;
  final double oldPrice;
  final int discount;
  final String description;
  final List<String> availableSizes;
  final List<String> colors;
  final List<String> images;

  Product({
    required this.id,
    required this.brand,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.description,
    required this.availableSizes,
    required this.images,
    required this.colors,
  });
}
