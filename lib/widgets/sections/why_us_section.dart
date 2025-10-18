import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart'; // import hovering package
import '../../config/app_colors.dart';
import '../../config/app_data.dart';

class WhyUsSection extends StatelessWidget {
  const WhyUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Map<String, dynamic>> features = featuresForWhyus;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      width: double.infinity,
      child: Column(
        children: [
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
          LayoutBuilder(builder: (context, constraints) {
            int crossAxisCount;
            if (constraints.maxWidth > 900) {
              crossAxisCount = 3;
            } else if (constraints.maxWidth > 600) {
              crossAxisCount = 2;
            } else {
              crossAxisCount = 1;
            }

            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: features.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 24,
                mainAxisSpacing: 32,
                childAspectRatio: 1.9,
              ),
              itemBuilder: (context, index) {
                final feature = features[index];
                return HoverWidget(
                  hoverChild: _buildCard(feature, hovered: true),
                  onHover: (event) {},
                  child: _buildCard(feature),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> feature, {bool hovered = false}) {
    final color = feature['color'] as Color;
    final scale = hovered ? 1.05 : 1.0;
    final shadowOpacity = hovered ? 0.3 : 0.13;

    return AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Card(
        elevation: 10,
        shadowColor: color.withOpacity(shadowOpacity),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(shadowOpacity),
                      blurRadius: hovered ? 20 : 14,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(18),
                child: Icon(feature['icon'] as IconData,
                    color: Colors.white, size: 32),
              ),
              const SizedBox(height: 22),
              Text(
                feature['title'] as String,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                feature['desc'] as String,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
