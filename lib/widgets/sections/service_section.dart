import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:s_car/config/service_card.dart';
import 'package:s_car/config/service_data.dart';
import '../../config/app_colors.dart';

class ServiceSection extends StatelessWidget {
  const ServiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Header
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: AppColors.textDark),
                  children: const [
                    TextSpan(text: "Our "),
                    TextSpan(
                        text: "Premium Services",
                        style: TextStyle(color: AppColors.accentRed)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "From basic wash to premium detailing, we've got your vehicle covered with professional care.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 50),

              // Responsive Grid View
              ScreenTypeLayout.builder(
                mobile: (context) => _buildGrid(context, 1),
                tablet: (context) => _buildGrid(context, 2),
                desktop: (context) => _buildGrid(context, 3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, int crossAxisCount) {
    // Combine standard services and the subscription plan
    final List<Widget> serviceWidgets = mockServices.map((service) {
      return ServiceCard(service: service);
    }).toList();

    // Add the special subscription card at the end
    serviceWidgets.add(ServiceCard(service: subscriptionPlan, isSpecial: true));

    // Calculate mainAxisExtent to ensure all cards have enough space
    // Standard cards need about 450px (Image 150 + Text/Padding 300)
    // Subscription card is slightly shorter but let's standardize
    final double mainAxisExtent = 480;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: serviceWidgets.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: (context, index) {
        return serviceWidgets[index];
      },
    );
  }
}
