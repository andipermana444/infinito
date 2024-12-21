import 'package:flutter/material.dart';

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
        margin: const EdgeInsets.all(50),
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
                fontSize: 24, // Adjust the size as needed
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
                height: 1,
              ),
            ),
            const SizedBox(height: 20), // Add space before the boxes
            Row(
              children: [
                Expanded(child: _statisticBox('Total Transaction', '24')),
                const SizedBox(width: 10), // Add space between the boxes
                Expanded(child: _statisticBox('Total Product', '12')),
              ],
            ),
            const SizedBox(height: 50), // Add space between the texts
            const Text(
              'Product of The Week',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24, // Adjust the size as needed
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
                height: 1,
              )
            ),
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
}