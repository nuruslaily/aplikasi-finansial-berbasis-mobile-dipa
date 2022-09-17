import 'package:flutter/material.dart';
import 'package:kas/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buku Kas',
      debugShowCheckedModeBanner: false,
      color: Colors.deepPurple,
      home: const LoginScreen(),
    );
  }
}
