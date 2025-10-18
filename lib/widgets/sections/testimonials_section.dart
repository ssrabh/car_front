import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:s_car/config/app_colors.dart';
import 'package:s_car/config/app_data.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
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
              children: <TextSpan>[
                const TextSpan(text: 'Happy '),
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
            mobile: (context) => Column(
              children: testimonials
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
                  children: testimonials
                      .map((t) => SizedBox(
                            // Each card takes up roughly 1/3 of the space
                            width: (MediaQuery.of(context).size.width / 3) - 30,
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

// --- Dedicated Testimonial Card Widget with Hover Effect ---

class TestimonialCard extends StatefulWidget {
  final Map<String, String> testimonial;

  const TestimonialCard({super.key, required this.testimonial});

  @override
  State<TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends State<TestimonialCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isHovering = true),
      onExit: (event) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            // Subtle shadow when not hovering, more pronounced when hovering
            BoxShadow(
              color: Colors.black.withOpacity(_isHovering ? 0.15 : 0.05),
              blurRadius: _isHovering ? 20 : 10,
              offset: Offset(0, _isHovering ? 10 : 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Essential for dynamic card height
          children: [
            // Star Rating
            Row(
              children: List.generate(
                  5,
                  (index) => const Icon(Icons.star,
                      color: AppColors.accentYellow, size: 18)),
            ),
            const SizedBox(height: 15),

            // Quote
            Text(widget.testimonial['quote']!,
                style: const TextStyle(
                    fontSize: 15.5, color: AppColors.textDark, height: 1.4)),
            const SizedBox(height: 20),

            // Author and Details
            Row(
              children: [
                // Initials Avatar
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.accentRed,
                  child: Text(
                    widget.testimonial['initial']!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                const SizedBox(width: 15),

                // Name and Detail Text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.testimonial['author']!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.textDark)),
                    Text(widget.testimonial['details']!,
                        style: const TextStyle(
                            fontSize: 13, color: AppColors.secondaryText)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
