// lib/screens/landing_page.dart

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../config/app_colors.dart';
import '../config/app_data.dart'; // Import NavKeys here

// Import all your sections (assuming they are in ../widgets/sections)
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/why_us_section.dart';
import '../widgets/sections/offers_section.dart';
import '../widgets/sections/testimonials_section.dart';
import '../widgets/sections/footer_section.dart';
import '../widgets/forms/booking_form.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  // Access the Global Keys from the static NavKeys class
  final List<Map<String, dynamic>> _navItems = [
    {'title': 'Home', 'key': NavKeys.heroKey},
    {'title': 'Why Us', 'key': NavKeys.whyUsKey},
    {'title': 'Offers', 'key': NavKeys.offersKey},
    {'title': 'Reviews', 'key': NavKeys.testimonialsKey},
    {'title': 'Book Now', 'key': NavKeys.bookingKey},
  ];

  // Helper function for smooth scroll to a given key
  void _scrollToKey(GlobalKey key) {
    // FIX: Using key.currentContext! is safe because the keys are attached
    // to widgets in the CustomScrollView which is the main body.
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
        alignment: 0.0, // Scroll to the top of the target widget
      );
    }
  }

  // Desktop Navigation: Row of TextButtons
  Widget _buildDesktopNav(BuildContext context) {
    return Row(
      children: _navItems.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextButton(
            onPressed: () => _scrollToKey(item['key']),
            child: Text(
              item['title'] as String,
              style: const TextStyle(
                color: AppColors.textDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // Mobile Navigation: Menu Icon opening a PopupMenuButton
  Widget _buildMobileMenuIcon(BuildContext context) {
    return PopupMenuButton<GlobalKey>(
      icon: const Icon(Icons.menu),
      onSelected: (key) => _scrollToKey(key),
      itemBuilder: (BuildContext context) {
        return _navItems.map((item) {
          return PopupMenuItem<GlobalKey>(
            value: item['key'] as GlobalKey,
            child: Text(item['title'] as String),
          );
        }).toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Adaptive Sticky Header/AppBar
          SliverAppBar(
            backgroundColor: Colors.white.withOpacity(0.95),
            foregroundColor: AppColors.textDark,
            elevation: 4.0, // More pronounced shadow for modern elevation
            shadowColor: AppColors.secondaryBlue.withOpacity(0.1),
            floating: true,
            pinned: true,
            centerTitle: false,
            title: const Text(
              'Speedy Clean',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),

            // Adaptive Actions
            actions: [
              ResponsiveBuilder(
                builder: (context, sizingInformation) {
                  // Show links on Tablet/Desktop
                  if (sizingInformation.isDesktop ||
                      sizingInformation.isTablet) {
                    return _buildDesktopNav(context);
                  }
                  // Show menu icon on Mobile
                  return _buildMobileMenuIcon(context);
                },
              ),
              const SizedBox(width: 16),
            ],
          ),

          // Main Content List
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // Assign Keys and use generous, consistent spacing
                RepaintBoundary(
                    key: NavKeys.heroKey, child: const HeroSection()),
                const SizedBox(height: 80),

                RepaintBoundary(
                    key: NavKeys.whyUsKey, child: const WhyUsSection()),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  child: Divider(thickness: 0.5, color: Color(0xFFE0E0E0)),
                ),

                RepaintBoundary(
                    key: NavKeys.offersKey, child: const OffersSection()),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  child: Divider(thickness: 0.5, color: Color(0xFFE0E0E0)),
                ),

                RepaintBoundary(
                    key: NavKeys.testimonialsKey,
                    child: const TestimonialsSection()),
                const SizedBox(height: 80),

                // BookingForm section
                RepaintBoundary(
                    key: NavKeys.bookingKey, child: const BookingForm()),
                const SizedBox(height: 80),

                const FooterSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
