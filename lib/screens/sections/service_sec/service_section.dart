import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:s_car/config/app_colors.dart';
import 'package:s_car/screens/sections/service_sec/service_card.dart';
import 'package:s_car/screens/sections/service_sec/service_model.dart';

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header Title (Now using data from ServiceModelData)
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: AppColors.textDark),
                  children: [
                    TextSpan(
                        text:
                            "${ServiceModelData.mainTitle.split(" ")[0]} "), // "Our"
                    TextSpan(
                        text: ServiceModelData.mainTitle.substring(
                            ServiceModelData.mainTitle.indexOf(" ") +
                                1), // "Professional Services"
                        style: const TextStyle(color: AppColors.accentRed)),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Header Subtitle (Now using data from ServiceModelData)
              Text(
                ServiceModelData.subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 50),

              // Responsive Grid View (Using ResponsiveGridView.builder for better control)
              ResponsiveGridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ServiceModelData.datalist.length,
                alignment: Alignment.center,
                // Define the layout based on screen size
                gridDelegate: ResponsiveGridDelegate(
                  maxCrossAxisExtent: 400, // Max width of a single card
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  // Tweak the aspect ratio for better card presentation
                  childAspectRatio: ResponsiveValue(context,
                      // The new default is slightly shorter to accommodate the package card
                      defaultValue: 0.55,
                      conditionalValues: [
                        const Condition.between(
                            start: 600, end: 900, value: 0.65), // Tablet size
                        const Condition.largerThan(
                            name: TABLET, value: 0.75), // Desktop size
                      ]).value,
                ),
                itemBuilder: (context, index) {
                  return ServiceCard(
                      model: ServiceModelData
                          .datalist[index]); // Use 'model' property
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
