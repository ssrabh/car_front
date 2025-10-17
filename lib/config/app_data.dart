// Mock data for dropdown and checkboxes
import 'package:flutter/material.dart';
import 'package:s_car/config/app_colors.dart';

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

// --- Global Keys for Navigation (Fixes the Null Error) ---
class NavKeys {
  static final GlobalKey heroKey = GlobalKey(debugLabel: 'hero');
  static final GlobalKey whyUsKey = GlobalKey(debugLabel: 'whyUs');
  static final GlobalKey offersKey = GlobalKey(debugLabel: 'offers');
  static final GlobalKey testimonialsKey = GlobalKey(debugLabel: 'reviews');
  static final GlobalKey bookingKey = GlobalKey(debugLabel: 'booking');
}

// Global Key for the booking form (used by HeroSection button)
final GlobalKey bookingFormKey = NavKeys.bookingKey;

// --- Section Mock Data ---

const List<Map<String, dynamic>> whyUsFeatures = [
  {
    'icon': Icons.schedule,
    'title': 'Quick Service',
    'desc': 'In & out in under 30 minutes. We value your time.',
  },
  {
    'icon': Icons.eco,
    'title': 'Eco-Friendly',
    'desc': 'Using biodegradable soaps and minimal water waste.',
  },
  {
    'icon': Icons.star_border,
    'title': 'Premium Finish',
    'desc': 'Attention to detail for a streak-free, mirror shine.',
  },
];

const List<Map<String, dynamic>> festiveOffers = [
  {
    'icon': Icons.bolt,
    'title': 'The Turbo Wash',
    'details': '50% off your second car wash this month!',
    'color': AppColors.primaryBlue,
  },
  {
    'icon': Icons.local_fire_department,
    'title': 'Winter Protection',
    'details': 'Free wax upgrade with any premium interior clean.',
    'color': AppColors.accentRed,
  },
  {
    'icon': Icons.card_giftcard,
    'title': 'Loyalty Bonus',
    'details': 'Book 3, get the 4th wash absolutely free!',
    'color': AppColors.accentAmber,
  },
];

const List<Map<String, String>> testimonials = [
  {
    'quote': 'My car has never looked this good! The booking was so easy.',
    'author': 'Sarah K.',
    'rating': '★★★★★',
  },
  {
    'quote':
        'Fast, efficient, and great value. I highly recommend Speedy Clean.',
    'author': 'David L.',
    'rating': '★★★★★',
  },
  {
    'quote': 'The best wash in town, hands down. The staff were friendly too!',
    'author': 'Maria T.',
    'rating': '★★★★☆',
  },
];
