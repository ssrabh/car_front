import 'package:flutter/material.dart';
import 'package:s_car/config/app_colors.dart';

// --- 1. Offer Card Model (For promotions like 50% Off or Monthly Deal) ---
class OfferCardModel {
  final String primaryText; // e.g., "50% OFF" or "₹999"
  final String
      secondaryText; // e.g., "First Premium Wash" or "Monthly Subscription Deal"
  final String description;
  final String callToAction; // e.g., "Use Code: FIRST50" or "Limited Time Only"
  final Color actionColor; // Background color for the CTA/Code box
  final Color
      primaryTextColor; // Color for the large text (e.g., AppColors.brightRed)

  OfferCardModel({
    required this.primaryText,
    required this.secondaryText,
    required this.description,
    required this.callToAction,
    required this.actionColor,
    required this.primaryTextColor,
  });
}

// --- 2. Subscription Benefit Item Model (For the box at the bottom) ---
class SubscriptionBenefitModel {
  final String iconText; // e.g., "∞", "2", "40%"
  final String label; // e.g., "Unlimited Basic Washes"

  SubscriptionBenefitModel({
    required this.iconText,
    required this.label,
  });
}

// --- 3. Static Data Repository for the Offers Section ---
class OfferModelData {
  static const String mainTitle = "Festival Special Offers";
  static const String subTitle =
      "Limited time deals you absolutely can't miss!";

  // Data for the main promotional cards
  static List<OfferCardModel> offerCards = [
    OfferCardModel(
      primaryText: '50% OFF',
      secondaryText: 'First Premium Wash',
      description:
          'New customers get 50% off their first premium wash service - perfect way to try our premium quality.',
      callToAction: 'Use Code: FIRST50',
      actionColor: AppColors.yellowCode,
      primaryTextColor: AppColors.brightRed,
    ),
    OfferCardModel(
      primaryText: '₹999',
      secondaryText: 'Monthly Subscription Deal',
      description:
          'Subscribe now and get your first month at ₹999 only (Regular: ₹2,499) - Save ₹1,500!',
      callToAction: 'Limited Time Only',
      actionColor: AppColors.primaryGreen,
      primaryTextColor: AppColors.brightRed,
    ),
  ];

  // Data for the Subscription Benefits box
  static List<SubscriptionBenefitModel> subscriptionBenefits = [
    SubscriptionBenefitModel(
      iconText: '∞',
      label: 'Unlimited Basic Washes',
    ),
    SubscriptionBenefitModel(
      iconText: '2',
      label: 'Premium Washes/Month',
    ),
    SubscriptionBenefitModel(
      iconText: '40%',
      label: 'Total Savings',
    ),
  ];
}
