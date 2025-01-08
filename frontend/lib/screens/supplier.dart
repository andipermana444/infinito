import 'package:flutter/material.dart';
import 'package:frontend/components/Label.dart';

class Supplier extends StatelessWidget {
  const Supplier({super.key});

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
                  print('Tambah Supplier');
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
                      'Tambah Supplier',
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
                        hintText: 'Search products suppliers',
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
            const Label(label: 'Menampilkan 43 supplier'),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(12, (index) {
                    return SizedBox(
                      width: double.infinity,
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        margin: const EdgeInsets.only(bottom: 16.0),
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
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text("Iyan Furryan"),
                                  Label(label: "Snack"),
                                  SizedBox(height: 10),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
