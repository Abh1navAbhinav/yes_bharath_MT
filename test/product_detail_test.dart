// test/product_detail_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:yes_bharath_mt/models/product_model.dart';
import 'package:yes_bharath_mt/providers/product_provider.dart';
import 'package:yes_bharath_mt/screens/product_detail_screen.dart';

void main() {
  testWidgets('Product detail screen shows product data', (
    WidgetTester tester,
  ) async {
    final testProduct = Product(
      id: '1',
      brand: 'Test Brand',
      name: 'Test Shirt',
      imageUrl: 'https://example.com/test.jpg',
      price: 1000,
      oldPrice: 1200,
      discount: 20,
      description: 'A test shirt description',
      availableSizes: ['S', 'M'],
      colors: ['Red'],
      images: [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWKrfFmnkIGfRit7ILUJ5SPaYKDSLWATSx2YD3WFJuEPLYFQKFE668cSwy-3CHAIwjpmM&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWKrfFmnkIGfRit7ILUJ5SPaYKDSLWATSx2YD3WFJuEPLYFQKFE668cSwy-3CHAIwjpmM&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWKrfFmnkIGfRit7ILUJ5SPaYKDSLWATSx2YD3WFJuEPLYFQKFE668cSwy-3CHAIwjpmM&usqp=CAU',
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [selectedProductProvider.overrideWith((ref) => testProduct)],
        child: const MaterialApp(home: ProductDetailScreen()),
      ),
    );

    expect(find.text('Test Brand'), findsOneWidget);
    expect(find.text('Test Shirt'), findsOneWidget);
    expect(find.text('₹1000'), findsOneWidget);
    expect(find.text('₹1200'), findsOneWidget);
  });
}
