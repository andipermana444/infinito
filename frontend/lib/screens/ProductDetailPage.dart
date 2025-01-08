import 'package:flutter/material.dart';
import 'package:frontend/models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${product.name}', style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Text('Price: \$${product.price}', style: TextStyle(fontSize: 20)),
            // Tambahkan informasi lain yang ingin ditampilkan
          ],
        ),
      ),
    );
  }
}
