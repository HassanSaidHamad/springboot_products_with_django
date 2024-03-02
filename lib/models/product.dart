class Product {
  final int id;
  final String name;
  final String description;
  final String price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

// A factory constructor fromJson is used to create a Product instance from a JSON map.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
    );
  }

// The toJson method converts a Product instance back to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
    };
  }
}
