import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class productscreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: "Fresh Chicken Meat",
      imageUrl: "https://images.unsplash.com/photo-1553531009-c4605f302b47?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fG9yZ2FuaWMlMjBjaGlja2VufGVufDB8fDB8fHww",
      price: "\$10.99/kg",
    ),
    Product(
      name: "Organic Chicken Eggs",
      imageUrl: "https://images.unsplash.com/photo-1655979913434-c8694d8299fc?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fG9yZ2FuaWMlMjBjaGlja2VufGVufDB8fDB8fHww",
      price: "\$3.50/dozen",
    ),
    Product(
      name: "Chicken Feed",
      imageUrl: "https://media.istockphoto.com/id/614106728/photo/fresh-eggs.webp?a=1&b=1&s=612x612&w=0&k=20&c=y3uLPwQIMVGq_nDDalYNOYv_XvWHCXekK7ZbC2sPL64=",
      price: "\$25.00/bag",
    ),
    Product(
      name: "Live Chicken",
      imageUrl: "https://images.unsplash.com/photo-1691922475320-2ea2c4e7b48d?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8b3JnYW5pYyUyMGNoaWNrZW58ZW58MHx8MHx8fDA%3D",
      price: "\$15.00 each",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chicken Products"),

      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}

class Product {
  final String name;
  final String imageUrl;
  final String price;

  Product({required this.name, required this.imageUrl, required this.price});
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: product.imageUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        title: Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(product.price, style: TextStyle(color: Colors.green)),
      ),
    );
  }
}