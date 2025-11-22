import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Florist Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Color(0xFFF48FB1), // Soft pink
          secondary: Color(0xFF81C784), // Soft green
          background: Color(0xFFFAFAFA),
        ),
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}