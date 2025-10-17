import 'package:flutter/material.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/why_us_section.dart';
import '../widgets/sections/offers_section.dart';
import '../widgets/sections/testimonials_section.dart';
import '../widgets/sections/footer_section.dart';
import '../widgets/forms/booking_form.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🚗 Speedy Clean Car Wash Booking',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const SingleChildScrollView(
        // Smooth Scrolling is native to SingleChildScrollView with BouncingScrollPhysics
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            HeroSection(),
            WhyUsSection(),
            Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
            OffersSection(),
            Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
            TestimonialsSection(),
            Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
            BookingForm(), // The integrated form component
            FooterSection(),
          ],
        ),
      ),
    );
  }
}
