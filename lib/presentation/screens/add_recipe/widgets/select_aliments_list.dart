import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';

class SelectedAlimentsList extends StatelessWidget {
  final List<AlimentEntity> selectedAliments;
  final void Function(int) removeAliment;

  const SelectedAlimentsList({
    required this.selectedAliments,
    required this.removeAliment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return selectedAliments.isNotEmpty
        ? ListView.builder(
            itemCount: selectedAliments.length,
            itemBuilder: (context, index) {
              final alimentId = selectedAliments[index].id ?? 0;
              final alimentName = selectedAliments[alimentId].name;
              final quantity = selectedAliments[alimentId].quantity;
              return Card(
                color: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ListTile(
                  title: Text(
                    '$alimentName, Cantidad: $quantity g',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: AppColors.background),
                    onPressed: () => removeAliment(alimentId),
                  ),
                ),
              );
            },
          )
        : const Center(
            child: Text(
              'No hay alimentos añadidos',
              style: TextStyle(color: AppColors.secondary, fontSize: 24),
            ),
          );
  }
}
