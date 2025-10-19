import 'package:flutter/material.dart';
import 'package:s_car/config/app_colors.dart';
import 'package:s_car/screens/sections/offer_sec/offer_model.dart';

class OfferCard extends StatelessWidget {
  final OfferCardModel model;

  const OfferCard({super.key, required this.model});

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
      child: Column(
        children: [
          // 1. Primary Text (e.g., 50% OFF)
          Text(model.primaryText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.bold, color: model.primaryTextColor)),
          const SizedBox(height: 5),

          // 2. Secondary Text (e.g., First Premium Wash)
          Text(model.secondaryText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87)),
          const SizedBox(height: 15),

          // 3. Description
          Text.rich(
            _parseDescription(model.description, context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // 4. Call to Action/Code Box
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: model.actionColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(model.callToAction,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // Use white text for green/red/blue CTA, black for yellow
                    color: model.actionColor == AppColors.yellowCode
                        ? Colors.black87
                        : Colors.white)),
          ),
        ],
      ),
    );
  }

  // Utility to handle description styling (e.g., strike-through for price)
  TextSpan _parseDescription(String text, BuildContext context) {
    // Check for pattern like "text (Regular: X) - Save Y!"
    final RegExp priceRegex = RegExp(r'\(([^)]+)\)',
        caseSensitive: false); // Finds text in parentheses
    final match = priceRegex.firstMatch(text);

    if (match != null) {
      final preText = text.substring(0, match.start);
      final strikeText = match.group(1)!;
      final postText = text.substring(match.end);

      return TextSpan(
        text: preText,
        style: const TextStyle(fontSize: 14, color: Colors.black54),
        children: <TextSpan>[
          TextSpan(
              text: '($strikeText)',
              style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.black54)),
          TextSpan(
              text: postText,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.brightRed))
        ],
      );
    }

    // Default return if no special formatting is needed
    return TextSpan(
      text: text,
      style: const TextStyle(fontSize: 14, color: Colors.black54),
    );
  }
}
