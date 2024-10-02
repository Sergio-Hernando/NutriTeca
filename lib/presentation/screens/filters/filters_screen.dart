import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';
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

  final supermarkets = ['Mercadona', 'Alcampo', 'Lidl'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foreground,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.background,
        title: const Text('Filters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // Crear un objeto de filtros
              final filters = FiltersEntity(
                highFats: highFats,
                highProteins: highProteins,
                highCarbohydrates: highCarbohydrates,
                highCalories: highCalories,
                supermarket: selectedSupermarket,
              );

              // Devuelve la lista de filtros a la pantalla de búsqueda
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
              decoration: const InputDecoration(labelText: 'Supermercado'),
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
              title: const Text('Altos en grasas'),
              value: highFats,
              onChanged: (value) {
                setState(() {
                  highFats = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Altos en proteínas'),
              value: highProteins,
              onChanged: (value) {
                setState(() {
                  highProteins = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Altos en carbohidratos'),
              value: highCarbohydrates,
              onChanged: (value) {
                setState(() {
                  highCarbohydrates = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Altos en calorías'),
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
