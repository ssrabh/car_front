import 'package:flutter/material.dart';
import 'package:s_car/config/app_colors.dart';
import 'package:s_car/screens/sections/testimonial_sec/testimonial_model.dart';

class TestimonialCard extends StatefulWidget {
  // Change type from Map to the Model
  final TestimonialModel testimonial;

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
            // Use model.quote
            Text(widget.testimonial.quote,
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
                    // Use model.initial
                    widget.testimonial.initial,
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
                    // Use model.author
                    Text(widget.testimonial.author,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.textDark)),
                    // Use model.details
                    Text(widget.testimonial.details,
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
