import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:products_with_django/constants/constant.dart';
import 'package:products_with_django/models/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static Future<List<Product>> listAllProducts() async {
    final Uri uri = Uri.parse('${Constant.baseUrl}/products/');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<Product> products = [];
      for (var productJson in data) {
        products.add(Product.fromJson(productJson));
      }
      return products;
    } else {
      throw Exception('Failed to load the product data!');
    }
  }

  // CREATE
  // Method Signature:
  static Future<Product> createProduct(
      String name, String description, String price) async {
    final Uri uri = Uri.parse('${Constant.baseUrl}/create-product/');

    // Building Request Data:
    // Here, a Map called productData is created to hold the data that will be sent in the request body. This data includes name, description, and price.
    final Map<String, dynamic> productData = {
      'name': name,
      'description': description,
      'price': price,
    };

    // Sending POST Request:
    // The code performs an HTTP POST request to the specified uri (the ${Constant.baseUrl}/create-product/ endpoint). It sends the productData in the request body after encoding it to JSON using jsonEncode. It uses the Constant.headers for any additional headers that need to be sent with the request.
    final response = await http.post(
      uri,
      headers: Constant.headers,
      body: jsonEncode(productData),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      Product product = Product.fromJson(responseData);
      return product;
    } else {
      throw Exception('Failed to create product!');
    }
  }

  // UPDATE
  static Future<Product> updateProduct(
      String name, String description, String price, int productId) async {
    final Uri uri = Uri.parse('${Constant.baseUrl}/update-product/$productId/');

    // Building Request Data:
    // Here, a Map called productData is created to hold the data that will be sent in the request body. This data includes name, description, and price.
    final Map<String, dynamic> productData = {
      'name': name,
      'description': description,
      'price': price,
    };

    // Sending POST Request:
    // The code performs an HTTP POST request to the specified uri (the ${Constant.baseUrl}/create-product/ endpoint). It sends the productData in the request body after encoding it to JSON using jsonEncode. It uses the Constant.headers for any additional headers that need to be sent with the request.
    final response = await http.put(
      uri,
      headers: Constant.headers,
      body: jsonEncode(productData),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      Product product = Product.fromJson(responseData);
      return product;
    } else {
      throw Exception('Failed to update product!');
    }
  }

// DELETE
  static Future<void> deleteProduct(int productId) async {
    final Uri uri = Uri.parse('${Constant.baseUrl}/delete-product/$productId/');

    final response = await http.delete(
      uri,
      headers: Constant.headers,
    );

    if (response.statusCode == 204) {
      print('Student deleted successfully');
    } else {
      throw Exception('Failed to delete student.');
    }
  }

  // end
}

// class ProductService {
//   static Future<List<Product>> listAllProducts() async {
//     final Uri uri = Uri.parse('${Constant.baseUrl}/products/');
//     final response = await http.get(uri);
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       print(response.body);
//       return data.map((json) => Product.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load the product data!');
//     }
//   }
// }
