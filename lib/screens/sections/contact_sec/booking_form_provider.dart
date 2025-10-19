import 'package:flutter/material.dart';
import 'package:s_car/config/utils.dart';
import 'package:s_car/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'booking_model.dart';

class BookingFormProvider extends ChangeNotifier {
  ApiService apiService = ApiService();

  // Form state
  bool isSubmitting = false;
  String? fullName;
  String? email;
  String? phone;
  String? vehicleType;
  List<String> selectedServices = [];
  DateTime? preferredDate;
  TimeOfDay? preferredTime;
  String? message;

  // --- New constant for WhatsApp Contact Number ---
  // Replace this with your actual phone number including the country code (without + or 00).
  // Example: '919876543210' for an Indian number
  static const String whatsappNumber = '12345678900';

  // Setters for each form field (used by Form onSaved)
  void setFullName(String? val) {
    fullName = val;
    notifyListeners();
  }

  void setEmail(String? val) {
    email = val;
    notifyListeners();
  }

  void setPhone(String? val) {
    phone = val;
    notifyListeners();
  }

  void setVehicleType(String? val) {
    vehicleType = val;
    notifyListeners();
  }

  void setPreferredDate(DateTime val) {
    preferredDate = val;
    notifyListeners();
  }

  void setPreferredTime(TimeOfDay val) {
    preferredTime = val;
    notifyListeners();
  }

  void setMessage(String? val) {
    message = val;
    notifyListeners();
  }

  void toggleService(String service) {
    if (selectedServices.contains(service)) {
      selectedServices.remove(service);
    } else {
      selectedServices.add(service);
    }
    notifyListeners();
  }

  void resetForm() {
    isSubmitting = false;
    fullName = email = phone = vehicleType = message = null;
    selectedServices = [];
    preferredDate = null;
    preferredTime = null;
    notifyListeners();
  }

  bool validate() {
    return fullName != null &&
        email != null &&
        phone != null &&
        vehicleType != null &&
        selectedServices.isNotEmpty &&
        preferredDate != null &&
        preferredTime != null;
  }

  // --- New method to launch WhatsApp with pre-filled booking data ---
  Future<void> launchWhatsAppBooking(BuildContext context) async {
    // 1. Basic Validation (only essential fields for contact/service)
    if (fullName == null || phone == null || selectedServices.isEmpty) {
      Utils.showSnackBar(
          'Please fill in Name, Phone, and select at least one Service before using WhatsApp.');
      return;
    }

    final String dateString = preferredDate != null
        ? preferredDate!.toString().split(' ')[0]
        : 'Not Specified';
    final String timeString = preferredTime != null
        ? preferredTime!.format(context)
        : 'Not Specified';

    // 2. Format the message
    final String messageBody =
        "Hello, I would like to book a car wash service.\n"
        "--- Booking Details ---\n"
        "Name: $fullName\n"
        "Phone: $phone\n"
        "Vehicle: ${vehicleType ?? 'Not Specified'}\n"
        "Services: ${selectedServices.join(', ')}\n"
        "Date: $dateString\n"
        "Time: $timeString\n"
        "Additional Message: ${message ?? 'None'}";

    // 3. Construct the WhatsApp URL using wa.me for better compatibility
    // Note: The phone number should be passed without any '+' or '00' prefixes.
    final uri = Uri.https(
      'wa.me',
      whatsappNumber,
      {
        'text': messageBody,
      },
    );

    // 4. Launch the URL
    // Use LaunchMode.externalApplication to ensure the native WhatsApp app opens.
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Fallback for web or unexpected errors
      Utils.showSnackBar(
          'Could not open WhatsApp. Please check your app installation or try manually texting $whatsappNumber.');
    }
  }

  Future<bool> createBooking(BuildContext context) async {
    if (!validate()) {
      Utils.showSnackBar('Please fill all required fields including services.');

      return false;
    }

    isSubmitting = true;
    notifyListeners();

    final String formattedDate =
        "${preferredDate!.year}-${preferredDate!.month.toString().padLeft(2, '0')}-${preferredDate!.day.toString().padLeft(2, '0')}";
    final String formattedTime =
        "${preferredTime!.hour.toString().padLeft(2, '0')}:${preferredTime!.minute.toString().padLeft(2, '0')}";

    final booking = Booking(
      name: fullName!,
      email: email!,
      phone: phone!,
      vehicleType: vehicleType!,
      services: List<String>.from(selectedServices),
      preferredDate: formattedDate,
      preferredTime: formattedTime,
      message: message,
    );

    final success = await apiService.createBooking(booking);

    isSubmitting = false;
    notifyListeners();

    if (success) {
      Utils.showSnackBar('Booking successful!');
      resetForm();
      return true;
    } else {
      Utils.showSnackBar('Booking failed, try again later');
      return false;
    }
  }
}
