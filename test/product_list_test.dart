import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:yes_bharath_mt/screens/product_list_screen.dart';

void main() {
  testWidgets('Product list screen shows products', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: ProductListScreen())),
    );

    expect(find.text("Men's Shirt"), findsOneWidget);
    await tester.pumpAndSettle();

    // Check if at least one product card is rendered
    expect(find.byType(Card), findsWidgets);
  });
}
