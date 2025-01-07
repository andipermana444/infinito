import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/product_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/services/product_service.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _supplierController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
    // try {
    //   XFile? pickedFile;

    //   if (kIsWeb) {
    //     // Logika untuk platform web
    //     pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    //   } else {
    //     // Logika untuk platform Android/iOS
    //     pickedFile = await _picker.pickImage(
    //       source: ImageSource.gallery,
    //       imageQuality: 50, // Kompresi untuk seluler
    //     );
    //   }

    //   if (pickedFile != null) {
    //     setState(() {
    //       _pickedImage = pickedFile;
    //     });
    //     print('Picked image path: ${pickedFile.path}');
    //   } else {
    //     print('No image selected.');
    //   }
    // } catch (e) {
    //   print('Error picking image: $e');
    // }
  }

  // Function to upload image using Dio
  Future<void> _uploadImage(File image) async {
    try {
      String fileName = image.uri.pathSegments.last;
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(image.path, filename: fileName),
      });

      Dio dio = Dio();
      // Replace 'YOUR_API_URL' with your actual API endpoint for image upload
      Response response = await dio.post(
        'YOUR_API_URL',
        data: formData,
      );

      if (response.statusCode == 200) {
        print("Image uploaded successfully!");
      } else {
        print("Image upload failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  // Submit form
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        Product newProduct = Product(
          name: _nameController.text,
          category: _categoryController.text,
          supplier_id: _supplierController.text,
          price: _priceController.text,
          stock: _stockController.text,
          description: _descriptionController.text,
          image: "",
        );

        await ProductService().addProduct(newProduct);
        print("Product added successfully!");
      } catch (e) {
        print("Error adding product: $e");
      }
      // Prepare the form data
      // FormData formData = FormData.fromMap({
      //   'name': _nameController.text,
      //   'category': _categoryController.text,
      //   'supplier_id': _supplierController.text,
      //   'price': _priceController.text,
      //   'stock': _stockController.text,
      //   'description': _descriptionController.text,
      //   // Add the image if selected
      //   'image': _pickedImage != null
      //       ? await MultipartFile.fromFile(_pickedImage!.path,
      //           filename: _pickedImage!.name)
      //       : null,
      // });

      // try {
      //   Dio dio = Dio();
      //   // Replace 'YOUR_API_URL' with the actual API URL for product upload
      //   Response response = await dio.post(
      //     'http://localhost/infinito/backend/products.php',
      //     data: formData,
      //   );

      //   if (response.statusCode == 200) {
      //     // Handle successful response
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Product added successfully!')),
      //     );
      //   } else {
      //     // Handle error from server
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Failed to add product.')),
      //     );
      //   }
      // } catch (e) {
      //   print("Error submitting form: $e");
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text('Error submitting product.')),
      //   );
      // }
    } else {
      print("34");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Product Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Category
                TextFormField(
                  controller: _categoryController,
                  decoration: const InputDecoration(labelText: 'Category'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Supplier ID
                TextFormField(
                  controller: _supplierController,
                  decoration: const InputDecoration(labelText: 'Supplier ID'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter supplier ID';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Price
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Stock
                TextFormField(
                  controller: _stockController,
                  decoration: const InputDecoration(labelText: 'Stock'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the stock quantity';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid stock quantity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Description
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Image Picker
                // GestureDetector(
                //   onTap: pickImage,
                //   child: Container(
                //     width: double.infinity,
                //     height: 150,
                //     decoration: BoxDecoration(
                //       color: Colors.grey[200],
                //       border: Border.all(color: Colors.grey),
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     child: _pickedImage != null
                //         ? Image.network(
                //             _pickedImage!.path,
                //             fit: BoxFit.cover,
                //           )
                //         : const Center(child: Text('Tap to select image')),
                //   ),
                // ),
                // const SizedBox(height: 20),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Add Product'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
