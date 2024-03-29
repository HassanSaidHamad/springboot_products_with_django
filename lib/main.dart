import 'package:flutter/material.dart';
import 'package:products_with_django/providers/ProductProvider.dart';
import 'package:products_with_django/screens/product_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductProvider>(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        theme: ThemeData(),
        home: const ProductListWidget(),
      ),
    );
  }
}
