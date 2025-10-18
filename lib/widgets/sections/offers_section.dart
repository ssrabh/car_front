import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:s_car/config/app_colors.dart';

class OffersSection extends StatelessWidget {
  const OffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.accentDeepRed, // Main Red Background
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Column(
        children: [
          // Header: Festival Special Offers
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🎉', style: TextStyle(fontSize: 28)),
              const SizedBox(width: 8),
              Text(
                'Festival Special Offers',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'Limited time deals absolutely can\'t miss!',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 30),

          // Offer Cards Layout (Responsive)
          ScreenTypeLayout.builder(
            mobile: (context) => const Column(
              children: [
                _FirstOfferCard(),
                SizedBox(height: 20),
                _SecondOfferCard(),
              ],
            ),
            desktop: (context) => const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _FirstOfferCard()),
                SizedBox(width: 20),
                Expanded(child: _SecondOfferCard()),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Monthly Subscription Benefits Box
          const _SubscriptionBenefitsBox(),
        ],
      ),
    );
  }
}

// --- Offer Card Widgets ---

class _OfferCardBase extends StatelessWidget {
  final Widget child;
  const _OfferCardBase({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(25),
      child: child,
    );
  }
}

class _FirstOfferCard extends StatelessWidget {
  const _FirstOfferCard();

  @override
  Widget build(BuildContext context) {
    return _OfferCardBase(
      child: Column(
        children: [
          Text('50% OFF',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.brightRed)),
          const SizedBox(height: 5),
          const Text('First Premium Wash',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87)),
          const SizedBox(height: 15),
          const Text(
              'New customers get 50% off their first premium wash service - perfect way to try our premium quality',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54)),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.yellowCode,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('Use Code: FIRST50',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}

class _SecondOfferCard extends StatelessWidget {
  const _SecondOfferCard();

  @override
  Widget build(BuildContext context) {
    return _OfferCardBase(
      child: Column(
        children: [
          Text('₹999',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.brightRed)),
          const SizedBox(height: 5),
          const Text('Monthly Subscription Deal',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87)),
          const SizedBox(height: 15),
          Text.rich(
            TextSpan(
              text: 'Subscribe now and get your first month at ₹999 only ',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
              children: <TextSpan>[
                TextSpan(
                    text: '(Regular: ₹2,499) - ',
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.black54)),
                TextSpan(
                    text: 'Save ₹1,500!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.brightRed))
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.brightGreen,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('Limited Time Only',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// --- Subscription Benefits Box Widget ---

class _SubscriptionBenefitsBox extends StatelessWidget {
  const _SubscriptionBenefitsBox();

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
              children: [
                _buildBenefitItem('∞', 'Unlimited Basic Washes', context),
                _buildBenefitItem('2', 'Premium Washes/Month', context),
                _buildBenefitItem('40%', 'Total Savings', context),
              ],
            ),
            desktop: (context) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBenefitItem('∞', 'Unlimited Basic Washes', context),
                _buildBenefitItem('2', 'Premium Washes/Month', context),
                _buildBenefitItem('40%', 'Total Savings', context),
              ],
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
