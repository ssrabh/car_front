import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:s_car/screens/sections/contact_sec/contact_model.dart';
import 'package:s_car/screens/sections/contact_sec/booking_form_provider.dart';
import 'package:s_car/screens/sections/contact_sec/multiselectdrpdwn.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_data.dart'; // Still needed for vehicleTypes, availableServices

class BookingForm extends StatefulWidget {
  // We don't need to pass the key explicitly, as bookingFormKey is globally accessible.
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

  // --- Layout Helper Widgets ---

  Widget _buildContactInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: const BoxDecoration(
        color: AppColors.textDark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Get In Touch',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 30),
          // Contact Details List
          ...ContactModelData.contactDetails.map((detail) => Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: detail.icon == Icons.mail
                            ? AppColors.primaryGreen
                            : AppColors.accentRed,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(detail.icon, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          detail.title,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 13),
                        ),
                        Text(
                          detail.detail,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        if (detail.subtitle != null)
                          Text(
                            detail.subtitle!,
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 13),
                          ),
                      ],
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 10),
          // Location Box
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: AppColors.accentBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on,
                    color: AppColors.accentRed, size: 30),
                const SizedBox(height: 5),
                Text(
                  ContactModelData.mapBoxTitle,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  ContactModelData.mapBoxSubtitle,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBookingForm(BuildContext context, BookingFormProvider prov) {
    // Form fields definitions moved inside a helper list
    final formFields = [
      _buildTextField(
        label: 'Full Name',
        icon: Icons.person,
        initialValue: prov.fullName,
        onSaved: prov.setFullName,
        validator: (val) =>
            val == null || val.isEmpty ? 'Please enter your full name' : null,
      ),
      Row(
        children: [
          // Email
          Expanded(
            child: _buildTextField(
              label: 'Email',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              initialValue: prov.email,
              onSaved: prov.setEmail,
              validator: (val) {
                if (val == null || val.isEmpty)
                  return 'Please enter your email';
                final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$');
                if (!emailRegex.hasMatch(val))
                  return 'Enter a valid email address';
                return null;
              },
            ),
          ),
          const SizedBox(width: 16),
          // Phone
          Expanded(
            child: _buildTextField(
              label: 'Phone', // Label adjusted to match image
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              initialValue: prov.phone,
              onSaved: prov.setPhone,
              validator: (val) => val == null || val.isEmpty
                  ? 'Please enter your phone number'
                  : null,
            ),
          ),
        ],
      ),
      // Vehicle Type
      _buildDropdown<String>(
        label: 'Vehicle Type',
        value: prov.vehicleType,
        items: vehicleTypes,
        onChanged: (val) => prov.setVehicleType(val),
      ),

      // Service Checkboxes as per the image
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Services Needed',
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: AppColors.textDark)),
            const SizedBox(height: 5),
            Wrap(
              spacing: 20,
              runSpacing: 10,
              children: [
                ...availableServices.map((service) => SizedBox(
                      width: 180, // Fixed width for alignment
                      child: _buildServiceCheckbox(
                          label: service,
                          value: prov.selectedServices.contains(service),
                          onChanged: (_) => prov.toggleService(service)),
                    )),
              ],
            ),
          ],
        ),
      ),
      Row(
        children: [
          // Preferred Date
          Expanded(
            child: _buildTextField(
              label: 'Preferred Date',
              icon: Icons.calendar_today,
              controller: _dateController,
              readOnly: true,
              onTap: () => _selectDate(context, prov),
              validator: (val) =>
                  val == null || val.isEmpty ? 'Please select a date' : null,
            ),
          ),
          const SizedBox(width: 16),
          // Preferred Time
          Expanded(
            child: _buildTextField(
              label: 'Preferred Time',
              icon: Icons.schedule,
              controller: _timeController,
              readOnly: true,
              onTap: () => _selectTime(context, prov),
              validator: (val) =>
                  val == null || val.isEmpty ? 'Please select a time' : null,
            ),
          ),
        ],
      ),
      // Additional Message
      _buildTextField(
        label: 'Additional Message',
        initialValue: prov.message,
        onSaved: prov.setMessage,
        maxLines: 3,
      ),
      const SizedBox(height: 20),
      // Submit and WhatsApp Buttons
      Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: prov.isSubmitting
                  ? null
                  : () async {
                      if (!_formKey.currentState!.validate()) return;
                      _formKey.currentState!.save();
                      await prov.createBooking(context);
                    },
              icon: prov.isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.black),
                    )
                  : const Icon(Icons.calendar_month, color: Colors.black),
              label: const Text(
                'Book Now',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentYellow,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // Handle WhatsApp link logic here
              },
              icon: const Icon(Icons.mail, color: Colors.white),
              label: const Text(
                'WhatsApp Us',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 15),
      const Text(
        'By booking, you agree to our terms. We use secure online payment.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12, color: Colors.black54),
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ...formFields.map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: e,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Reused Form Field Widgets ---

  Widget _buildTextField({
    required String label,
    IconData? icon,
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
        prefixIcon:
            icon != null ? Icon(icon, color: AppColors.primaryBlue) : null,
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

  Widget _buildServiceCheckbox(
      {required String label,
      required bool value,
      required ValueChanged<bool?> onChanged}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primaryBlue,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Text(label,
            style: const TextStyle(fontSize: 14, color: Colors.black87)),
      ],
    );
  }

  // --- Main Build Method ---

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingFormProvider>(builder: (context, prov, _) {
      // Keep form in sync with selected date/time controllers
      _dateController.text = prov.preferredDate == null
          ? ''
          : DateFormat.yMMMMd().format(prov.preferredDate!);
      _timeController.text =
          prov.preferredTime == null ? '' : prov.preferredTime!.format(context);

      return Container(
        // === CRITICAL FIX: Apply the GlobalKey here so Utils.scrollToKey can find this widget ===
        // key: bookingFormKey,
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        color: AppColors.textDark, // Dark background for the whole section
        width: double.infinity,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              children: [
                // Section Header
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                    children: const <TextSpan>[
                      TextSpan(text: 'Book Your '),
                      TextSpan(
                          text: 'Service',
                          style: TextStyle(color: AppColors.accentRed)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  ContactModelData.subTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(height: 40),

                // Main Content (Contact Info + Form)
                ScreenTypeLayout.builder(
                  mobile: (context) => Column(
                    children: [
                      // Contact Info (Mobile: Full Width, adjusted corners)
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15))),
                        child: _buildContactInfo(context),
                      ),
                      // Booking Form (Mobile: Full Width, adjusted corners)
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(15))),
                        child: _buildBookingForm(context, prov),
                      ),
                    ],
                  ),
                  desktop: (context) => IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Left Column: Contact Info
                        Expanded(flex: 4, child: _buildContactInfo(context)),
                        // Right Column: Booking Form
                        Expanded(
                          flex: 6,
                          child: _buildBookingForm(context, prov),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
