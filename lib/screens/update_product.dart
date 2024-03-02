import 'package:flutter/material.dart';
import 'package:products_with_django/models/product.dart';
import 'package:products_with_django/providers/ProductProvider.dart';
import 'package:provider/provider.dart';

class UpdateProductWidget extends StatefulWidget {
  final Product product;

  const UpdateProductWidget({super.key, required this.product});

  @override
  State<UpdateProductWidget> createState() => _UpdateProductWidgetState();
}

class _UpdateProductWidgetState extends State<UpdateProductWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.product.name;
    _descriptionController.text = widget.product.description;
    _priceController.text = widget.product.price;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          // 'Update Product',
          'Update ${widget.product.name}',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
              width: width,
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  // labelText: 'Product name',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
              width: width,
              child: TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  // labelText: 'Product Description',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
              width: width,
              child: TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  // labelText: 'Product price',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_nameController.text == '' ||
                    _descriptionController.text == '' ||
                    _priceController.text == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('All fields are required!'),
                    ),
                  );
                } else {
                  String name = _nameController.text.trim();
                  String description = _descriptionController.text.trim();
                  String price = _priceController.text.trim();
                  int productId = widget.product.id;
                  Provider.of<ProductProvider>(context, listen: false)
                      .updateProduct(name, description, price, productId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Product updated successfully!'),
                    ),
                  );
                  Navigator.pop(context, true);
                }
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 25),
                width: width,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'Update Product',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
