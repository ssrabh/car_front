import 'package:flutter/material.dart';
import 'package:s_car/config/utils.dart';
import 'package:s_car/services/api_service.dart';
import '../../models/booking_model.dart';

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
