import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyleHeader = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    final textStyleContent = TextStyle(
      color: Colors.white70,
      fontSize: 14,
      height: 1.5,
    );

    return Column(
      children: [
        // Top main footer
        Container(
          width: double.infinity,
          color: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          child: LayoutBuilder(builder: (context, constraints) {
            // For widths < 700, use vertical stacking (Column), else horizontal Wrap
            final isSmall = constraints.maxWidth < 600;
            final sections = [
              // Brand & Description
              SizedBox(
                width: 260,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/car_care.png', height: 50),
                    const SizedBox(height: 12),
                    Text("CarCare",
                        style: textStyleHeader.copyWith(fontSize: 20)),
                    const SizedBox(height: 8),
                    Text("Don't Drive Dirty",
                        style: textStyleContent.copyWith(
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Text("Premium car wash & detailing services across India.",
                        style: textStyleContent),
                  ],
                ),
              ),
              SizedBox(
                width: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Services", style: textStyleHeader),
                    const SizedBox(height: 10),
                    ...[
                      "Foam Wash",
                      "Premium Wash",
                      "Deep Cleaning",
                      "Polishing",
                      "Engine Bay Cleaning",
                      "Subscriptions",
                    ].map((service) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(service, style: textStyleContent),
                        )),
                  ],
                ),
              ),
              SizedBox(
                width: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Contact", style: textStyleHeader),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.phone,
                            color: Colors.white70, size: 18),
                        const SizedBox(width: 8),
                        Flexible(
                            child: Text("+91 88391 99242",
                                style: textStyleContent,
                                overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.chat_bubble_outline,
                            color: Colors.white70, size: 18),
                        const SizedBox(width: 8),
                        Flexible(
                            child: Text("WhatsApp Us",
                                style: textStyleContent,
                                overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.email_outlined,
                            color: Colors.white70, size: 18),
                        const SizedBox(width: 8),
                        Flexible(
                            child: Text("hello@carcaresindia.com",
                                style: textStyleContent,
                                overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Business Hours", style: textStyleHeader),
                    const SizedBox(height: 10),
                    Text("Monday - Sunday", style: textStyleContent),
                    const SizedBox(height: 6),
                    Text("8:00 AM - 8:00 PM", style: textStyleContent),
                  ],
                ),
              ),
            ];
            if (isSmall) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: sections
                    .map((w) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: w,
                        ))
                    .toList(),
              );
            } else {
              return Wrap(
                alignment: WrapAlignment.center,
                spacing: 100, // space between columns
                runSpacing: 18,
                children: sections,
              );
            }
          }),
        ),

        // Service Areas Section
        Container(
          width: double.infinity,
          color: AppColors.backgroundLight,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.location_on, color: Colors.redAccent),
                  SizedBox(width: 8),
                  Text(
                    "Our Service Areas",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text("We serve customers across major Indian cities",
                  style: TextStyle(fontSize: 14, color: Colors.black54)),
              const SizedBox(height: 12),
              Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Interactive map showing service locations will be embedded here",
                  style: TextStyle(color: Colors.black45),
                ),
              ),
            ],
          ),
        ),

        // Bottom copyright and links
        Container(
          width: double.infinity,
          color: Colors.black87,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          child: LayoutBuilder(builder: (context, constraints) {
            return constraints.maxWidth < 500
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "© 2024 CarCare India. All rights reserved. Don't Drive Dirty!",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        children: [
                          Text("Privacy Policy",
                              style: TextStyle(color: Colors.white54)),
                          Text("Terms of Service",
                              style: TextStyle(color: Colors.white54)),
                          Text("FAQ", style: TextStyle(color: Colors.white54)),
                          Text("Careers",
                              style: TextStyle(color: Colors.white54)),
                        ],
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "© 2024 CarCare India. All rights reserved. Don't Drive Dirty!",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Wrap(
                        spacing: 12,
                        children: [
                          Text("Privacy Policy",
                              style: TextStyle(color: Colors.white54)),
                          Text("Terms of Service",
                              style: TextStyle(color: Colors.white54)),
                          Text("FAQ", style: TextStyle(color: Colors.white54)),
                          Text("Careers",
                              style: TextStyle(color: Colors.white54)),
                        ],
                      )
                    ],
                  );
          }),
        ),
      ],
    );
  }
}
