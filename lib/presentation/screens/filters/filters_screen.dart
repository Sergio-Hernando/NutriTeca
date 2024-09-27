import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/presentation/screens/filters/bloc/filters_bloc.dart';
import 'package:food_macros/presentation/screens/filters/bloc/filters_event.dart';
import 'package:food_macros/presentation/screens/filters/bloc/filters_state.dart';
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
  String? selectedSupermarket = '';

  final supermarkets = ['Mercadona', 'Alcampo', 'Lidl'];

  List<AlimentEntity> aliments = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Obtén la lista de alimentos pasada desde SearchScreen
    final args = GoRouterState.of(context).extra as List<AlimentEntity>?;
    if (args != null) {
      aliments = List.from(args);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FiltersBloc, FiltersState>(
      listener: (context, state) {
        if (state.aliments.isNotEmpty) {
          // Cuando los alimentos filtrados estén disponibles, navega de regreso
          Navigator.pop(context, state.aliments);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.foreground,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.background,
          title: const Text('Filters'),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                // Lanza el evento para filtrar alimentos
                context.read<FiltersBloc>().add(FiltersEvent.filterAliments(
                      highFats: highFats,
                      highProteins: highProteins,
                      highCarbohydrates: highCarbohydrates,
                      highCalories: highCalories,
                      supermarket: selectedSupermarket,
                      aliments: aliments,
                    ));

                // Aquí no llamamos directamente a context.pop() porque esperamos al BlocListener
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
      ),
    );
  }
}
