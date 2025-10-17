import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../config/app_colors.dart';
import '../../config/app_data.dart';

class OffersSection extends StatelessWidget {
  const OffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      color: AppColors.accentRed.withOpacity(0.05),
      child: Column(
        children: [
          Text('2. Seasonal & Festive Offers',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: AppColors.accentRed)),
          const SizedBox(height: 30),
          ScreenTypeLayout.builder(
            mobile: (context) => Column(
                children: festiveOffers
                    .map((offer) => _buildOfferCard(offer, false))
                    .toList()),
            desktop: (context) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: festiveOffers
                    .map((offer) => _buildOfferCard(offer, true))
                    .toList()),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCard(Map<String, dynamic> offer, bool isWide) {
    final Color offerColor = offer['color'] as Color;
    return Flexible(
      child: Padding(
        padding: isWide
            ? const EdgeInsets.symmetric(horizontal: 10)
            : const EdgeInsets.only(bottom: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: offerColor, width: 3),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(offer['icon'] as IconData, size: 40, color: offerColor),
              const SizedBox(height: 10),
              Text(offer['title'] as String,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: offerColor)),
              const SizedBox(height: 5),
              Text(offer['details'] as String,
                  style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
