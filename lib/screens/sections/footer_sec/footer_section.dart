import 'package:flutter/material.dart';
import 'package:s_car/config/app_colors.dart';
import 'package:s_car/screens/sections/footer_sec/footer_model.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyleHeader = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    final textStyleContent = const TextStyle(
      color: Colors.white70,
      fontSize: 14,
      height: 1.5,
    );

    // Helper to build a standard column section in the footer
    Widget _buildFooterSection({
      required String title,
      required List<Widget> children,
      double width = 180,
    }) {
      return SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: textStyleHeader),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      );
    }

    // List of all main footer columns
    final sections = [
      // 1. Brand & Description
      SizedBox(
        width: 260,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Assuming image path is correct, keep hardcoded image asset here
            Image.asset('assets/images/car_care.png', height: 50),
            const SizedBox(height: 12),
            Text(FooterModelData.brandName,
                style: textStyleHeader.copyWith(fontSize: 20)),
            const SizedBox(height: 8),
            Text(FooterModelData.brandSlogan,
                style: textStyleContent.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(FooterModelData.brandDescription, style: textStyleContent),
          ],
        ),
      ),

      // 2. Services
      _buildFooterSection(
        title: "Services",
        children: FooterModelData.services
            .map((service) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(service, style: textStyleContent),
                ))
            .toList(),
        width: 160,
      ),

      // 3. Contact
      _buildFooterSection(
        title: "Contact",
        children: FooterModelData.contacts
            .map((contact) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Icon(contact.icon, color: Colors.white70, size: 18),
                      const SizedBox(width: 8),
                      Flexible(
                          child: Text(contact.text,
                              style: textStyleContent,
                              overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                ))
            .toList(),
        width: 180,
      ),

      // 4. Business Hours
      _buildFooterSection(
        title: "Business Hours",
        children: [
          Text(FooterModelData.operatingDays, style: textStyleContent),
          const SizedBox(height: 6),
          Text(FooterModelData.operatingHours, style: textStyleContent),
        ],
        width: 160,
      ),
    ];

    return Column(
      children: [
        // --- 1. Top main footer (Navigation & Contact) ---
        Container(
          width: double.infinity,
          color: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
          child: LayoutBuilder(builder: (context, constraints) {
            // For widths < 700, use vertical stacking (Column), else horizontal Wrap
            final isSmall = constraints.maxWidth < 600;

            if (isSmall) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: sections
                    .map((w) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: w,
                        ))
                    .toList(),
              );
            } else {
              return Wrap(
                alignment: WrapAlignment.center,
                spacing: 100, // space between columns
                runSpacing: 30,
                children: sections,
              );
            }
          }),
        ),

        // --- 2. Service Areas Section (Map Placeholder) ---
        Container(
          width: double.infinity,
          color: AppColors.backgroundLight,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.location_on, color: AppColors.accentRed),
                  const SizedBox(width: 8),
                  Text(
                    FooterModelData.serviceAreaTitle,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(FooterModelData.serviceAreaSubtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.black54)),
              const SizedBox(height: 15),
              // Map Placeholder Area
              Container(
                height: 55,
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

        // --- 3. Bottom copyright and links ---
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
                        FooterModelData.copyrightText,
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        children: FooterModelData.bottomLinks
                            .map((link) => Text(link.title,
                                style: const TextStyle(color: Colors.white54)))
                            .toList(),
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          FooterModelData.copyrightText,
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Wrap(
                        spacing: 12,
                        children: FooterModelData.bottomLinks
                            .map((link) => Text(link.title,
                                style: const TextStyle(color: Colors.white54)))
                            .toList(),
                      )
                    ],
                  );
          }),
        ),
      ],
    );
  }
}
