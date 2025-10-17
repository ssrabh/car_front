import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final bool isMobile;
  final void Function(String)? onItemSelected; // Scroll callback for SPA

  const NavBar({super.key, required this.isMobile, this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.local_car_wash, color: Colors.blueAccent, size: 30),
              const SizedBox(width: 10),
              Text(
                "S-Car Wash",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
          isMobile
              ? IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black87),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                )
              : Row(
                  children: [
                    _navItem("Home"),
                    _navItem("Services"),
                    _navItem("Pricing"),
                    _navItem("Contact"),
                    const SizedBox(width: 25),
                    ElevatedButton(
                      onPressed: () {
                        if (onItemSelected != null) onItemSelected!("BookNow");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text("Book Now"),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _navItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          if (onItemSelected != null) onItemSelected!(title);
        },
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }
}
