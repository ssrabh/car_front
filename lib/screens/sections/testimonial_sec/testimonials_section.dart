import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:s_car/config/app_colors.dart';
import 'package:s_car/screens/sections/testimonial_sec/testimonial_card.dart';
import 'package:s_car/screens/sections/testimonial_sec/testimonial_model.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the full list of testimonial models
    final data = TestimonialModelData.datalist;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
      child: Column(
        children: [
          // Header
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.textDark,
                  ),
              children: const <TextSpan>[
                TextSpan(text: 'Happy '),
                TextSpan(
                    text: 'Customers',
                    style: TextStyle(color: AppColors.accentRed)),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Don\'t just take our word for it - hear from our satisfied customers across India',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.secondaryText),
          ),
          const SizedBox(height: 40),

          // Testimonial Cards Layout (Responsive)
          ScreenTypeLayout.builder(
            // Mobile: Stack vertically
            mobile: (context) => Column(
              children: data
                  .map((t) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TestimonialCard(testimonial: t)))
                  .toList(),
            ),
            // Tablet/Desktop Layout: Uses Wrap for flow control and better spacing
            desktop: (context) => Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20.0, // Horizontal space between cards
                  runSpacing: 20.0, // Vertical space between rows
                  children: data // Use the new data list
                      .map((t) => SizedBox(
                            // Calculate width dynamically to accommodate 3 cards comfortably
                            width:
                                (MediaQuery.of(context).size.width * 0.95 / 3) -
                                    20,
                            child: TestimonialCard(testimonial: t),
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
