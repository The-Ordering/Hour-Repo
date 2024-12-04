
import 'package:book_app/model/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_provider.g.dart';

const List<Product> allProducts = [
  Product(id: 1, name: "cap", price: 1.5, image: "assets/images/cap.png"),
  Product(id: 2, name: "lemon", price: 2, image: "assets/images/lemon.png"),
  Product(id: 3, name: "grass", price: 30, image: "assets/images/grass.png"),
  Product(id: 4, name: "stone", price: 20, image: "assets/images/stone.png")
];

@riverpod
List<Product> products(ref) {
  return allProducts;
}

@riverpod
List<Product> reducedProducts(ref) {
  return allProducts.where((element) => element.price < 10).toList();
}

