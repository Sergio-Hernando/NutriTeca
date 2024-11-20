import 'package:flutter/material.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';

class SupermarketDropdown extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?>? onChanged;

  const SupermarketDropdown({
    Key? key,
    required this.onChanged,
    this.selectedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> supermarkets = [
      'Mercadona',
      'Lidl',
      'Aldi',
      'Eroski',
      'Dia',
      'Alcampo'
    ];

    return DropdownButtonFormField<String>(
      value: selectedValue,
      onChanged: onChanged,
      items: supermarkets
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
          .toList(),
      decoration: InputDecoration(
        labelText: context.localizations.supermarket,
        filled: true,
        fillColor: AppColors.secondaryAccent,
        labelStyle: const TextStyle(color: AppColors.background),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.background),
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
      ),
    );
  }
}
