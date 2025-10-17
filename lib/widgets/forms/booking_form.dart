// lib/widgets/forms/booking_form.dart

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../config/app_colors.dart';

class BookingForm extends StatelessWidget {
  const BookingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      color: Colors.white,
      width: double.infinity,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Text(
                'Ready to Book?',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w900, color: AppColors.primaryBlue),
              ),
              const SizedBox(height: 10),
              Text(
                'Fill out the form below to secure your spot now.',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 40),
              // Use a Card for a contained, modern look
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ScreenTypeLayout.builder(
                    mobile: (context) => _buildFormContent(context, false),
                    desktop: (context) => _buildFormContent(context, true),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormContent(BuildContext context, bool isDesktop) {
    // This is the common widget used for all form fields
    Widget field(String label, IconData icon) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: AppColors.primaryBlue),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.primaryBlue, width: 2),
            ),
          ),
        ),
      );
    }

    // List of all fields
    final List<Widget> formFields = [
      field('Full Name', Icons.person),
      field('Email Address', Icons.email),
      field('Phone Number', Icons.phone),
      field('Vehicle Type (e.g., Sedan, SUV)', Icons.directions_car),
      field('Preferred Date', Icons.calendar_today),
      field('Preferred Time', Icons.schedule),
    ];

    if (isDesktop) {
      // Desktop: Two columns layout
      return Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 0, // Handled by Padding in field()
              childAspectRatio: 3.5,
            ),
            itemCount: formFields.length,
            itemBuilder: (context, index) => formFields[index],
          ),
          _buildSubmitButton(context),
        ],
      );
    } else {
      // Mobile: Single column layout
      return Column(
        children: [...formFields, _buildSubmitButton(context)],
      );
    }
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle form submission logic
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Booking request sent!')));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accentRed,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text('Confirm Booking',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }
}
