// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'dashboardcopy.dart';

class MyLoginForm extends StatefulWidget {
  const MyLoginForm({super.key});

  @override
  _MyLoginFormState createState() => _MyLoginFormState();
}

class _MyLoginFormState extends State<MyLoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Email TextField
          Container(
            child: const Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
          ),
          const SizedBox(height: 15), // Space between fields
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              border: Border.all(
                color: const Color.fromRGBO(0, 0, 34, 1),
                width: 2,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                hintStyle: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.8),
                fontFamily: 'Poppins',
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 20), // Space between fields
          // Password TextField
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              border: Border.all(
                color: const Color.fromRGBO(0, 0, 34, 1),
                width: 2,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: TextField(
              controller: _passwordController,
              obscureText: true, // Hides the password text
              decoration: const InputDecoration(
                hintText: 'Enter your password',
                hintStyle: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.8),
                fontFamily: 'Poppins',
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 10), // Space for "Lupa Password" text
          // "Lupa Password" text
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Action for "Lupa Password" button
                print("Lupa password clicked");
              },
              child: const Text(
                'Lupa Password?',
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Poppins',
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30), // Space for button
          // Login Button
          SizedBox(
            width: double.infinity, // Make the button full-width
            child: ElevatedButton(
              onPressed: () {
                // Action for login button
                String email = _emailController.text;
                String password = _passwordController.text;
                // validation and action here
                print('Email: $email, Password: $password');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashboardCopy()));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: const Color.fromARGB(255, 0, 0, 22),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
