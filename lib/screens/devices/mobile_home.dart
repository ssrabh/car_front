import 'package:flutter/material.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

import 'package:s_car/widgets/navbar.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({super.key});

  @override
  State<MobileHome> createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text("S-Car Wash",
                  style: TextStyle(color: Colors.white, fontSize: 22)),
            ),
            ListTile(title: Text("Home")),
            ListTile(title: Text("Services")),
            ListTile(title: Text("Pricing")),
            ListTile(title: Text("Contact")),
          ],
        ),
      ),
      body: Column(
        children: [
          const NavBar(isMobile: true),
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
                      padding: const EdgeInsets.all(20),
                      color: Colors.lightBlue.shade50,
                      child: const Column(
                        children: [
                          Text(
                            "Premium Car Wash Service",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Book your wash, oil change, or detailing easily!",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                              onPressed: null, child: Text("Book Now")),
                        ],
                      ),
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
