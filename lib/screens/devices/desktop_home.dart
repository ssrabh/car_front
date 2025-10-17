import 'package:flutter/material.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

import 'package:s_car/screens/pricing_page.dart';
import 'package:s_car/screens/service_page.dart';
import 'package:s_car/screens/why_us_page.dart';
import 'package:s_car/widgets/image_widget.dart';
import 'package:s_car/widgets/navbar.dart';

class DeskTopHome extends StatefulWidget {
  const DeskTopHome({super.key});

  @override
  State<DeskTopHome> createState() => _DeskTopHomeState();
}

class _DeskTopHomeState extends State<DeskTopHome> {
  late final ScrollController _scrollController;

  final Map<String, GlobalKey> sectionKeys = {
    "Home": GlobalKey(),
    "Services": GlobalKey(),
    "Pricing": GlobalKey(),
    "Contact": GlobalKey(),
    "BookNow": GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  void _onNavItemSelected(String item) {
    final context = sectionKeys[item]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCirc,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          NavBar(isMobile: false, onItemSelected: _onNavItemSelected),
          Expanded(
            child: WebSmoothScroll(
              controller: _scrollController,
              scrollSpeed: 2.1,
              scrollAnimationLength: 700,
              curve: Curves.easeInOutCirc,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _scrollController,
                child: Column(
                  children: [
                    Container(
                      key: sectionKeys["Home"],
                      height: 480,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 40),
                      color: Colors.lightBlue.shade50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Your Car Deserves The Best Wash",
                                  style:
                                      theme.textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Quick, affordable, and professional car wash services at your doorstep.",
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.local_car_wash),
                                  onPressed: () {},
                                  label: const Text("Book a Service"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 16),
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 60),
                          Expanded(
                            flex: 1,
                            child: Hero(
                              tag: 'hero_car_image',
                              child: ImageWidget(
                                imagePath: 'assets/images/hero_car.png',
                                isImageAsset: true,
                                fallbackAsset: 'assets/images/fallback.png',
                                width: 450,
                                height: 350,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        key: sectionKeys["Services"], child: ServicePage()),
                    Container(
                        key: sectionKeys["Pricing"], child: PricingPage()),
                    Container(key: sectionKeys["Contact"], child: WhyUsPage()),
                    Container(
                      key: sectionKeys["BookNow"],
                      height: 100,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
