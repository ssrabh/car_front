import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:s_car/screens/scroll_provider.dart';
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
    {'title': 'Why Us', 'key': NavKeys.whyUsKey},
    {'title': 'Offers', 'key': NavKeys.offersKey},
    {'title': 'Reviews', 'key': NavKeys.testimonialsKey},
    {'title': 'Book Now', 'key': NavKeys.bookingKey},
  ];

  @override
  Widget build(BuildContext context) {
    final scrollPvd = Provider.of<ScrollProvider>(context, listen: false);

    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        final isMobile = sizingInfo.isMobile;

        return Scaffold(
          appBar: ResponsiveNavBar(navItems: _navItems),
          drawer: isMobile
              ? Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      const DrawerHeader(
                        decoration: BoxDecoration(color: AppColors.primaryBlue),
                        child: Text(
                          'Speedy Clean',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      ..._navItems.map((item) {
                        return ListTile(
                          title: Text(item['title']),
                          onTap: () {
                            Navigator.pop(context);
                            scrollPvd.scrollTo(item['key']);
                          },
                        );
                      }),
                    ],
                  ),
                )
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
    );
  }
}
