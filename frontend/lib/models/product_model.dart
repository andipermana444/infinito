class Product {
  int? id;
  final String name;
  final String category;
  // ignore: non_constant_identifier_names
  final String supplier_id;
  final String price;
  final String stock;
  final String image;
  final String description;

  Product({
    int? id,
    required this.name,
    required this.category,
    // ignore: non_constant_identifier_names
    required this.supplier_id,
    required this.price,
    required this.stock,
    required this.image,
    required this.description,
  });

// Fungsi untuk mengubah data JSON menjadi objek Mahasiswa
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
        name: json['name'],
        category: json['category'],
        supplier_id: json['supplier_id'],
        price: json['price'],
        stock: json['name'],
        image: json['image'],
        description: json['description']);
  }

// Fungsi untuk mengubah objek Mahasiswa menjadi format JSON
  Map<String, dynamic> toJson() {
    return {
      'nama': name,
      'category': category,
      'supplier_id': supplier_id,
      'price': price,
      'stock': stock,
      'image': image,
      'description': description,
    };
  }
}
