import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/models/product_model.dart'; // Import file model Product

class ProductService {
  final String baseUrl = "http://localhost/infinito/backend/products.php";

  // Fetch all products (GET)
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  Future<Product> addProduct(Product product) async {
    var uri =
        Uri.parse('$baseUrl/products'); // URL untuk menambahkan produk baru
    Dio dio = Dio();

    FormData formData = FormData.fromMap({
      'name': product.name,
      'category': product.category,
      'supplier_id': product.supplier_id.toString(),
      'price': product.price.toString(),
      'stock': product.stock.toString(),
      'description': product.description,
    });

    try {
      // Mengirimkan data tanpa gambar
      Response response = await dio.post(uri.toString(), data: formData);

      if (response.statusCode == 201) {
        return Product.fromJson(response.data);
      } else {
        throw Exception(
            "Failed to add product: ${response.statusCode} - ${response.statusMessage}");
      }
    } catch (e) {
      throw Exception("Failed to upload product: $e");
    }
  }

  Future<Product> updateProduct(int id, Product product) async {
    var uri = Uri.parse('$baseUrl/products/$id');
    Dio dio = Dio();

    FormData formData = FormData.fromMap({
      'nama': product.name,
      'category': product.category,
      'supplier_id': product.supplier_id.toString(),
      'price': product.price.toString(),
      'stock': product.stock.toString(),
      'description': product.description,
    });

    try {
      // Mengirimkan data untuk update produk tanpa gambar
      Response response = await dio.put(uri.toString(), data: formData);

      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception(
            "Failed to update product: ${response.statusCode} - ${response.statusMessage}");
      }
    } catch (e) {
      throw Exception("Failed to update product: $e");
    }
  }

  // Add a new product (POST)
  // Future<Product> addProduct(Product product) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/products'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode({
  //     'nama': product.name,
  //     'category': product.category,
  //     'supplier_id': product.supplier_id,
  //     'price': product.price,
  //     'stock': product.stock,
  //     'image': product.image,
  //     'description': product.description,
  //     }),
  //   );

  //   if (response.statusCode == 201) {
  //     return Product.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception("Failed to add product");
  //   }
  // }

  // // Update an existing product (PUT)
  // Future<Product> updateProduct(int id, Product product) async {
  //   final response = await http.put(
  //     Uri.parse('$baseUrl/products/$id'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode({
  //     'nama': product.name,
  //     'category': product.category,
  //     'supplier_id': product.supplier_id,
  //     'price': product.price,
  //     'stock': product.stock,
  //     'image': product.image,
  //     'description': product.description,
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     return Product.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception("Failed to update product");
  //   }
  // }

  // Delete a product (DELETE)
  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception("Failed to delete product");
    }
  }
}
