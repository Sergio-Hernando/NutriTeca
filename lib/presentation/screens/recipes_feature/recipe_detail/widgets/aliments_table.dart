import 'package:flutter/material.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';
import 'package:nutri_teca/core/constants/app_theme.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:nutri_teca/domain/models/aliment_entity.dart';

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
          columns: _buildAlimentsColumns(context),
          rows: _buildAlimentsRows(),
        ),
        if (aliments.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                context.localizations.alimentsEmpty,
                style: AppTheme.detailTextStyle,
              ),
            ),
          ),
      ],
    );
  }

  List<DataColumn> _buildAlimentsColumns(BuildContext context) {
    return [
      DataColumn(
        label: Text(context.localizations.aliment,
            style: AppTheme.detailTextStyle),
      ),
      DataColumn(
        label: Text(context.localizations.quantity,
            style: AppTheme.detailTextStyle),
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
                  initialValue: aliment.quantity,
                  style: AppTheme.detailTextStyle,
                  onChanged: (newValue) {
                    aliment.quantity =
                        int.tryParse(newValue)?.toString() ?? aliment.quantity;
                  },
                )
              : Text(aliment.quantity ?? '', style: AppTheme.detailTextStyle),
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
