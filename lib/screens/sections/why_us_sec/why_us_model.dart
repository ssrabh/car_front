import 'package:flutter/material.dart';
import 'package:s_car/config/app_colors.dart';

// 1. Data Structure for a single "Why Us" feature card
class WhyUsFeatureModel {
  final IconData icon;
  final Color color;
  final String title;
  final String description;

  WhyUsFeatureModel({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
  });
}

// 2. Static Data Repository for the Why Us Section
class WhyUsModelData {
  static const String mainTitle = "Why Choose CarCare?";
  static const String subTitle =
      "Eight compelling reasons why we're the best choice for your vehicle's care.";

  static List<WhyUsFeatureModel> datalist = [
    WhyUsFeatureModel(
      icon: Icons.access_time_filled,
      color: AppColors.primaryBlue,
      title: "Quick Turnaround",
      description:
          "Get your car serviced and returned to you quickly, minimizing disruption to your day.",
    ),
    WhyUsFeatureModel(
      icon: Icons.eco,
      color: AppColors.primaryGreen,
      title: "Eco-Friendly Products",
      description:
          "We use biodegradable and non-toxic cleaning agents that are safe for your car and the environment.",
    ),
    WhyUsFeatureModel(
      icon: Icons.shield,
      color: AppColors.accentRed,
      title: "Trusted Warranty",
      description:
          "All major services come with a 6-month service warranty for your peace of mind.",
    ),
    WhyUsFeatureModel(
      icon: Icons.people_alt,
      color: AppColors.accentYellow,
      title: "Certified Technicians",
      description:
          "Our staff are highly trained, certified, and passionate about automotive care and detailing.",
    ),
    WhyUsFeatureModel(
      icon: Icons.location_on,
      color: AppColors.primaryBlue,
      title: "Free Pickup & Drop",
      description:
          "We offer convenient door-to-door service within a 10km radius of our service station.",
    ),
    WhyUsFeatureModel(
      icon: Icons.attach_money,
      color: AppColors.primaryGreen,
      title: "Transparent Pricing",
      description:
          "No hidden fees or surprise charges. What you see is exactly what you pay.",
    ),
    WhyUsFeatureModel(
      icon: Icons.car_rental,
      color: AppColors.accentRed,
      title: "Modern Equipment",
      description:
          "We invest in the latest detailing tools and diagnostic equipment for superior results.",
    ),
    WhyUsFeatureModel(
      icon: Icons.subscriptions,
      color: AppColors.accentYellow,
      title: "Exclusive Subscriptions",
      description:
          "Join our membership plans for discounted services and priority booking slots.",
    ),
  ];
}
