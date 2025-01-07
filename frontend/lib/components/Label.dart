import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String label;

  const Label({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Color.fromARGB(127, 0, 0, 0),
        fontSize: 18,
      ),
    );
  }
}