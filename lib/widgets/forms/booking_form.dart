import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:s_car/widgets/forms/booking_form_provider.dart';
import 'package:s_car/widgets/forms/multiselectdrpdwn.dart';
import '../../config/app_colors.dart';
import '../../config/app_data.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({super.key});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
      BuildContext context, BookingFormProvider prov) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      firstDate: now,
      initialDate: prov.preferredDate ?? now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) {
      prov.setPreferredDate(picked);
      _dateController.text = DateFormat.yMMMMd().format(picked);
    }
  }

  Future<void> _selectTime(
      BuildContext context, BookingFormProvider prov) async {
    final now = TimeOfDay.now();
    final picked = await showTimePicker(
        context: context, initialTime: prov.preferredTime ?? now);
    if (picked != null) {
      prov.setPreferredTime(picked);
      _timeController.text = picked.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingFormProvider(),
      child: Consumer<BookingFormProvider>(builder: (context, prov, _) {
        // Keep form in sync with selected date/time controllers
        _dateController.text = prov.preferredDate == null
            ? ''
            : DateFormat.yMMMMd().format(prov.preferredDate!);
        _timeController.text = prov.preferredTime == null
            ? ''
            : prov.preferredTime!.format(context);

        final formFields = [
          _buildTextField(
            label: 'Full Name',
            icon: Icons.person,
            initialValue: prov.fullName,
            onSaved: prov.setFullName,
            validator: (val) => val == null || val.isEmpty
                ? 'Please enter your full name'
                : null,
          ),
          _buildTextField(
            label: 'Email Address',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            initialValue: prov.email,
            onSaved: prov.setEmail,
            validator: (val) {
              if (val == null || val.isEmpty) return 'Please enter your email';
              final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$');
              if (!emailRegex.hasMatch(val))
                return 'Enter a valid email address';
              return null;
            },
          ),
          _buildTextField(
            label: 'Phone Number',
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            initialValue: prov.phone,
            onSaved: prov.setPhone,
            validator: (val) => val == null || val.isEmpty
                ? 'Please enter your phone number'
                : null,
          ),
          _buildDropdown<String>(
            label: 'Vehicle Type',
            value: prov.vehicleType,
            items: vehicleTypes,
            onChanged: (val) => prov.setVehicleType(val),
          ),
          _buildTextField(
            label: 'Preferred Date',
            icon: Icons.calendar_today,
            controller: _dateController,
            readOnly: true,
            onTap: () => _selectDate(context, prov),
            validator: (val) =>
                val == null || val.isEmpty ? 'Please select a date' : null,
          ),
          _buildTextField(
            label: 'Preferred Time',
            icon: Icons.schedule,
            controller: _timeController,
            readOnly: true,
            onTap: () => _selectTime(context, prov),
            validator: (val) =>
                val == null || val.isEmpty ? 'Please select a time' : null,
          ),
          MultiSelectDropdown(
            items: availableServices,
            label: 'Services',
          ),
          _buildTextField(
            label: 'Additional Message (optional)',
            icon: Icons.message,
            maxLines: 3,
            initialValue: prov.message,
            onSaved: prov.setMessage,
          ),
        ];

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          color: Colors.white,
          width: double.infinity,
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  Text(
                    'Ready to Book?',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.w900,
                          color: AppColors.primaryBlue,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Fill out the form below to secure your spot now.',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 40),
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            ...formFields.map(
                              (e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: e,
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: prov.isSubmitting
                                    ? null
                                    : () async {
                                        if (!_formKey.currentState!.validate())
                                          return;
                                        _formKey.currentState!.save();
                                        await prov.createBooking(context);
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.accentRed,
                                  minimumSize: const Size(double.infinity, 55),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: prov.isSubmitting
                                    ? const SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                            color: Colors.white),
                                      )
                                    : const Text(
                                        'Confirm Booking',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? initialValue,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    int maxLines = 1,
    TextEditingController? controller,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primaryBlue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
        ),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required Function(T?) onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon:
            const Icon(Icons.directions_car, color: AppColors.primaryBlue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item.toString()),
              ))
          .toList(),
      onChanged: (val) => onChanged(val),
      validator: (value) => value == null ? 'Please select $label' : null,
    );
  }
}
