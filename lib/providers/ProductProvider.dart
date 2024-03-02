import 'package:flutter/material.dart';
import 'package:products_with_django/models/product.dart';
import 'package:products_with_django/services/ProductService.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> products = [];

  // CREATE
  void createProduct(String name, String description, String price) async {
    Product product =
        ProductService.createProduct(name, description, price) as Product;
    products.add(product);
    notifyListeners();
  }

  // UPDATE
  void updateProduct(
      String name, String description, String price, int productId) async {
    Product product =
        ProductService.updateProduct(name, description, price, productId)
            as Product;
    products.add(product);
    notifyListeners();
  }

  void deleteProduct(int productId) async {
    try {
      await ProductService.deleteProduct(productId);
      products.remove(productId as Product);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
