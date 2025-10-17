import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../config/app_colors.dart';
import '../../config/app_data.dart';

class WhyUsSection extends StatelessWidget {
  const WhyUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      child: Column(
        children: [
          Text('1. Why Choose Speedy Clean?',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: AppColors.secondaryBlue)),
          const SizedBox(height: 30),
          ScreenTypeLayout.builder(
            mobile: (context) => Column(children: _buildFeatureCards()),
            desktop: (context) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildFeatureCards(isWide: true)),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFeatureCards({bool isWide = false}) {
    return whyUsFeatures.map((feature) {
      return Flexible(
        child: Padding(
          padding: isWide
              ? const EdgeInsets.symmetric(horizontal: 10)
              : const EdgeInsets.only(bottom: 20),
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Icon(feature['icon'] as IconData,
                      size: 40, color: AppColors.primaryBlue),
                  const SizedBox(height: 10),
                  Text(feature['title'] as String,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(feature['desc'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}
