// lib/main.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'config/app_colors.dart';
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
        // Modern Font: Poppins or Inter is common for SPAs
        fontFamily: GoogleFonts.poppins().fontFamily,
        primaryColor: AppColors.primaryBlue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryBlue,
          primary: AppColors.primaryBlue,
          secondary: AppColors.secondaryBlue,
          // Set light background color
          background: AppColors.backgroundLight,
        ).copyWith(
          secondary: AppColors.secondaryBlue,
        ),
        // Global Card Style: Flat design with subtle rounded corners
        cardTheme: CardTheme(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        useMaterial3: true,
      ),
      home: LandingPage(),
    );
  }
}
