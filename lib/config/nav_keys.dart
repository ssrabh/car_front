import 'package:flutter/material.dart';

// --- Global Keys for Navigation ---
// Used to scroll to specific sections on button press or navigation link click.
class NavKeys {
  static final GlobalKey heroKey = GlobalKey(debugLabel: 'hero');
  static final GlobalKey serviceKey = GlobalKey(debugLabel: 'service');
  static final GlobalKey whyUsKey = GlobalKey(debugLabel: 'whyUs');
  static final GlobalKey offersKey = GlobalKey(debugLabel: 'offers');
  static final GlobalKey testimonialsKey = GlobalKey(debugLabel: 'reviews');
  // The key for the Booking/Contact section, used by buttons like 'Book Now' and 'WhatsApp'
  static final GlobalKey bookingKey = GlobalKey(debugLabel: 'booking');
}
