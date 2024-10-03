import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/constants/app_theme.dart';
import 'package:food_macros/core/extensions/string_extensions.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/presentation/screens/aliment_detail/bloc/aliment_detail_bloc.dart';
import 'package:food_macros/presentation/screens/aliment_detail/bloc/aliment_detail_event.dart';
import 'package:food_macros/presentation/screens/aliment_detail/bloc/aliment_detail_state.dart';
import 'package:go_router/go_router.dart';

class AlimentDetailScreen extends StatelessWidget {
  final AlimentEntity aliment;

  const AlimentDetailScreen({
    required this.aliment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foreground,
      appBar: AppBar(
        title: Center(
            child: Text(aliment.name.capitalize(),
                style: AppTheme.titleTextStyle)),
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () => context
                .read<AlimentDetailBloc>()
                .add(AlimentDetailEvent.deleteAliment(aliment.id ?? 0)),
          ),
        ],
      ),
      body: BlocListener<AlimentDetailBloc, AlimentDetailState>(
          listener: (context, state) {
            if (state.screenStatus.isSuccess()) {
              context.pop();
            } else {}
          },
          child: context
                  .read<AlimentDetailBloc>()
                  .state
                  .screenStatus
                  .isLoading()
              ? const CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.memory(
                          const Base64Decoder().convert(aliment.imageBase64),
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 16),
                        DataTable(
                          columns: const [
                            DataColumn(
                                label: Text('Nutrient',
                                    style: AppTheme.detailTextStyle)),
                            DataColumn(
                                label: Text('Value',
                                    style: AppTheme.detailTextStyle)),
                          ],
                          rows: [
                            _buildDataRow(
                                'Supermarket', aliment.supermarket, ''),
                            _buildDataRow(
                                'Calories', '${aliment.calories}', 'kcal'),
                            _buildDataRow('Fats', '${aliment.fats}'),
                            _buildDataRow(
                                'Saturated Fats', '${aliment.fatsSaturated}'),
                            _buildDataRow('Polyunsaturated Fats',
                                '${aliment.fatsPolyunsaturated}'),
                            _buildDataRow('Monounsaturated Fats',
                                '${aliment.fatsMonounsaturated}'),
                            _buildDataRow('Trans Fats', '${aliment.fatsTrans}'),
                            _buildDataRow(
                                'Carbohydrates', '${aliment.carbohydrates}'),
                            _buildDataRow('Fiber', '${aliment.fiber}'),
                            _buildDataRow('Sugar', '${aliment.sugar}'),
                            _buildDataRow('Proteins', '${aliment.proteins}'),
                            _buildDataRow('Salt', '${aliment.salt}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
    );
  }

  DataRow _buildDataRow(String nutrient, String? value, [String unit = 'g']) {
    String displayValue = (value != 'null') ? '$value $unit' : '-';
    return DataRow(cells: [
      DataCell(Text(nutrient, style: AppTheme.detailTextStyle)),
      DataCell(Text(displayValue, style: AppTheme.detailTextStyle)),
    ]);
  }
}
