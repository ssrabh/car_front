import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:s_car/config/app_colors.dart';
import 'package:s_car/screens/sections/offer_sec/offer_card.dart';
import 'package:s_car/screens/sections/offer_sec/offer_model.dart';

class OffersSection extends StatelessWidget {
  const OffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.accentDeepRed, // Main Red Background
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
      child: Column(
        children: [
          // Header: Festival Special Offers - Using Model Data
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🎉', style: TextStyle(fontSize: 28)),
              const SizedBox(width: 8),
              Text(
                OfferModelData.mainTitle,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            OfferModelData.subTitle,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 40),

          // Offer Cards Layout (Responsive) - Dynamically Generated
          ScreenTypeLayout.builder(
            mobile: (context) => Column(
              children: OfferModelData.offerCards
                  .map((model) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: OfferCard(model: model),
                      ))
                  .toList(),
            ),
            desktop: (context) => Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: OfferModelData.offerCards
                      .map((model) => Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: OfferCard(model: model),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Monthly Subscription Benefits Box - Dynamically Generated
          _SubscriptionBenefitsBox(
              benefits: OfferModelData.subscriptionBenefits),
        ],
      ),
    );
  }
}

// --- Subscription Benefits Box Widget (Now accepts data via constructor) ---

class _SubscriptionBenefitsBox extends StatelessWidget {
  final List<SubscriptionBenefitModel> benefits;
  const _SubscriptionBenefitsBox({required this.benefits});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 800), // Max width for desktop
      decoration: BoxDecoration(
        color: AppColors.accentRed.withOpacity(0.9), // Darker red box
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          Text('Monthly Subscription Benefits',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ScreenTypeLayout.builder(
            mobile: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: benefits
                  .map((b) => _buildBenefitItem(b.iconText, b.label, context))
                  .toList(),
            ),
            desktop: (context) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: benefits
                  .map((b) => _buildBenefitItem(b.iconText, b.label, context))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(
      String iconText, String label, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Column(
        children: [
          Text(iconText,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w900)),
          const SizedBox(height: 5),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.white70)),
        ],
      ),
    );
  }
}
