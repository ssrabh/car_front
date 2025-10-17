import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../config/app_colors.dart';
import '../../config/app_data.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      child: Column(
        children: [
          Text('3. Hear From Our Happy Customers',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: AppColors.secondaryBlue)),
          const SizedBox(height: 30),
          ScreenTypeLayout.builder(
            mobile: (context) => Column(
                children: testimonials
                    .map((t) => _buildTestimonialCard(t, false))
                    .toList()),
            desktop: (context) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: testimonials
                    .map((t) => _buildTestimonialCard(t, true))
                    .toList()),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(Map<String, String> testimonial, bool isWide) {
    return Flexible(
      child: Padding(
        padding: isWide
            ? const EdgeInsets.symmetric(horizontal: 10)
            : const EdgeInsets.only(bottom: 20),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.grey.shade200)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.format_quote,
                    size: 30, color: AppColors.accentAmber),
                const SizedBox(height: 10),
                Text(testimonial['quote']!,
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, fontSize: 16)),
                const SizedBox(height: 15),
                Text(testimonial['rating']!,
                    style: const TextStyle(
                        fontSize: 18, color: AppColors.accentAmber)),
                const SizedBox(height: 5),
                Text('- ${testimonial['author']!}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
