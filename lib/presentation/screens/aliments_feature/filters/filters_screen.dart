import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/extensions/context_extension.dart';
import 'package:food_macros/domain/models/filters_entity.dart';
import 'package:go_router/go_router.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  FilterScreenState createState() => FilterScreenState();
}

class FilterScreenState extends State<FilterScreen> {
  bool highFats = false;
  bool highCarbohydrates = false;
  bool highProteins = false;
  bool highCalories = false;
  String? selectedSupermarket;

//TODO cambiar a lista generica
  final supermarkets = ['Mercadona', 'Alcampo', 'Lidl'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foreground,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.background,
        title: Center(child: Text(context.localizations.filters)),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              final filters = FiltersEntity(
                highFats: highFats,
                highProteins: highProteins,
                highCarbohydrates: highCarbohydrates,
                highCalories: highCalories,
                supermarket: selectedSupermarket,
              );

              context.pop(filters);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration:
                  InputDecoration(labelText: context.localizations.supermarket),
              items: supermarkets.map((supermarket) {
                return DropdownMenuItem<String>(
                  value: supermarket,
                  child: Text(supermarket),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSupermarket = value;
                });
              },
            ),
            SwitchListTile(
              title: Text(context.localizations.filtersHighFat),
              value: highFats,
              onChanged: (value) {
                setState(() {
                  highFats = value;
                });
              },
            ),
            SwitchListTile(
              title: Text(context.localizations.filtersHighProtein),
              value: highProteins,
              onChanged: (value) {
                setState(() {
                  highProteins = value;
                });
              },
            ),
            SwitchListTile(
              title: Text(context.localizations.filtersHighCarbo),
              value: highCarbohydrates,
              onChanged: (value) {
                setState(() {
                  highCarbohydrates = value;
                });
              },
            ),
            SwitchListTile(
              title: Text(context.localizations.filtersHighKcal),
              value: highCalories,
              onChanged: (value) {
                setState(() {
                  highCalories = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
