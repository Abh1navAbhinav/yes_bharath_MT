import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:yes_bharath_mt/models/product_model.dart';

import '../utils/mock_data.dart';

// StateProvider for holding product list
final productListProvider = Provider<List<Product>>((ref) => mockProducts);

// StateProvider for selected product (detail screen)
final selectedProductProvider = StateProvider<Product?>((ref) => null);

// StateProvider carousel index
final carouselIndexProvider = StateProvider<int>((ref) => 0);

// Provider to keep track of the selected variant index
final selectedVariantProvider = StateProvider<int>((ref) => 0);