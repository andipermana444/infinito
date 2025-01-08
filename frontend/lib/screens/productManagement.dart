// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:frontend/components/ProductList.dart';
import 'package:frontend/services/product_service.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/screens/AddProductForm.dart';

class ProductManagement extends StatefulWidget {
  const ProductManagement({super.key});

  @override
  _ProductManagementState createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ProductService().fetchProducts();
    print(futureProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman tambah product
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProductForm()));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: const Color.fromARGB(255, 0, 0, 22),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Tambah Product',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, // Lebar yang sama dengan tombol
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search foods, snacks, or drinks',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      print('Tombol pencarian diklik');
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(11.0),
                      child: Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<List<Product>>(
                future: futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    List<Product> products = snapshot.data!;

                    return ProductList(products: products);
                  } else {
                    return Center(child: Text('No data available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
