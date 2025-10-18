import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:s_car/screens/scroll_provider.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import '../config/app_colors.dart';
import '../config/app_data.dart';
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
    {'title': 'Why Us', 'key': NavKeys.whyUsKey},
    {'title': 'Offers', 'key': NavKeys.offersKey},
    {'title': 'Reviews', 'key': NavKeys.testimonialsKey},
    {'title': 'Book Now', 'key': NavKeys.bookingKey},
  ];

  @override
  Widget build(BuildContext context) {
    final scrollPvd = Provider.of<ScrollProvider>(context);

    return Scaffold(
      body: WebSmoothScroll(
        controller: scrollPvd.scrollController,
        scrollSpeed: 1.8,
        scrollAnimationLength: 800,
        curve: Curves.easeInOutCubic,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          controller: scrollPvd.scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sticky NavBar
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                color: Colors.white.withOpacity(0.95),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Speedy Clean',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 20)),
                    ResponsiveBuilder(
                      builder: (context, sizingInformation) {
                        if (sizingInformation.isDesktop ||
                            sizingInformation.isTablet) {
                          return Row(
                            children: _navItems.map((item) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: TextButton(
                                  onPressed: () =>
                                      scrollPvd.scrollTo(item['key']),
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
                        return PopupMenuButton<GlobalKey>(
                          icon: const Icon(Icons.menu),
                          onSelected: (key) => scrollPvd.scrollTo(key),
                          itemBuilder: (_) => _navItems
                              .map((item) => PopupMenuItem<GlobalKey>(
                                    value: item['key'],
                                    child: Text(item['title']),
                                  ))
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Sections
              RepaintBoundary(key: NavKeys.heroKey, child: const HeroSection()),
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
  }
}
