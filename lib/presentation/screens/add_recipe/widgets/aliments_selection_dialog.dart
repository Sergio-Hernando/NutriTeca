import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';

class AlimentSelectionDialog extends StatefulWidget {
  final List<AlimentEntity> aliments;
  final void Function(int alimentId, String alimentName, int quantity)
      onSelectAliment;

  const AlimentSelectionDialog({
    required this.aliments,
    required this.onSelectAliment,
    Key? key,
  }) : super(key: key);

  @override
  _AlimentSelectionDialogState createState() => _AlimentSelectionDialogState();
}

class _AlimentSelectionDialogState extends State<AlimentSelectionDialog> {
  final TextEditingController quantityController = TextEditingController();
  int? selectedAlimentId;
  late String selectedAlimentName;

  void _handleSelection(int alimentId, String alimentName) {
    setState(() {
      selectedAlimentId = alimentId;
      selectedAlimentName = alimentName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.foreground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: const Text(
        'Seleccionar Alimento',
        style: TextStyle(
          color: AppColors.background,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: AppColors.secondaryAccent,
              ),
              decoration: const InputDecoration(
                labelText: 'Cantidad',
                labelStyle: TextStyle(
                  color: AppColors.secondaryAccent,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.secondary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: widget.aliments.length,
                itemBuilder: (context, index) {
                  final aliment = widget.aliments[index];
                  return ListTile(
                    title: Text(
                      aliment.name,
                      style: TextStyle(
                        color: selectedAlimentId == aliment.id
                            ? AppColors.background
                            : AppColors.secondaryAccent,
                        fontSize: 18.0,
                      ),
                    ),
                    onTap: () =>
                        _handleSelection(aliment.id ?? 0, aliment.name),
                    selected: selectedAlimentId == aliment.id,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.background,
          ),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            final quantity = quantityController.text;
            if (selectedAlimentId != null && quantity.isNotEmpty) {
              widget.onSelectAliment(
                  selectedAlimentId!, selectedAlimentName, int.parse(quantity));
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Por favor, selecciona un alimento y ingresa una cantidad.',
                    style: TextStyle(color: AppColors.foreground),
                  ),
                  backgroundColor: AppColors.secondary,
                ),
              );
            }
          },
          style: TextButton.styleFrom(
            foregroundColor: AppColors.background,
          ),
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
