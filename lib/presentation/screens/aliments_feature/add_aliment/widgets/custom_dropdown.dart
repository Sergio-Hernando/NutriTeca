import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/extensions/context_extension.dart';

class CustomSupermarketDropdown extends StatelessWidget {
  const CustomSupermarketDropdown({super.key, required this.controllers});

  final Map<String, dynamic> controllers;

  @override
  Widget build(BuildContext context) {
    final list = ['Mercadona', 'Lidl', 'Aldi', 'Eroski', 'Dia', 'Alcampo'];
    return CustomDropdown<String>.search(
      controller: controllers['supermarket'],
      hintText: context.localizations.selectSupermarket,
      items: list,
      excludeSelected: false,
      onChanged: (value) {},
      decoration: CustomDropdownDecoration(
        closedFillColor: AppColors.secondaryAccent,
        expandedFillColor: AppColors.secondaryAccent,
        closedBorderRadius: BorderRadius.circular(30.0),
        hintStyle: const TextStyle(
            color: AppColors.foreground,
            fontFamily: 'Roboto',
            fontSize: 20,
            fontWeight: FontWeight.w500),
        headerStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.normal),
        listItemStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 26,
            fontWeight: FontWeight.normal),
        searchFieldDecoration:
            const SearchFieldDecoration(textStyle: TextStyle(fontSize: 16)),
        listItemDecoration:
            const ListItemDecoration(selectedColor: AppColors.secondary),
        closedSuffixIcon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        expandedSuffixIcon: const Icon(
          Icons.arrow_drop_up,
          color: Colors.white,
        ),
      ),
    );
  }
}
