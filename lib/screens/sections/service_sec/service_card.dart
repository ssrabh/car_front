import 'package:flutter/material.dart';
import 'package:s_car/config/app_colors.dart';
import 'package:s_car/screens/sections/service_sec/service_model.dart';
// Note: We don't need to explicitly import 'package:hovering/hovering.dart'
// here, as we are using the native Flutter MouseRegion/StatefulWidget approach,
// which provides more control over the transition.
// import 'package:s_car/screens/sections/service_sec/service_model.dart'; // Assume model import is handled

// Convert to StatefulWidget to manage hover state
class ServiceCard extends StatefulWidget {
  final ServiceModel model;
  const ServiceCard({super.key, required this.model});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  // State variable to track if the mouse is hovering over the card
  bool _isHovering = false;

  // Determines if this is the special "Best Value" card
  bool get isBestValueCard => widget.model.id == 'best_value';

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 600;

    // Use MouseRegion to detect hover events
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250), // Smooth transition
        curve: Curves.easeInOut,

        // Conditional Styling based on hover state
        transform: _isHovering
            ? Matrix4.translationValues(0, -8, 0) // Lift the card 8 pixels up
            : Matrix4.identity(),

        decoration: BoxDecoration(
          color: isBestValueCard ? AppColors.accentRed : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              // Adjust shadow color and size based on hover
              color: isBestValueCard
                  ? AppColors.accentRed.withOpacity(_isHovering ? 0.6 : 0.4)
                  : Colors.grey.withOpacity(_isHovering ? 0.3 : 0.15),
              spreadRadius: _isHovering ? 5 : (isBestValueCard ? 4 : 2),
              blurRadius: _isHovering ? 20 : (isBestValueCard ? 15 : 10),
              offset: Offset(
                  0,
                  _isHovering
                      ? 10
                      : 5), // Drop the shadow down slightly on hover
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. BEST VALUE Banner (Only for the special card)
            if (isBestValueCard) _buildBestValueBanner(),

            // 2. Image Area (Standard cards only)
            if (!isBestValueCard) _buildImageArea(),

            // 3. Content Area
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: isBestValueCard ? 10.0 : 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Conditional Price/Title for Best Value Card ---
                    if (isBestValueCard) _buildBestValueTitle(isNarrow),
                    // --- Standard Title & Subtitle ---
                    if (!isBestValueCard) ...[
                      Text(
                        widget.model.title,
                        style: TextStyle(
                          fontSize: isNarrow ? 20 : 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Subtitle/Description
                      Text(
                        widget.model.subtitle,
                        style: TextStyle(
                          fontSize: isNarrow ? 14 : 16,
                          color: AppColors.secondaryText,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                    ],
                    // --- End Title/Subtitle ---

                    // 4. Flexible Features List
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.model.data
                              .map((feature) => _buildFeatureItem(feature))
                              .toList(),
                        ),
                      ),
                    ),

                    // 5. Price and CTA (Always positioned at the bottom)
                    const SizedBox(height: 12),
                    isBestValueCard
                        ? _buildBestValueCta()
                        : _buildPriceAndCta(isNarrow),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- New Widgets for Best Value Card ---

  Widget _buildBestValueBanner() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Container(
        height: 80,
        alignment: Alignment.center,
        color: AppColors.accentRed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "OUR BEST VALUE",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  widget.model.price,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Text(
                  " / month",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBestValueTitle(bool isNarrow) {
    // MODIFIED for a more modern look
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  // New: Small icon to draw attention
                  const Icon(Icons.star, color: Colors.yellow, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    widget.model.title,
                    style: TextStyle(
                      fontSize: isNarrow ? 20 : 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Modernized 'POPULAR' Badge (Pill Shape)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                // Increased border radius for a pill shape
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'POPULAR',
                style: TextStyle(
                  color: AppColors.accentRed,
                  fontSize: 11, // Slightly larger font for prominence
                  fontWeight: FontWeight.w900, // Extra bold
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          widget.model.subtitle,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildBestValueCta() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Placeholder: This button should likely trigger scrolling to the BookingForm
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentRed,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            minimumSize: const Size(double.infinity, 48), // Full width button
            side: const BorderSide(
                color: Colors.white, width: 2), // White border for contrast
          ),
          child: const Text(
            'Book Now',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          "Billed Annually. Save an Extra 10%",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontSize: 11),
        ),
      ],
    );
  }

  // --- General Card Widgets ---

  Widget _buildImageArea() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.asset(
          widget.model.imgPath,
          fit: BoxFit.cover,
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
    final featureColor = isBestValueCard ? Colors.white : AppColors.textDark;
    final iconColor = isBestValueCard ? Colors.white : AppColors.primaryGreen;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isBestValueCard)
            Text("• ",
                style: TextStyle(
                    color: iconColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          if (!isBestValueCard)
            Icon(Icons.check_circle, color: iconColor, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              feature,
              style: TextStyle(fontSize: 14, color: featureColor),
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
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Starting at",
                style: TextStyle(fontSize: 12, color: AppColors.secondaryText),
              ),
              Text(
                widget.model.price,
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
