import 'package:flutter/material.dart';
import 'screens/landing_page.dart';

void main() {
  runApp(const CarWashApp());
}

class CarWashApp extends StatelessWidget {
  const CarWashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speedy Clean Car Wash Booking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Primary color consistent with the car wash theme
        primaryColor: const Color(0xFF1565C0),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: const Color(0xFF0D47A1), // Darker Blue for accents
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.w900, fontSize: 32),
          titleMedium: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
          bodyMedium: TextStyle(fontSize: 16),
        ),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}
