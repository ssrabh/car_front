import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:s_car/config/nav_keys.dart';
import 'package:s_car/screens/sections/contact_sec/booking_form.dart';
import 'package:s_car/screens/scroll_provider.dart';
import 'package:s_car/screens/sections/offer_sec/offers_section.dart';
import 'package:s_car/screens/sections/service_sec/service_section.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import 'package:responsive_framework/responsive_framework.dart'; // Import for Breakpoints
import '../config/app_colors.dart';
import 'responsive_nav_bar.dart';
import 'sections/hero_section.dart';
import 'sections/why_us_sec/why_us_section.dart';
import 'sections/testimonial_sec/testimonials_section.dart';
import 'sections/footer_sec/footer_section.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  final List<Map<String, dynamic>> _navItems = [
    {'title': 'Home', 'key': NavKeys.heroKey},
    {'title': 'Service', 'key': NavKeys.serviceKey},
    {'title': 'Why Us', 'key': NavKeys.whyUsKey},
    {'title': 'Offers', 'key': NavKeys.offersKey},
    {'title': 'Reviews', 'key': NavKeys.testimonialsKey},
    {'title': 'Book Now', 'key': NavKeys.bookingKey},
  ];

  @override
  Widget build(BuildContext context) {
    // 1. Wrap the entire app with ResponsiveBreakpoints
    return ResponsiveBreakpoints.builder(
      breakpoints: [
        // Define breakpoints matching common screen sizes
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ],
      // Provide the responsive layout as the child (remove unsupported `builder` param)
      child: ResponsiveBuilder(
        builder: (context, sizingInfo) {
          final isMobile = sizingInfo.isMobile;
          final scrollPvd = Provider.of<ScrollProvider>(context, listen: false);

          return Scaffold(
            // AppBar handles the Burger icon automatically
            appBar: ResponsiveNavBar(navItems: _navItems),

            // Use endDrawer: to show the icon on the right side of the AppBar
            endDrawer: isMobile
                ? _buildModernEndDrawer(context, _navItems, scrollPvd)
                : null, // No drawer on tablet or desktop

            body: WebSmoothScroll(
              controller: scrollPvd.scrollController,
              scrollSpeed: 2.1,
              scrollAnimationLength: 800,
              curve: Curves.easeInOutCubic,
              child: SingleChildScrollView(
                controller: scrollPvd.scrollController,
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RepaintBoundary(
                        key: NavKeys.heroKey, child: const HeroSection()),
                    const SizedBox(height: 80),
                    RepaintBoundary(
                        key: NavKeys.serviceKey, child: const ServiceSection()),
                    const SizedBox(height: 80),
                    RepaintBoundary(
                        key: NavKeys.whyUsKey, child: const WhyUsSection()),
                    const Divider(thickness: 0.5, color: Color(0xFFE0E0E0)),
                    RepaintBoundary(
                        key: NavKeys.offersKey, child: const OffersSection()),
                    const Divider(thickness: 0.5, color: Color(0xFFE0E0E0)),
                    RepaintBoundary(
                        key: NavKeys.testimonialsKey,
                        child: const TestimonialsSection()),
                    const SizedBox(height: 80),
                    RepaintBoundary(
                        key: NavKeys.bookingKey, child: const BookingForm()),
                    const SizedBox(height: 80),
                    const FooterSection(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // --- Modern EndDrawer Implementation ---
  Widget _buildModernEndDrawer(BuildContext context,
      List<Map<String, dynamic>> navItems, ScrollProvider scrollPvd) {
    return Drawer(
      // Modern design: Remove default padding and use a clean background
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // 1. Custom Drawer Header (Cleaner look)
          Container(
            padding: const EdgeInsets.only(top: 40, bottom: 20, left: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue, // Brand color header
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 3))
              ],
            ),
            child: Row(
              children: [
                // Icon matching the app theme
                const Icon(Icons.car_repair, color: Colors.white, size: 30),
                const SizedBox(width: 10),
                Text(
                  'CARCARE Menu',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),

          // 2. Navigation Links
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: navItems.map((item) {
                // Use ListTile for sections, with subtle hover/splash effect
                return ListTile(
                  title: Text(
                    item['title'] as String,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 16, color: AppColors.secondaryText),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    scrollPvd.scrollTo(item['key']);
                  },
                );
              }).toList(),
            ),
          ),

          // 3. Footer/Contact Button
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // Example action: Open WhatsApp
              },
              icon: const Icon(Icons.message, color: Colors.white),
              label: const Text('Contact Us',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen, // Green for contact
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
