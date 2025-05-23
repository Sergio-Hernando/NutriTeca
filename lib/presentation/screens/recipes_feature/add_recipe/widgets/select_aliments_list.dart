import 'package:flutter/material.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:nutri_teca/domain/models/aliment_entity.dart';

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
              final aliment = selectedAliments
                  .firstWhere((aliment) => aliment.id == alimentId);
              final alimentName = aliment.name;
              final quantity = aliment.quantity;
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
        : Center(
            child: Text(
              context.localizations.noAlimentsAdded,
              style: const TextStyle(color: AppColors.secondary, fontSize: 24),
            ),
          );
  }
}
