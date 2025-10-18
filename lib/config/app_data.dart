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

const List<Map<String, dynamic>> featuresForWhyus = [
  {
    'icon': Icons.emoji_events,
    'title': 'Best',
    'desc': 'Industry-leading quality standards and premium service delivery',
    'color': AppColors.accentRed,
  },
  {
    'icon': Icons.shield,
    'title': 'Trust',
    'desc': 'Verified methods and secure processes you can rely on',
    'color': AppColors.primaryGreen,
  },
  {
    'icon': Icons.verified,
    'title': 'Quality',
    'desc': 'Premium products and meticulous attention to every detail',
    'color': AppColors.primaryBlue,
  },
  {
    'icon': Icons.flash_on,
    'title': 'Speed',
    'desc': 'Fast turnaround without compromising on service quality',
    'color': AppColors.accentYellow,
  },
  {
    'icon': Icons.attach_money,
    'title': 'Affordable',
    'desc': 'Competitive pricing with unmatched value for your money',
    'color': AppColors.primaryGreen,
  },
  {
    'icon': Icons.person,
    'title': 'Professional',
    'desc': 'Trained experts with years of automotive care experience',
    'color': AppColors.accentBlue,
  },
  {
    'icon': Icons.lightbulb_outline,
    'title': 'Innovative',
    'desc': 'Latest techniques and eco-friendly cleaning solutions',
    'color': AppColors.accentPurple,
  },
  {
    'icon': Icons.memory,
    'title': 'Hi-Tech',
    'desc': 'Advanced equipment and modern cleaning technology',
    'color': AppColors.primaryCyan,
  },
];

// --- Global Keys for Navigation (Fixes the Null Error) ---
class NavKeys {
  static final GlobalKey heroKey = GlobalKey(debugLabel: 'hero');
  static final GlobalKey serviceKey = GlobalKey(debugLabel: 'service');
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

final List<Map<String, String>> testimonials = [
  {
    'quote':
        '“Outstanding service! My BMW looks showroom fresh. The team was incredibly professional and the monthly subscription saves me so much time.”',
    'author': 'Rajesh Kumar',
    'details': 'BMW X5 Owner, Mumbai',
    'initial': 'R',
  },
  {
    'quote':
        '“Best car wash in the city! The deep cleaning removed stains I thought were permanent. Monthly subscription is absolutely worth every rupee!”',
    'author': 'Priya Sharma',
    'details': 'Honda City Owner, Delhi',
    'initial': 'P',
  },
  {
    'quote':
        '“Professional service with fair pricing. They saved me 3 hours every weekend and my car always looks perfect. Highly recommend CarCare!”',
    'author': 'Arjun Patel',
    'details': 'Maruti Swift Owner, Bangalore',
    'initial': 'A',
  },
];
