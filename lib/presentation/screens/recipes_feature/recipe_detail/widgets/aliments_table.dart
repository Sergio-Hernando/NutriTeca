import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/constants/app_theme.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';

class AlimentsTable extends StatelessWidget {
  final List<AlimentEntity> aliments;
  final bool isEditing;
  final Function() onAddAliment;
  final Function(AlimentEntity) onRemoveAliment;

  const AlimentsTable({
    Key? key,
    required this.aliments,
    required this.isEditing,
    required this.onAddAliment,
    required this.onRemoveAliment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DataTable(
          columns: _buildAlimentsColumns(),
          rows: _buildAlimentsRows(),
        ),
        if (aliments.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'No hay alimentos en la receta.',
                style: AppTheme.detailTextStyle,
              ),
            ),
          ),
      ],
    );
  }

  List<DataColumn> _buildAlimentsColumns() {
    return [
      const DataColumn(
        label: Text('Alimento', style: AppTheme.detailTextStyle),
      ),
      const DataColumn(
        label: Text('Cantidad', style: AppTheme.detailTextStyle),
      ),
      if (isEditing)
        DataColumn(
          label: IconButton(
            icon: const Icon(Icons.add, color: AppColors.secondaryAccent),
            onPressed: onAddAliment,
          ),
        ),
    ];
  }

  List<DataRow> _buildAlimentsRows() {
    return aliments.map<DataRow>((AlimentEntity aliment) {
      return DataRow(cells: [
        DataCell(
          Text(aliment.name ?? '', style: AppTheme.detailTextStyle),
        ),
        DataCell(
          isEditing
              ? TextFormField(
                  initialValue: '${aliment.quantity}',
                  style: AppTheme.detailTextStyle,
                  onChanged: (newValue) {
                    aliment.quantity =
                        int.tryParse(newValue)?.toString() ?? aliment.quantity;
                  },
                )
              : Text('${aliment.quantity}', style: AppTheme.detailTextStyle),
        ),
        if (isEditing)
          DataCell(
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () => onRemoveAliment(aliment),
            ),
          ),
      ]);
    }).toList();
  }
}
