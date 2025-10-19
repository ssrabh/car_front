import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:s_car/config/global_keys.dart';
import 'package:s_car/config/utils.dart';
import '../../config/app_colors.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  // Define the dark background color for this section
  static const Color darkBackground =
      Color(0xFF1B202A); // Matching the image's dark navy

  @override
  Widget build(BuildContext context) {
    // --- FIX: Wrap the container in a Builder and place the key on the Builder.
    // This often resolves the implicit RepaintBoundary conflict. ---
    return Builder(
        // key: NavKeys.heroKey,
        builder: (context) {
      return Container(
        color: darkBackground,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        width: double.infinity,
        child: Center(
          // Constrain max width for desktop for better aesthetics
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: ScreenTypeLayout.builder(
              mobile: (context) => _buildContent(context, false),
              desktop: (context) => _buildContent(context, true),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildContent(BuildContext context, bool isWide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1. Logo and App Name
        Image.asset(
          'assets/images/car_care.png', // Replace with your actual logo path
          height: 100, // Adjust size as needed
        ),
        const SizedBox(height: 30),

        // 2. Large Title (CARCARE)
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: isWide ? 80 : 56, // Large size for impact
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                ),
            children: const <TextSpan>[
              TextSpan(text: 'CAR', style: TextStyle(color: Colors.white)),
              TextSpan(
                  text: 'CARE',
                  style: TextStyle(color: AppColors.accentRed)), // Red accent
            ],
          ),
        ),
        const SizedBox(height: 8),

        // 3. Tagline (DON'T DRIVE DIRTY)
        Text(
          'DON\'T DRIVE DIRTY',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.brightYellow, // Yellow accent color
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 30),

        // 4. Description
        Text(
          'Premium car wash & detailing services that save your time while protecting your investment',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white70,
                fontSize: isWide ? 18 : 16,
                height: 1.5,
              ),
        ),
        const SizedBox(height: 30),

        // 5. CTA Buttons (Responsive Row/Column)
        ScreenTypeLayout.builder(
          mobile: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBookNowButton(isWide),
              const SizedBox(height: 15),
              _buildWhatsAppButton(isWide),
            ],
          ),
          desktop: (context) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBookNowButton(isWide),
              const SizedBox(width: 20),
              _buildWhatsAppButton(isWide),
            ],
          ),
        ),
        const SizedBox(height: 40),

        // 6. Feature List (Sanitized Equipment, etc.)
        _buildFeatureList(isWide),
      ],
    );
  }

  Widget _buildBookNowButton(
    bool isWide,
  ) {
    return ElevatedButton.icon(
      // The button correctly scrolls to the booking form key.
      onPressed: () {
        Utils.scrollToKey(bookingFormKey);
      },
      icon: const Icon(Icons.calendar_month, color: AppColors.textDark),
      label: Text('Book Now',
          style: TextStyle(
              fontSize: isWide ? 18 : 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark)),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.brightYellow, // Yellow background
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
    );
  }

  Widget _buildWhatsAppButton(bool isWide) {
    return ElevatedButton.icon(
      // The button correctly scrolls to the booking form key.
      onPressed: () {
        //  Utils.scrollToKey(bookingFormKey);
      },
      icon: const Icon(Icons.mail, color: Colors.white),
      label: Text('WhatsApp Us',
          style: TextStyle(
              fontSize: isWide ? 18 : 16,
              fontWeight: FontWeight.bold,
              color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryGreen, // Green background
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
    );
  }

  Widget _buildFeatureList(bool isWide) {
    const double spacing = 20.0;
    const List<String> features = [
      'Sanitized Equipment',
      'Eco-Friendly Cleaning',
      'Secure Online Payments',
    ];

    final Widget featureContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: features
          .map((feature) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: spacing / 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_outline,
                        color: AppColors.primaryGreen, size: 18),
                    const SizedBox(width: 6),
                    Text(feature,
                        style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ))
          .toList(),
    );

    // Use Wrap for flow control on smaller screens if Row becomes too long
    if (!isWide) {
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: spacing,
        runSpacing: 10,
        children: features
            .map((feature) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_outline,
                        color: AppColors.primaryGreen, size: 18),
                    const SizedBox(width: 6),
                    Text(feature,
                        style: const TextStyle(color: Colors.white70)),
                  ],
                ))
            .toList(),
      );
    }
    return featureContent;
  }
}
