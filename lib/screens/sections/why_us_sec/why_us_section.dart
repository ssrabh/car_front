import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:s_car/config/app_colors.dart';
import 'package:s_car/screens/sections/why_us_sec/why_us_model.dart';

class WhyUsSection extends StatelessWidget {
  const WhyUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Use the structured data list
    final data = WhyUsModelData.datalist;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      width: double.infinity,
      child: Column(
        children: [
          // Section Header - Now using data from WhyUsModelData
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.textDark),
              children: [
                TextSpan(text: WhyUsModelData.mainTitle.split(" ")[0] + " "),
                TextSpan(
                    text: WhyUsModelData.mainTitle
                        .substring(WhyUsModelData.mainTitle.indexOf(" ") + 1),
                    style: const TextStyle(color: AppColors.accentRed)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Subtitle - Now using data from WhyUsModelData
          Text(
            WhyUsModelData.subTitle,
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
              itemCount: data.length,
              // Use MaxCrossAxisExtent for modern, truly responsive grids
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                // Max width of each item (for Mobile: 350, Tablet: 350, Desktop: 350)
                maxCrossAxisExtent: 350.0,
                crossAxisSpacing: 24,
                mainAxisSpacing: 32,
                // Fixed height for the card content
                mainAxisExtent: 300.0,
              ),
              itemBuilder: (context, index) {
                final feature = data[index];
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

  // Card now accepts WhyUsFeatureModel instead of Map
  Widget _buildCard(WhyUsFeatureModel feature, {bool hovered = false}) {
    final color = feature.color; // Use feature property directly
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
                // Use feature property directly
                child: Icon(feature.icon, color: Colors.white, size: 28),
              ),
              const SizedBox(height: 20),

              // Title
              // Use feature property directly
              Text(
                feature.title,
                style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: AppColors.textDark), // Bolder title
              ),
              const SizedBox(height: 8),

              // Description
              Expanded(
                // Use feature property directly
                child: Text(
                  feature.description,
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
