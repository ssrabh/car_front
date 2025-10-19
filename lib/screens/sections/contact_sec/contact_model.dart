import 'package:flutter/material.dart';

// Model for a single static contact detail item (e.g., Phone, Email)
class ContactDetailModel {
  final IconData icon;
  final String title;
  final String detail;
  final String? subtitle;

  ContactDetailModel({
    required this.icon,
    required this.title,
    required this.detail,
    this.subtitle,
  });
}

// Data Repository for all static contact and map information
class ContactModelData {
  // Main header text
  static const String mainTitle = "Book Your Service";
  static const String subTitle =
      "Ready to give your car the premium care it deserves? Get started now!";

  // List of static contact details
  static List<ContactDetailModel> contactDetails = [
    ContactDetailModel(
      icon: Icons.phone_enabled,
      title: 'Phone',
      detail: '+91 88381 99242',
    ),
    ContactDetailModel(
      icon: Icons.mail,
      title: 'WhatsApp',
      detail: 'Chat with us instantly',
    ),
    ContactDetailModel(
      icon: Icons.email,
      title: 'Email',
      detail: 'hello@carcareindia.com',
    ),
    ContactDetailModel(
      icon: Icons.schedule,
      title: 'Working Hours',
      detail: 'Monday - Sunday',
      subtitle: '8:00 AM - 8:00 PM',
    ),
  ];

  // Data for the Location box
  static const String mapBoxTitle = 'Our Locations';
  static const String mapBoxSubtitle = 'Interactive map will be embedded here';
}
