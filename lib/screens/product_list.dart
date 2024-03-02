import 'package:flutter/material.dart';
import 'package:products_with_django/models/product.dart';
import 'package:products_with_django/providers/ProductProvider.dart';
import 'package:products_with_django/screens/create_product.dart';
import 'package:products_with_django/screens/update_product.dart';
import 'package:products_with_django/services/ProductService.dart';
import 'package:provider/provider.dart';

class ProductListWidget extends StatefulWidget {
  const ProductListWidget({super.key});

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> onRefresh() async {
    setState(() {
      ProductService.listAllProducts();
    });
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product List',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        color: Colors.teal,
        child: FutureBuilder<List<Product>>(
          future: ProductService.listAllProducts(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  '${snapshot.error}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No products available'),
              );
            } else {
              final products = snapshot.data!;
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateProductWidget(product: product)));
                          onRefresh();
                        },
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(product.name.toString()),
                    subtitle: Text(
                      product.price,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        Provider.of<ProductProvider>(context, listen: false)
                            .deleteProduct(product.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Product deleted successfully!'),
                          ),
                        );
                        onRefresh();
                      },
                      child: const Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateProductWidget()));
          onRefresh();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
