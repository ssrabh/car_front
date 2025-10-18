import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import '../../config/app_colors.dart';
import '../../config/app_data.dart'; // Assume featuresForWhyus is here

class WhyUsSection extends StatelessWidget {
  const WhyUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Assuming this data structure is available globally
    const List<Map<String, dynamic>> features = featuresForWhyus;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      width: double.infinity,
      child: Column(
        children: [
          // Section Header
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.textDark),
              children: const [
                TextSpan(text: "Why Choose "),
                TextSpan(
                    text: "CarCare?",
                    style: TextStyle(color: AppColors.accentRed)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Eight compelling reasons why we're the best choice for your vehicle's care",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 40),

          // Responsive GridView using MaxCrossAxisExtent for automatic layout
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: features.length,
              // Use MaxCrossAxisExtent for modern, truly responsive grids
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                // Max width of each item (for Mobile: 300, Tablet: 300, Desktop: 300)
                maxCrossAxisExtent: 350.0,
                crossAxisSpacing: 24,
                mainAxisSpacing: 32,
                // **THE FIX**: Set a fixed height (mainAxisExtent) that is tall enough
                // for the card content (Icon + Text + Padding)
                mainAxisExtent: 300.0,
              ),
              itemBuilder: (context, index) {
                final feature = features[index];
                return HoverWidget(
                  hoverChild: _buildCard(feature, hovered: true),
                  onHover: (event) {},
                  child: _buildCard(feature),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> feature, {bool hovered = false}) {
    final color = feature['color'] as Color;
    final scale = hovered ? 1.03 : 1.0; // Reduced scale for subtler effect
    final shadowOpacity = hovered ? 0.4 : 0.15;

    return AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 300), // Smoother animation
      curve: Curves.easeOut,
      child: Card(
        // Modernized Card Style
        elevation: hovered ? 15 : 8, // More distinct elevation on hover
        shadowColor: color.withOpacity(shadowOpacity),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)), // Slightly softer corners
        child: Container(
          // Ensure padding is consistent with the height constraint (300.0)
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Column(
            // Use CrossAxisAlignment.start for a modern text alignment
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Icon Container
              Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(
                      15), // Square/rounded icon background
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(shadowOpacity * 0.8),
                      blurRadius: hovered ? 15 : 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Icon(feature['icon'] as IconData,
                    color: Colors.white, size: 28), // Slightly smaller icon
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                feature['title'] as String,
                style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: AppColors.textDark), // Bolder title
              ),
              const SizedBox(height: 8),

              // Description
              Expanded(
                // Use Expanded here to ensure description doesn't cause overflow if it's long
                child: Text(
                  feature['desc'] as String,
                  textAlign: TextAlign.left, // Left-aligned description
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14, // Slightly smaller description text
                    height: 1.5,
                  ),
                  overflow:
                      TextOverflow.fade, // Handle potential overflow gracefully
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
