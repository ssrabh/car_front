import 'package:flutter/material.dart';
import 'package:s_car/config/app_colors.dart';
import 'package:s_car/screens/sections/service_sec/service_model.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel model;
  const ServiceCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    // Determine if the screen is narrow (e.g., mobile view)
    final isNarrow = MediaQuery.of(context).size.width < 600;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Image Area
          _buildImageArea(),

          // 2. Content Area
          Expanded(
            child: Padding(
              // FIX: Reduced vertical padding from 20.0 to 16.0
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Static Top Content (Title & Subtitle) ---
                  Text(
                    model.title,
                    style: TextStyle(
                      fontSize: isNarrow ? 20 : 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle/Description
                  Text(
                    model.subtitle,
                    style: TextStyle(
                      fontSize: isNarrow ? 14 : 16,
                      color: AppColors.secondaryText,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // FIX: Reduced spacing after subtitle from 16 to 12
                  const SizedBox(height: 12),
                  // --- End Static Top Content ---

                  // 3. Flexible Features List
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: model.data
                            .map((feature) => _buildFeatureItem(feature))
                            .toList(),
                      ),
                    ),
                  ),

                  // 4. Price and CTA (Always positioned at the bottom)
                  // FIX: Reduced spacing before CTA from 16 to 12
                  const SizedBox(height: 12),
                  _buildPriceAndCta(isNarrow),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // FIX: Using AspectRatio instead of a fixed height (160) to make the image height responsive to the card's width.
  Widget _buildImageArea() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: AspectRatio(
        // Common widescreen aspect ratio (16:9). Adjust this value (e.g., to 4/3)
        // if you want a taller image relative to the card's width.
        aspectRatio: 16 / 9,
        child: Image.asset(
          model.imgPath,
          fit: BoxFit.cover,
          // Fallback for missing image path
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[200],
            alignment: Alignment.center,
            child: const Icon(Icons.car_repair,
                size: 50, color: AppColors.secondaryText),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle,
              color: AppColors.primaryGreen, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              feature,
              style: const TextStyle(fontSize: 14, color: AppColors.textDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceAndCta(bool isNarrow) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Wrap the price text in Flexible to prevent horizontal overflow if text is too large
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Starting at",
                style: TextStyle(fontSize: 12, color: AppColors.secondaryText),
              ),
              Text(
                model.price,
                style: TextStyle(
                  fontSize: isNarrow ? 18 : 24,
                  fontWeight: FontWeight.w900,
                  color: AppColors.accentRed,
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Placeholder: This button should likely trigger scrolling to the BookingForm
            // Implement Provider.of<ScrollProvider>(context, listen: false).scrollTo(NavKeys.bookingKey);
            // when full context is available.
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: const Text(
            'Book Now',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
