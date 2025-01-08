// ignore_for_file: avoid_unnecessary_containers
import 'package:flutter/material.dart';

// dashboard tidak perlu statefulwidget ubah ke stateless
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  DashBoard createState() {
    return DashBoard();
  }
}

class DashBoard extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello, Asep!',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 32,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                height: 1,
              ),
            ),
            const SizedBox(height: 50), // Add space between the texts
            const Text(
              'Statistic',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
                height: 1,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _statisticBox('Total Transaction', '24')),
                const SizedBox(width: 10),
                Expanded(child: _statisticBox('Total Product', '12')),
              ],
            ),
            const SizedBox(height: 50), // space antara section
            const Text('Product of The Week',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                  height: 1,
                )),
            const SizedBox(height: 20),
            _prodTheWeek(),
            const SizedBox(height: 50),
            const Text('Need Stock Update',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                  height: 1,
                )),
            const SizedBox(height: 20),
            listStock('Oreo'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_tree_rounded),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Account',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }

  Widget _statisticBox(String title, String number) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ensure the box size is minimal
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            number,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _prodTheWeek() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 0, 22),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 207, 207, 207),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 168, 13, 207),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 10),
                  const Text("Product")
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
              child: Container(
            child: const Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Product",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Kategori: ", style: TextStyle(color: Colors.white)),
                Text("Harga: ", style: TextStyle(color: Colors.white)),
                Text("Terjual: ", style: TextStyle(color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                    onPressed: null,
                    child: Text(
                      "Detail",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget listStock(String prodName) {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: const Row(children: [
        Icon(Icons.food_bank_rounded),
        SizedBox(width: 8),
        Text('Produk 1'),
        Spacer(),
        Icon(Icons.edit),
      ]),
    ));
  }
}
