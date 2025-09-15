import 'package:yes_bharath_mt/models/product_model.dart';

final String tempImageUrl =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWKrfFmnkIGfRit7ILUJ5SPaYKDSLWATSx2YD3WFJuEPLYFQKFE668cSwy-3CHAIwjpmM&usqp=CAU';

final mockProducts = [
  Product(
    id: '1',
    brand: 'Allen Solly',
    name: 'Regular Fit Cotton Shirt',
    imageUrl: tempImageUrl,
    price: 1035,
    oldPrice: 1190,
    discount: 15,
    description: 'Allen Solly Regular fit cotton shirt.',
    availableSizes: ['S', 'M', 'L', 'XL'],
    colors: ['Black', 'White'],
    images: [tempImageUrl, tempImageUrl, tempImageUrl],
  ),
  Product(
    id: '2',
    brand: 'Louis Philippe',
    name: 'Regular Fit Cotton Shirt',
    imageUrl: tempImageUrl,
    price: 1835,
    oldPrice: 2190,
    discount: 25,
    description: 'Louis Philippe Regular fit cotton shirt.',
    availableSizes: ['S', 'M', 'L', 'XL', 'XXL'],
    colors: ['White Pattern'],
    images: [tempImageUrl, tempImageUrl, tempImageUrl],
  ),
  Product(
    id: '2',
    brand: 'Louis Philippe',
    name: 'Regular Fit Cotton Shirt',
    imageUrl: tempImageUrl,
    price: 1835,
    oldPrice: 2190,
    discount: 25,
    description: 'Louis Philippe Regular fit cotton shirt.',
    availableSizes: ['S', 'M', 'L', 'XL', 'XXL'],
    colors: ['White Pattern'],
    images: [tempImageUrl, tempImageUrl, tempImageUrl],
  ),
];
