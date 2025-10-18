import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:s_car/screens/scroll_provider.dart';
import 'package:s_car/widgets/sections/service_section.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import '../config/app_colors.dart';
import '../config/app_data.dart';
import '../widgets/responsive_nav_bar.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/why_us_section.dart';
import '../widgets/sections/offers_section.dart';
import '../widgets/sections/testimonials_section.dart';
import '../widgets/sections/footer_section.dart';
import '../widgets/forms/booking_form.dart';

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

  // List of all sections in order
  final List<Widget> _sections = [
    RepaintBoundary(key: NavKeys.heroKey, child: const HeroSection()),
    const SizedBox(height: 80),
    RepaintBoundary(key: NavKeys.serviceKey, child: const ServiceSection()),
    const SizedBox(height: 80),
    RepaintBoundary(key: NavKeys.whyUsKey, child: const WhyUsSection()),
    const Divider(thickness: 0.5, color: Color(0xFFE0E0E0)),
    RepaintBoundary(key: NavKeys.offersKey, child: const OffersSection()),
    const Divider(thickness: 0.5, color: Color(0xFFE0E0E0)),
    RepaintBoundary(
        key: NavKeys.testimonialsKey, child: const TestimonialsSection()),
    const SizedBox(height: 80),
    RepaintBoundary(key: NavKeys.bookingKey, child: const BookingForm()),
    const SizedBox(height: 80),
    const FooterSection(),
  ];

  @override
  Widget build(BuildContext context) {
    final scrollPvd = Provider.of<ScrollProvider>(context, listen: false);

    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        final isMobile = sizingInfo.isMobile;

        // 1. Define the base SingleChildScrollView that contains all page content
        final scrollableContent = SingleChildScrollView(
          controller: scrollPvd.scrollController,
          // CRITICAL FIX: Use default physics for mobile to enable touch scrolling
          // Only disable physics on desktop/web where WebSmoothScroll takes over
          physics: isMobile
              ? const AlwaysScrollableScrollPhysics() // Allows native touch scrolling
              : const NeverScrollableScrollPhysics(), // Disables native scrolling for WebSmoothScroll
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _sections,
          ),
        );

        // 2. Conditionally wrap content in WebSmoothScroll
        Widget finalBody;
        if (isMobile) {
          // On mobile, use the standard scrollable content
          finalBody = scrollableContent;
        } else {
          // On desktop/tablet, wrap with WebSmoothScroll for smooth animation
          finalBody = WebSmoothScroll(
            controller: scrollPvd.scrollController,
            scrollSpeed: 2.1,
            scrollAnimationLength: 800,
            curve: Curves.easeInOutCubic,
            child: scrollableContent,
          );
        }

        return Scaffold(
          // AppBar handles the Burger icon automatically
          appBar: ResponsiveNavBar(navItems: _navItems),

          // Use endDrawer: to show the icon on the right side of the AppBar
          endDrawer: isMobile
              ? _buildModernEndDrawer(context, _navItems, scrollPvd)
              : null, // No drawer on tablet or desktop

          body: finalBody,
        );
      },
    );
  }

  // --- Modern EndDrawer Implementation (Unchanged, provided for completeness) ---
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
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
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
