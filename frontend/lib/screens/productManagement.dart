import 'package:flutter/material.dart';
import 'package:frontend/screens/dashboardcopy.dart';

class productManagement extends StatelessWidget {
  const productManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){
                      print('Tambah produk');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: const Color.fromARGB(255, 0, 0, 22),
                    ),
                    child: const Text(
                      'Tambah Produk',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
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
                        child: const Icon(Icons.menu),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Label(label: 'Menampilkan 12 Suppliers'),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Oreo"),
                                          Spacer(),
                                          Text("Rp.3000")
                                        ],
                                      ),
                                      Label(label: "Snack"),
                                      SizedBox(height: 10),
                                      SizedBox(
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
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.fire_truck,
                color: Colors.black,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                color: Colors.black,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
