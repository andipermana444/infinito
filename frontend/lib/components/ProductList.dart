import 'package:flutter/material.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/screens/ProductDetailPage.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            'Menampilkan ${products.length} Produk',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        
        const SizedBox(height: 10),
        // Tidak perlu Expanded di sini karena ListView.builder sudah mengurus ukuran.
        Expanded(
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              Product product = products[index];

              return GestureDetector(
                onTap: () {
                  // Navigasi ke halaman detail produk
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(product: product),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.black26,
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Gambar produk jika ada, pastikan URL valid
                      // Gunakan Image.network atau Image.asset jika menggunakan gambar lokal
                      // product.image
                      //     ?
                      // Image.network(
                      //   product.image,
                      //   width: 50,
                      //   height: 50,
                      //   fit: BoxFit.cover,
                      //   loadingBuilder: (context, child, loadingProgress) {
                      //     if (loadingProgress == null) {
                      //       return child;
                      //     } else {
                      //       return Center(
                      //         child: CircularProgressIndicator(
                      //           value: loadingProgress.expectedTotalBytes !=
                      //                   null
                      //               ? loadingProgress.cumulativeBytesLoaded /
                      //                   (loadingProgress.expectedTotalBytes ??
                      //                       1)
                      //               : null,
                      //         ),
                      //       );
                      //     }
                      //   },
                      //   errorBuilder: (context, error, stackTrace) {
                      //     return Center(child: Text('Failed to load image'));
                      //   },
                      // ),
                         Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 22),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                // Memformat harga untuk tampilan lebih baik
                                Text(
                                  '\$${product.price}', // Format harga menjadi 2 digit desimal
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(product.category),
                            const SizedBox(height: 10),
                            const SizedBox(
                              width: double.infinity,
                              child: LinearProgressIndicator(
                                value: 0.8,
                                backgroundColor: Colors.grey,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
