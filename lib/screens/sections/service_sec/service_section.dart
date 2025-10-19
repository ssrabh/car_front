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
              // --- Header Title ---
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: AppColors.textDark),
                  children: [
                    TextSpan(
                        text: "${ServiceModelData.mainTitle.split(" ")[0]} "),
                    TextSpan(
                      text: ServiceModelData.mainTitle.substring(
                        ServiceModelData.mainTitle.indexOf(" ") + 1,
                      ),
                      style: const TextStyle(color: AppColors.accentRed),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // --- Subtitle ---
              Text(
                ServiceModelData.subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 50),

              // --- Responsive Grid ---
              ResponsiveGridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ServiceModelData.datalist.length,
                alignment: Alignment.center,
                gridDelegate: ResponsiveGridDelegate(
                  maxCrossAxisExtent: 400,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                  childAspectRatio: ResponsiveValue(
                    context,
                    defaultValue: 0.6,
                    conditionalValues: [
                      const Condition.smallerThan(name: TABLET, value: 0.8),
                      const Condition.between(start: 600, end: 900, value: 0.7),
                    ],
                  ).value,
                ),
                itemBuilder: (context, index) {
                  return ServiceCard(model: ServiceModelData.datalist[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
