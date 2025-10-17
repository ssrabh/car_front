// Mock data for dropdown and checkboxes
import 'package:flutter/material.dart';

const List<String> vehicleTypes = [
  'Sedan',
  'SUV',
  'Truck',
  'Van',
  'Motorcycle'
];
const List<String> availableServices = [
  'Basic Wash',
  'Premium Wash',
  'Full Detail',
  'Oil Change',
  'Tire Rotation'
];

// Mock data for Festive Offers section
const List<Map<String, dynamic>> festiveOffers = [
  {
    'title': 'Diwali Deep Clean',
    'details':
        '50% off Full Detailing Service. Get your car ready for the festive season!',
    'icon': Icons.local_fire_department,
    'color': Color(0xFFC62828), // Accent Red
  },
  {
    'title': 'New Year Sparkle',
    'details': 'Book any 3 services and get the cheapest one FREE.',
    'icon': Icons.celebration,
    'color': Color(0xFF1565C0), // Primary Blue
  },
  {
    'title': 'Monsoon Protection',
    'details': 'Free Anti-Rust Underbody Coating with every Premium Wash.',
    'icon': Icons.umbrella,
    'color': Color(0xFF0D47A1), // Secondary Blue
  },
];

// Mock data for Testimonials section
const List<Map<String, String>> testimonials = [
  {
    'quote':
        "Best car wash experience! My SUV looks brand new every time. The online booking is incredibly convenient.",
    'author': "Ravi K.",
    'rating': "⭐⭐⭐⭐⭐"
  },
  {
    'quote':
        "I appreciate the attention to detail. I booked a service for oil change and a wash, and they were quick and professional.",
    'author': "Priya S.",
    'rating': "⭐⭐⭐⭐"
  },
  {
    'quote':
        "Smooth scheduling and great service. The festive offer was a huge bonus!",
    'author': "Ajay V.",
    'rating': "⭐⭐⭐⭐⭐"
  },
];

// Mock data for Why Us section
const List<Map<String, dynamic>> whyUsFeatures = [
  {
    'icon': Icons.speed,
    'title': 'Speedy Service',
    'desc':
        'In-and-out fast without compromising quality. Your time is valuable.'
  },
  {
    'icon': Icons.eco,
    'title': 'Premium Eco-Products',
    'desc':
        'Only use eco-friendly and top-tier cleaning agents for your vehicle.'
  },
  {
    'icon': Icons.calendar_month,
    'title': 'Easy Online Booking',
    'desc': '24/7 online scheduling right here on our responsive website.'
  },
];
