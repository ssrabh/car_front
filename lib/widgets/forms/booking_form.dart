import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../config/app_colors.dart';
import '../../config/app_data.dart';
import '../../services/api_service.dart';
import '../../models/booking_model.dart';

// The key to accessing the form's position in the parent scrollable
final GlobalKey bookingFormKey = GlobalKey();

class BookingForm extends StatefulWidget {
  const BookingForm({super.key});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  // Form Field State
  String _name = '';
  String _email = '';
  String _phone = '';
  String _vehicleType = vehicleTypes.first;
  List<String> _selectedServices = [];
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _message = '';

  bool _isLoading = false;

  // --- Date/Time Pickers (omitted for brevity, assume standard implementation) ---
  Future<void> _selectDate() async {/* ... implementation ... */}
  Future<void> _selectTime() async {/* ... implementation ... */}

  // --- Submission Logic ---
  void _submitForm() async {
    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _selectedTime != null &&
        _selectedServices.isNotEmpty) {
      _formKey.currentState!.save();
      setState(() => _isLoading = true);

      // Format date/time
      final String preferredDate =
          DateFormat('yyyy-MM-dd').format(_selectedDate!);
      final String preferredTime = _selectedTime!.format(context);

      final booking = Booking(
        name: _name,
        email: _email,
        phone: _phone,
        vehicleType: _vehicleType,
        services: _selectedServices,
        preferredDate: preferredDate,
        preferredTime: preferredTime,
        message: _message.isEmpty ? null : _message,
      );

      final success = await _apiService.createBooking(booking);

      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(success ? '✅ Booking confirmed!' : '❌ Booking failed.'),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
        if (success) _resetForm();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please complete all required fields.'),
            backgroundColor: Colors.orange),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _selectedDate = null;
      _selectedTime = null;
      _selectedServices = [];
      _vehicleType = vehicleTypes.first;
      _message = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      key: bookingFormKey, // Key for scrolling
      mobile: (context) => _buildFormContent(false),
      desktop: (context) => _buildFormContent(true),
    );
  }

  Widget _buildFormContent(bool isDesktop) {
    // ... (Your implementation of the form fields: TextFormFields, Dropdown, Chip selection, Date/Time Pickers)
    // Use the helpers from the previous response to structure the form inputs.
    // Use AppColors.primaryBlue for primary colors.

    return Center(
      child: Container(
        padding: EdgeInsets.all(isDesktop ? 64.0 : 20.0),
        constraints:
            BoxConstraints(maxWidth: isDesktop ? 800.0 : double.infinity),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '4. Book Your Appointment',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: AppColors.primaryBlue),
            ),
            const Divider(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Placeholder for your form fields
                  Container(
                    height: 400,
                    color: AppColors.lightBlue,
                    alignment: Alignment.center,
                    child: const Text(
                        "Form Fields Go Here (Use your previous input/picker logic)",
                        style: TextStyle(color: AppColors.primaryBlue)),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _submitForm,
                      icon: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Icon(Icons.calendar_month),
                      label: Text(
                          _isLoading ? 'Processing...' : 'Confirm Booking',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// NOTE: I am omitting the selectDate, selectTime, and helper functions (_buildTextFormField, etc.) 
// to keep this response clean, assuming you will paste them from the first response into this file.