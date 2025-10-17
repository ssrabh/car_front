import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../config/app_colors.dart';
import '../forms/booking_form.dart'; // Import the form key

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      color: AppColors.backgroundLight,
      width: double.infinity,
      child: ScreenTypeLayout.builder(
        mobile: (context) => _buildContent(context, false),
        desktop: (context) => _buildContent(context, true),
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isWide) {
    final Widget textContent = Column(
      crossAxisAlignment:
          isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          'Sparkle Your Ride, Stress-Free!',
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            fontSize: isWide ? 48 : 36,
            fontWeight: FontWeight.w900,
            color: AppColors.secondaryBlue,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Effortless online booking for a premium car wash experience. Quick, reliable, and guaranteed shine.',
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: TextStyle(
              fontSize: isWide ? 20 : 16, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () {
            // Scroll logic to jump to the booking form
            Scrollable.ensureVisible(
              bookingFormKey.currentContext!,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOutCubic,
            );
          },
          icon: const Icon(Icons.arrow_downward, color: Colors.white),
          label: const Text('Book Now',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );

    if (isWide) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 3, child: textContent),
          const Expanded(
              flex: 2,
              child: Center(
                  child: Icon(Icons.car_repair,
                      size: 150, color: AppColors.primaryBlue))),
        ],
      );
    } else {
      return textContent;
    }
  }
}
