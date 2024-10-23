import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_theme.dart';
import 'package:food_macros/core/extensions/context_extension.dart';

class NutrientDataTableWidget extends StatelessWidget {
  final bool isEditing;
  final Map<String, dynamic> controllers;

  const NutrientDataTableWidget({
    Key? key,
    required this.isEditing,
    required this.controllers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(
            label: Text(context.localizations.nutrient,
                style: AppTheme.detailTextStyle)),
        DataColumn(
            label: Text(context.localizations.nutrientValue,
                style: AppTheme.detailTextStyle)),
      ],
      rows: [
        _buildDataRow(context.localizations.calories, controllers['calories']!),
        _buildDataRow(context.localizations.fats, controllers['fats']!),
        _buildDataRow(
            context.localizations.fatsSaturated, controllers['fatsSaturated']!),
        _buildDataRow(context.localizations.fatsPolyunsaturated,
            controllers['fatsPolyunsaturated']!),
        _buildDataRow(context.localizations.fatsMonounsaturated,
            controllers['fatsMonounsaturated']!),
        _buildDataRow(
            context.localizations.fatsTrans, controllers['fatsTrans']!),
        _buildDataRow(
            context.localizations.carbohydrates, controllers['carbohydrates']!),
        _buildDataRow(context.localizations.fiber, controllers['fiber']!),
        _buildDataRow(context.localizations.sugar, controllers['sugar']!),
        _buildDataRow(context.localizations.proteins, controllers['proteins']!),
        _buildDataRow(context.localizations.salt, controllers['salt']!),
      ],
    );
  }

  DataRow _buildDataRow(String nutrient, TextEditingController controller) {
    return DataRow(cells: [
      DataCell(Text(nutrient, style: AppTheme.detailTextStyle, maxLines: 1)),
      DataCell(
        isEditing
            ? TextFormField(
                controller: controller, style: AppTheme.detailTextStyle)
            : Text(controller.text, style: AppTheme.detailTextStyle),
      ),
    ]);
  }
}
