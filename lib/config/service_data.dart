import 'package:flutter/material.dart';

// Service Key constants (used for mapping and navigation if needed)
class ServiceKeys {
  static const String foamWash = 'foam_wash';
  static const String premiumWash = 'premium_wash';
  static const String deepCleaning = 'deep_cleaning';
  static const String rubbingPolishing = 'rubbing_polishing';
  static const String engineDetailing = 'engine_detailing';
  static const String shineAlwaysPlan = 'shine_always_plan';
}

/// Defines the structure for a single service offering.
class Service {
  final String id;
  final String title;
  final String imagePath;
  final String description;
  final String price;
  final List<String> features;
  final Color color; // Used for accent/highlight

  const Service({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.price,
    required this.features,
    required this.color,
  });
}

// Mock service data for standard offerings
const List<Service> mockServices = [
  Service(
    id: ServiceKeys.foamWash,
    title: 'Foam Wash',
    imagePath: 'assets/images/foam.png',
    description:
        'Deep cleaning that removes dirt and grime while being gentle on your paint.',
    price: '₹150',
    features: [
      'Exterior foam wash',
      'Basic rim/tyre clean',
      'Interior vacuum',
      'Starting at', // Marker for starting price text
    ],
    color: Color(0xFF64B5F6), // SkyBlue
  ),
  Service(
    id: ServiceKeys.premiumWash,
    title: 'Premium Wash',
    imagePath: 'assets/images/premium.png',
    description:
        'Complete interior and exterior cleaning with premium products and attention to detail.',
    price: '₹399',
    features: [
      'Exterior foam wash',
      'Interior vacuum',
      'Tire shine application',
      'Glass cleaning',
      'Air freshener',
    ],
    color: Color(0xFF1976D2), // PrimaryBlue
  ),
  Service(
    id: ServiceKeys.deepCleaning,
    title: 'Deep Cleaning',
    imagePath: 'assets/images/deep.png',
    description:
        'Intensive interior and exterior deep clean removing stubborn stains and odors.',
    price: '₹599',
    features: [
      'Complete premium wash',
      'Steam cleaning',
      'Seat shampooing',
      'Odor elimination',
    ],
    color: Color(0xFF0D47A1), // SecondaryBlue
  ),
  Service(
    id: ServiceKeys.rubbingPolishing,
    title: 'Rubbing & Polishing',
    imagePath: 'assets/images/rubbing.png',
    description:
        'Restore your car\'s shine with professional polishing and paint correction.',
    price: '₹1,299',
    features: [
      'Paint correction',
      'Machine polishing',
      'Scratch removal',
      'Protective wax coating',
    ],
    color: Color(0xFFD32F2F), // AccentRed
  ),
  Service(
    id: ServiceKeys.engineDetailing,
    title: 'Engine Detailing',
    imagePath: 'assets/images/engine.png',
    description:
        'Thorough cleaning of the engine compartment and undercarriage for optimal performance.',
    price: '₹499',
    features: [
      'Engine degreasing',
      'Underbody wash',
      'Component protection',
      'Performance boost check',
    ],
    color: Color(0xFF455A64), // CharcoalGray
  ),
];

/// Special subscription plan defined separately for easy access.
const Service subscriptionPlan = Service(
  id: ServiceKeys.shineAlwaysPlan,
  title: 'Shine Always Plan',
  imagePath: 'N/A', // No image needed for the special card
  description:
      'The ultimate maintenance package for a perpetually clean car at our lowest monthly rate.',
  price: '₹799 / month',
  features: [
    'UNLIMITED Basic Foam Washes',
    '2X Premium Interior & Exterior Cleans',
    'Guaranteed Same Day Service (Priority)',
  ],
  color: Color(0xFFD32F2F), // AccentRed for highlight
);
