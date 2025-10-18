import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:s_car/config/service_data.dart';
import '../config/app_colors.dart';

class ServiceCard extends StatelessWidget {
  final Service service;
  final bool isSpecial; // To style the subscription plan differently

  const ServiceCard({
    super.key,
    required this.service,
    this.isSpecial = false,
  });

  @override
  Widget build(BuildContext context) {
    return HoverWidget(
      hoverChild: _buildCardContent(context, hovered: true),
      onHover: (event) {},
      child: _buildCardContent(context),
    );
  }

  Widget _buildCardContent(BuildContext context, {bool hovered = false}) {
    final scale = hovered ? 1.05 : 1.0;
    final shadowOpacity = hovered ? 0.35 : 0.15;
    final cardColor = isSpecial ? service.color : Colors.white;
    final textColor = isSpecial ? Colors.white : AppColors.textDark;

    return AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: Card(
        elevation: hovered ? 15 : 6,
        shadowColor: service.color.withOpacity(shadowOpacity),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Image or Special Tag
              if (!isSpecial)
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    service.imagePath,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 150,
                      color: Colors.grey.shade200,
                      child: Center(
                        child: Text("Image Missing",
                            style: TextStyle(color: Colors.grey.shade700)),
                      ),
                    ),
                  ),
                ),
              if (isSpecial) ...[
                const Align(
                  alignment: Alignment.topRight,
                  child: Chip(
                    label: Text("OUR BEST VALUE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 10)),
                    backgroundColor: AppColors.accentDeepRed,
                    padding: EdgeInsets.zero,
                  ),
                ),
                Text(
                  service.price,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.brightYellow),
                ),
                const SizedBox(height: 5),
              ],

              const SizedBox(height: 15),

              // 2. Title and Description
              Text(
                service.title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w900,
                    color: textColor,
                    fontSize: 20),
              ),
              const SizedBox(height: 8),
              Text(
                service.description,
                style: TextStyle(
                    color: isSpecial ? Colors.white70 : AppColors.secondaryText,
                    fontSize: 14),
              ),
              const SizedBox(height: 15),

              // 3. Features List
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: service.features.map((feature) {
                    final isStartingPrice = feature.contains('Starting');

                    if (isStartingPrice) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Starting ${service.price}",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: isSpecial
                                ? AppColors.brightYellow
                                : AppColors.accentRed,
                          ),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check_circle_outline,
                              size: 16,
                              color: isSpecial
                                  ? AppColors.primaryGreen
                                  : service.color),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              feature,
                              style: TextStyle(
                                  fontSize: 14, color: textColor, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),

              // 4. CTA Button (for subscription card)
              if (isSpecial)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle subscription booking
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Subscribe Now',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
