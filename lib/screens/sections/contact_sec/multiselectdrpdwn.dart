import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_colors.dart';
import 'booking_form_provider.dart';

class MultiSelectDropdown extends StatefulWidget {
  final List<String> items;
  final String label;

  const MultiSelectDropdown(
      {super.key, required this.items, required this.label});

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookingFormProvider>(builder: (context, prov, _) {
      String displayText = prov.selectedServices.isEmpty
          ? 'Select Services'
          : prov.selectedServices.join(', ');

      void _openDialog() {
        showDialog(
          context: context,
          builder: (ctx) {
            // Using Consumer inside the dialog to react to provider changes
            return Consumer<BookingFormProvider>(
              builder: (dialogContext, dialogProv, _) {
                return AlertDialog(
                  title: Text(widget.label),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: widget.items.map((item) {
                        final isSelected =
                            dialogProv.selectedServices.contains(item);
                        return CheckboxListTile(
                          title: Text(item),
                          value: isSelected,
                          activeColor: AppColors.primaryBlue,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (checked) {
                            // CORRECT: Use the provider's official toggle method
                            dialogProv.toggleService(item);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Close'),
                      onPressed: () => Navigator.of(ctx).pop(),
                    )
                  ],
                );
              },
            );
          },
        );
      }

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: InkWell(
          onTap: _openDialog,
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: widget.label,
              prefixIcon:
                  Icon(Icons.cleaning_services, color: AppColors.primaryBlue),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: AppColors.primaryBlue, width: 2),
              ),
              suffixIcon: const Icon(Icons.arrow_drop_down),
            ),
            child: Text(
              displayText,
              style: TextStyle(
                color: prov.selectedServices.isEmpty
                    ? Colors.grey.shade600
                    : Colors.black87,
              ),
            ),
          ),
        ),
      );
    });
  }
}
