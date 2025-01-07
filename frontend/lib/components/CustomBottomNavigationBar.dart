import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      currentIndex: currentIndex,
      onTap: onTap,
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
    );
  }
}
