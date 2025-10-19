import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:s_car/config/app_theme.dart';
import 'package:s_car/config/apptheme_pvd.dart';
import 'package:s_car/config/utils.dart';
import 'package:s_car/screens/scroll_provider.dart';
import 'package:s_car/screens/sections/contact_sec/booking_form_provider.dart';

import 'screens/landing_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AppThemePvd(),
      ),
      ChangeNotifierProvider(
        create: (_) => ScrollProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => BookingFormProvider(),
      ),
    ],
    child: const CarWashApp(),
  ));
}

class CarWashApp extends StatelessWidget {
  const CarWashApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appThemePvd = Provider.of<AppThemePvd>(context);
    return MaterialApp(
      title: 'Speedy Clean Car Wash Booking',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: Utils.scaffoldMessengerKey,
      // navigatorKey: Utils.navigatorKey,
      theme: AppThemes.lightTheme.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      darkTheme: AppThemes.darkTheme.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      themeMode: appThemePvd.themeMode,
      home: LandingPage(),
    );
  }
}
