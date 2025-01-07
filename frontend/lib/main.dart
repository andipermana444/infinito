import 'package:flutter/material.dart';
import 'package:frontend/screens/Account.dart';
import 'package:frontend/screens/AddProductForm.dart';
import 'package:frontend/screens/Transaction.dart';
import 'package:frontend/screens/ProductManagement.dart';
import 'package:frontend/screens/Supplier.dart';
import 'package:frontend/screens/Dashboard.dart';
import 'components/CustomBottomNavigationBar.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      textTheme: GoogleFonts.poppinsTextTheme(),
    ),
    debugShowCheckedModeBanner: false,
    home: const MainScreen(),
  ));
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Dashboard(),
    const ProductManagement(),
    const Supplier(),
    const Transaction(),
    AddProductForm(),
    // const UserManagement(),
    const Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
