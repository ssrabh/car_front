import 'package:flutter/material.dart';

// Model for Contact Items in the footer
class FooterContactModel {
  final IconData icon;
  final String text;
  final String link;

  FooterContactModel({
    required this.icon,
    required this.text,
    required this.link,
  });
}

// Model for Policy/Navigation Links in the footer
class FooterLinkModel {
  final String title;
  final String route;

  FooterLinkModel({
    required this.title,
    required this.route,
  });
}

// Data Repository for the Footer Section
class FooterModelData {
  // --- Branding Section ---
  static const String brandName = "CarCare";
  static const String brandSlogan = "Don't Drive Dirty";
  static const String brandDescription =
      "Premium car wash & detailing services across India.";

  // Note: Image asset 'assets/images/car_care.png' is hardcoded in the UI, but its height is 50.

  // --- Services Section ---
  static List<String> services = [
    "Foam Wash",
    "Premium Wash",
    "Deep Cleaning",
    "Polishing",
    "Engine Bay Cleaning",
    "Subscriptions",
  ];

  // --- Contact Section ---
  static List<FooterContactModel> contacts = [
    FooterContactModel(
      icon: Icons.phone,
      text: "+91 88391 99242",
      link: "tel:+918839199242",
    ),
    FooterContactModel(
      icon: Icons.chat_bubble_outline,
      text: "WhatsApp Us",
      link: "https://wa.me/918839199242",
    ),
    FooterContactModel(
      icon: Icons.email_outlined,
      text: "hello@carcaresindia.com",
      link: "mailto:hello@carcaresindia.com",
    ),
  ];

  // --- Business Hours Section ---
  static const String operatingDays = "Monday - Sunday";
  static const String operatingHours = "8:00 AM - 8:00 PM";

  // --- Copyright/Bottom Bar ---
  static const String copyrightText =
      "© 2024 CarCare India. All rights reserved. Don't Drive Dirty!";

  static List<FooterLinkModel> bottomLinks = [
    FooterLinkModel(title: "Privacy Policy", route: "/privacy"),
    FooterLinkModel(title: "Terms of Service", route: "/terms"),
    FooterLinkModel(title: "FAQ", route: "/faq"),
    FooterLinkModel(title: "Careers", route: "/careers"),
  ];

  // --- Service Areas Section ---
  static const String serviceAreaTitle = "Our Service Areas";
  static const String serviceAreaSubtitle =
      "We serve customers across major Indian cities";
}
