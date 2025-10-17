import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      width: double.infinity,
      color: AppColors.secondaryBlue,
      child: Column(
        children: [
          const Text(
            'Speedy Clean Car Wash © 2025',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon:
                      const Icon(Icons.facebook, color: Colors.white, size: 20),
                  onPressed: () {}),
              IconButton(
                  icon: const Icon(Icons.mail, color: Colors.white, size: 20),
                  onPressed: () {}),
              IconButton(
                  icon:
                      const Icon(Icons.message, color: Colors.white, size: 20),
                  onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
